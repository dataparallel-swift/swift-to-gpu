import CUDA
import Logging
import NIOConcurrencyHelpers

private let logger = Logger(label: "CachingHostAllocator")

struct BlockDescriptor : Hashable, Equatable {
    let ptr: UnsafeMutableRawPointer
    let ready_event: Event

    @inlinable
    func hash(into hasher: inout Hasher) {
        hasher.combine(ptr)
    }

    @inlinable
    static func == (lhs: BlockDescriptor, rhs: BlockDescriptor) -> Bool {
        lhs.ptr == rhs.ptr
    }
}

/* A thread-safe caching block allocator for pinned host memory
 *
 *   - Allocations are categorised and cached by bin size. A new allocation
 *     request of a given size will only consider cached allocations within the
 *     corresponding bin.
 *
 *   - Bin limits progress geometrically in accordance with the growth factor
 *     `bin_growth` provided during construction. Unused allocations within a
 *     larger bin cache are not reused for allocation requests that categorise
 *     to smaller bin sizes.
 *
 *   - Allocation requests below `bin_growth` ^ `min_bin` are rounded up to
 *     `bin_growth` ^ `min_bin`
 *
 *   - TODO: Allocations above `bin_growth` ^ `max_bin` are not rounded up to the
 *     nearest bin and are simply freed when they are deallocated instead of
 *     being returned to the bin-cache.
 *
 *   - TODO: If the total storage of cached allocations exceeds
 *     `max_cached_bytes`, allocations are freed when they are deallocated
 *     rather than being returned to their bin-cache.
 */
public struct CachingHostAllocator {
    // Because NIOLockedValueBox has reference semantics, we can actually make
    // this a struct (rather than a class) and its fields/member functions
    // non-mutating, and still have the cache shared between users.
    let bin_size_bytes: Array<Int>
    let cached_blocks:  Array<NIOLockedValueBox<Set<BlockDescriptor>>>
    let live_blocks:    NIOLockedValueBox<Dictionary<UnsafeMutableRawPointer, Int?>>

    // Initialise the allocator using the given bin sizes, in bytes. The sizes
    // must be monotonically increasing.
    public init(using bins: Array<Int>) {
        // assert the input is monotonically increasing
        assert(bins.count > 1)
        assert(bins[0] > 0)
        for i in 0..<bins.count - 1 {   // XXX: check this loop disappears in release mode
            assert(bins[i] < bins[i+1])
        }

        logger.trace(".init(using: \(bins))")
        self.cached_blocks  = .init(count: bins.count, generator: { _ in .init(.init()) })
        self.live_blocks    = .init(.init())
        self.bin_size_bytes = bins
    }

    // Initialise the allocator using the given bin parameters. The default
    // parameters delineate five bin sizes: 512B, 4KB, 32KB, 256KB, and 2MB.
    public init(min_bin: Int = 3, max_bin: Int = 7, bin_growth: Int = 8) {
        assert(bin_growth > 1)
        assert(max_bin - min_bin > 0)

        let count = max_bin - min_bin + 1
        let bins  = Array.init(unsafeUninitializedCapacity: count, initializingWith: { buffer, initialisedCount in
            for i in 0..<count{
                buffer[i] = pow(bin_growth, min_bin + i)
            }
            initialisedCount = count
        })

        logger.trace(".init(min_bin: \(min_bin), max_bin: \(max_bin), bin_growth: \(bin_growth)) --> \(bins)")
        self.cached_blocks  = .init(count: bins.count, generator: { _ in .init(.init()) })
        self.live_blocks    = .init(.init())
        self.bin_size_bytes = bins
    }

    func findBin(for value: Int) -> Int? {
        // XXX: We could certainly be clever here--for example, doing binary
        // search or computing the value directly if we initialised the
        // allocator using geometrically increasing bin sizes--but we assume
        // that the number of bins is relatively small and so doing the dumb
        // thing is actually probably fastest.
        for i in 0..<bin_size_bytes.count {
            if value <= bin_size_bytes[i] {
                return i
            }
        }
        return nil
    }

    // Return a suitable allocation for the given size
    public func alloc(_ bytes : Int) -> UnsafeMutableRawPointer {
        var ptr : UnsafeMutableRawPointer? = nil

        if let bin = findBin(for: bytes) {
            // This allocation is within one of the bins that we are caching.

            // First iterate through the cached blocks of the given bin size
            // looking for an allocation that is ready to be reused.
            cached_blocks[bin].withLockedValue() { blocks in
                for block in blocks {
                    if block.ready_event.complete() {
                        blocks.remove(block)
                        ptr = block.ptr
                        break;
                    }
                }
            }

            // Otherwise, allocate a new block.
            if ptr == nil {
                let result = cuMemAllocHost_v2(&ptr, bin_size_bytes[bin])
                switch result {
                    case CUDA_SUCCESS: break
                    case CUDA_ERROR_OUT_OF_MEMORY:
                        // If the allocation fails, free the cached blocks and
                        // try to allocate again
                        logger.trace("Failed to allocate \(bin_size_bytes[bin]) bytes, retrying after freeing cached allocations")
                        self.cleanup()
                        cuda_safe_call{cuMemAllocHost_v2(&ptr, bin_size_bytes[bin])}

                    default:
                        var name : UnsafePointer<CChar>? = nil
                        var desc : UnsafePointer<CChar>? = nil
                        cuGetErrorName(result, &name)
                        cuGetErrorString(result, &desc)
                        fatalError("CUDA call failed with error \(String.init(cString: name!)) (\(result.rawValue)): \(String.init(cString: desc!))")
                }
                logger.trace("Allocated new block at \(ptr!) (\(bin_size_bytes[bin]) bytes)")
            }
            else {
                logger.trace("Reused cached block at \(ptr!) (\(bin_size_bytes[bin]) bytes)")
            }

            assert(ptr != nil, "expected CUDA allocator to never return null-pointer")
            let old = live_blocks.withLockedValue() { $0.updateValue(bin, forKey: ptr!) }
            assert(old == nil, "unexpectedly, block already exists (ptr=\(ptr!))")
        }
        else {
            // This is an allocation larger than the maximum bin size that we
            // are caching. Allocate the request exactly and don't cache it for
            // reuse.
            cuda_safe_call{cuMemAllocHost_v2(&ptr, bytes)}
            let old = live_blocks.withLockedValue() { $0.updateValue(nil, forKey: ptr!) }
            assert(old == nil, "unexpectedly, block already exists (ptr=\(ptr!))")
        }

        // TODO: Check if there any large blocks to remove. This should probably
        // happen in a low-priority background thread (we can force purge if we
        // run out of memory, but we probably don't want to add the overhead of
        // checking on every allocation)

        return ptr!
    }

    // Free a live allocation, returning it to the bin-cache. Once freed, the
    // allocation becomes available for reuse once the given `ready_event` is
    // complete.
    public func free(_ ptr: UnsafeMutableRawPointer, _ ready_event: Event) {
        // Find corresponding block descriptor
        let block = BlockDescriptor(ptr: ptr, ready_event: ready_event)

        live_blocks.withLockedValue() { blocks in
            if let exists = blocks[ptr] {
                blocks.removeValue(forKey: ptr)
                if let bin = exists {
                    _ = cached_blocks[bin].withLockedValue() { $0.insert(block) }
                } else {
                    // This was a large-block allocation. We don't cache these, but just
                    // deallocate them (which still needs to happen asynchronously)
                    // deferred_free.insert(block)
                    fatalError("TODO: asynchronously free large blocks")
                }
            }
            else {
                fatalError("free() called on a value that was either not live, or not managed by this allocator (\(ptr))")
            }
        }
    }

    // Free all currently unused memory
    func cleanup() {
        var num_live_blocks = 0
        var live_bytes = 0

        var num_cached_blocks_outstanding = 0
        var num_cached_blocks_freed = 0

        var cached_bytes_outstanding = 0
        var cached_bytes_freed = 0

        live_blocks.withLockedValue() { blocks in
            num_live_blocks = blocks.count
            live_bytes      = blocks.values.reduce(0, { x, y in x + y! })
        }

        for bin in 0..<bin_size_bytes.count {
            cached_blocks[bin].withLockedValue() { blocks in
                for block in blocks {
                    if block.ready_event.complete() {
                        blocks.remove(block)
                        cuda_safe_call{cuMemFreeHost(block.ptr)}

                        num_cached_blocks_freed += 1
                        cached_bytes_freed += bin_size_bytes[bin]
                    } else {
                        num_cached_blocks_outstanding += 1
                        cached_bytes_outstanding += bin_size_bytes[bin]
                    }
                }
            }
        }

        logger.info("Freed \(num_cached_blocks_freed) blocks (\(cached_bytes_freed) bytes). \(num_cached_blocks_outstanding) cached blocks (\(cached_bytes_outstanding) bytes), \(num_live_blocks) live blocks (\(live_bytes) bytes) outstanding")
    }

    public func destroy() {
        for bin in 0..<bin_size_bytes.count {
            assert(live_blocks.withLockedValue() { $0.count } == 0, "allocator is still holding onto live memory")

            cached_blocks[bin].withLockedValue() { blocks in
                for block in blocks {
                    block.ready_event.sync()
                    blocks.remove(block)
                    cuda_safe_call{cuMemFreeHost(block.ptr)}
                }
            }
        }
    }
}

fileprivate func pow(_ base: Int, _ exp: Int) -> Int
{
    var r: Int = 1
    var b: Int = base
    var e: Int = exp

    while (e > 0) {
        if (e & 1 != 0) {
            r = r * b
        }
        b = b * b
        e = e >> 1
    }
    return r
}

fileprivate extension Array {
    init(count: Int, generator: @escaping (Int) -> Element) {
        precondition(count >= 0, "arrays must have non-negative sizes")
        self.init(
            unsafeUninitializedCapacity: count,
            initializingWith: { buffer, initializedCount in
                for i in 0..<count {
                    buffer[i] = generator(i)
                }
                initializedCount = count
            })
    }
}

// XXX: I have noticed @swift_retain and @swift_release calls in the generated
// LLVM, but we don't want this to ever to be deallocated once initialised; need
// to check this. ---TLM 2024-04-22
public let smallBlockAllocator = CachingHostAllocator.init(using: [4,8,12,16,24,32,64,128,192,256])

