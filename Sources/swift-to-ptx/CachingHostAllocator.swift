import CUDA
import Logging

private let logger = Logger(label: "CUDA CachingHostAllocator")

struct BlockDescriptor : Hashable, Equatable {
    let ptr: UnsafeMutableRawPointer
    let ready_event: Event

    func hash(into hasher: inout Hasher) {
        hasher.combine(ptr)
    }

    static func == (lhs: BlockDescriptor, rhs: BlockDescriptor) -> Bool {
        return lhs.ptr == rhs.ptr
    }
}

public class CachingHostAllocator {
    let bin_growth: Int
    let min_bin: Int
    let max_bin: Int
    let bin_size_bytes: Array<Int>
    // let max_cached_bytes : Int

    // TODO: These should be protected by locks (individually, per bin, because
    // almost certainly the Set is not going to support concurrent updates)
    var live_blocks: Array<Set<UnsafeMutableRawPointer>>
    var cached_blocks: Array<Set<BlockDescriptor>>
    // var deferred_free: Set<BlockDescriptor>  // TODO

    public init(min_bin: Int = 1, max_bin: Int = 9, bin_growth: Int = 8) {
        self.min_bin        = min_bin
        self.max_bin        = max_bin
        self.bin_growth     = bin_growth
        self.live_blocks    = Array.init(repeating: Set.init(), count: max_bin)
        self.cached_blocks  = Array.init(repeating: Set.init(), count: max_bin)
        self.bin_size_bytes = Array.init(unsafeUninitializedCapacity: max_bin, initializingWith: { buffer, initialisedCount in
            for i in 0..<max_bin {
                buffer[i] = IntPow(bin_growth, i)
            }
            initialisedCount = max_bin
        })
    }

    public func alloc(_ bytes : Int) -> UnsafeMutableRawPointer {
        var ptr : UnsafeMutableRawPointer? = nil

        // create a block descriptor for the current allocation
        var (bin, rounded_bytes) = NearestPowerOf(bin_growth, bytes)

        if (bin > max_bin) {
            // Bin is greater than the maximum bin size that we are caching.
            // Allocate the request exactly and don't cache it for reuse.
            cuda_safe_call{cuMemAllocHost_v2(&ptr, Int(bytes))}
        }
        else {
            if (bin < min_bin) {
                bin           = min_bin
                rounded_bytes = bin_size_bytes[min_bin]
            }

            // mutex lock

            // Iterate through the cached blocks of the same bin
            for block in cached_blocks[bin] {
                if block.ready_event.complete() {
                    cached_blocks[bin].remove(block)
                    ptr = block.ptr

                    logger.info("Reused cached block at \(block.ptr) (\(bin_size_bytes[bin]) bytes)")
                    break; // don't return directly; we need to unlock the mutex
                }
            }

            // Allocate a new block
            if ptr == nil {
                let result = cuMemAllocHost_v2(&ptr, rounded_bytes)
                switch result {
                    case CUDA_SUCCESS: break
                    case CUDA_ERROR_OUT_OF_MEMORY:
                        // If the allocation fails, free the cached blocks and
                        // try to allocate again
                        logger.info("Failed to allocate \(bin_size_bytes[bin]) bytes, retrying after freening cached allocations")
                        self.cleanup()
                        cuda_safe_call{cuMemAllocHost_v2(&ptr, rounded_bytes)}

                    default:
                        var name : UnsafePointer<CChar>? = nil
                        var desc : UnsafePointer<CChar>? = nil
                        cuGetErrorName(result, &name)
                        cuGetErrorString(result, &desc)
                        fatalError("CUDA call failed with error \(String.init(cString: name!)) (\(result.rawValue)): \(String.init(cString: desc!))")
                }
                logger.info("Allocated new block at \(ptr!) (\(bin_size_bytes[bin]) bytes)")
            }

            assert(ptr != nil, "expected CUDA allocator to never return null-pointer")
            live_blocks[bin].insert(ptr!)

            // mutex unlock
        }

        // TODO: Check if there any large blocks to remove. This should probably
        // happen in a low-priority background thread (we can force purge if we
        // run out of memory, but we probably don't want to add the overhead of
        // checking on every allocation)

        return ptr!
    }

    public func free(_ ptr: UnsafeMutableRawPointer, _ ready_event: Event) {
        // Find corresponding block descriptor
        var cached: Bool = false
        let block = BlockDescriptor(ptr: ptr, ready_event: ready_event)

        for bin in min_bin..<max_bin {
            for this in live_blocks[bin] {
                if ptr == this {
                    // Keep the returned allocation if we won't exceed the
                    // maximum cached threshold (which we currently do not track)
                    live_blocks[bin].remove(ptr)
                    cached_blocks[bin].insert(block)
                    cached = true
                }
            }
        }

        if !cached {
            // This was a large-block allocation. We don't cache these, but just
            // deallocate them (which still needs to happen asynchronously)
            // deferred_free.insert(block)
            fatalError("TODO: asynchronously free large blocks")
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

        for bin in min_bin..<max_bin {
            let count = live_blocks[bin].count
            num_live_blocks += count
            live_bytes += count * bin_size_bytes[bin]
        }

        for bin in min_bin..<max_bin {
            for block in cached_blocks[bin] {
                if block.ready_event.complete() {
                    cached_blocks[bin].remove(block)
                    cuda_safe_call{cuMemFreeHost(block.ptr)}

                    num_cached_blocks_freed += 1
                    cached_bytes_freed += bin_size_bytes[bin]
                } else {
                    num_cached_blocks_outstanding += 1
                    cached_bytes_outstanding += bin_size_bytes[bin]
                }
            }
        }

        logger.info("Freed \(num_cached_blocks_freed) blocks (\(cached_bytes_freed) bytes). \(num_cached_blocks_outstanding) cached blocks (\(cached_bytes_outstanding) bytes), \(num_live_blocks) live blocks (\(live_bytes) bytes) outstanding")
    }

    deinit {
        for bin in min_bin..<max_bin {
            assert(live_blocks[bin].count == 0, "allocator is still holding onto live memory")

            for block in cached_blocks[bin] {
                block.ready_event.sync()
                cuda_safe_call{cuMemFreeHost(block.ptr)}
            }
        }
    }
}

func IntPow(_ base: Int, _ exp: Int) -> Int
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

func NearestPowerOf(_ base: Int, _ value: Int) -> (Int, Int)
{
    var power: Int = 0
    var rounded_value: Int = 1;

    if (value * base < value) {
        // overflow
        return (MemoryLayout<Int>.stride * 8, Int.max)
    }

    while (rounded_value < value) {
        rounded_value *= base
        power += 1
    }

    return (power, rounded_value)
}

