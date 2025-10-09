// Copyright (c) 2025 PassiveLogic, Inc.

import Logging
import NIOConcurrencyHelpers
import SwiftToPTX_cbits
import Tracy

// swiftformat:disable consecutiveSpaces

private let logger = Logger(label: "CachingHostAllocator")

struct BlockDescriptor: Hashable, Equatable {
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

/**
 *  A thread-safe caching block allocator for pinned host memory
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
    let cached_blocks:  Array<NIOLockedValueBox<Set<BlockDescriptor>>>               // swiftlint:disable:this colon
    let live_blocks:    NIOLockedValueBox<Dictionary<UnsafeMutableRawPointer, Int?>> // swiftlint:disable:this colon

    /// Initialise the allocator using the given bin sizes, in bytes. The sizes
    /// must be monotonically increasing.
    public init(using bins: Array<Int>) {
        let __zone = #Zone
        defer { __zone.end() }

        // assert the input is monotonically increasing
        assert(bins.count > 1)
        assert(bins[0] > 0)
        for i in 0 ..< bins.count - 1 { // XXX: check this loop disappears in release mode
            assert(bins[i] < bins[i + 1])
        }

        logger.trace(".init(using: \(bins))")
        self.cached_blocks  = .init(count: bins.count, generator: { _ in .init(.init()) })
        self.live_blocks    = .init(.init())
        self.bin_size_bytes = bins
    }

    /// Initialise the allocator using the given bin parameters. The default
    /// parameters delineate five bin sizes: 512B, 4KB, 32KB, 256KB, and 2MB.
    public init(min_bin: Int = 3, max_bin: Int = 7, bin_growth: Int = 8) {
        assert(bin_growth > 1)
        assert(max_bin - min_bin > 0)

        let __zone = #Zone
        defer { __zone.end() }

        let count = max_bin - min_bin + 1
        let bins  = Array(unsafeUninitializedCapacity: count, initializingWith: { buffer, initialisedCount in
            for i in 0 ..< count {
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
        let __zone = #Zone
        defer { __zone.end() }

        // XXX: We could certainly be clever here--for example, doing binary
        // search or computing the value directly if we initialised the
        // allocator using geometrically increasing bin sizes--but we assume
        // that the number of bins is relatively small and so doing the dumb
        // thing is actually probably fastest.
        for i in 0 ..< bin_size_bytes.count {
            // swiftlint:disable:next for_where
            if value <= bin_size_bytes[i] {
                return i
            }
        }
        return nil
    }

    /// Return a suitable allocation for the given size
    public func alloc(_ bytes: Int) -> UnsafeMutableRawPointer {
        let __zone = #Zone
        defer { __zone.end() }

        // swiftlint:disable force_unwrapping
        var ptr: UnsafeMutableRawPointer? = nil

        if let bin = findBin(for: bytes) {
            // This allocation is within one of the bins that we are caching.

            // First iterate through the cached blocks of the given bin size
            // looking for an allocation that is ready to be reused.
            cached_blocks[bin].withLockedValue { blocks in
                for block in blocks where block.ready_event.complete() {
                    blocks.remove(block)
                    ptr = block.ptr
                    break
                }
            }

            // Otherwise, allocate a new block.
            if ptr == nil {
                ptr = swift_slowAlloc(bin_size_bytes[bin], 0)
                if ptr == nil {
                    logger.trace("Failed to allocate \(bin_size_bytes[bin]) bytes, retrying after freeing cached allocations")
                    if self.cleanup() {
                        return alloc(bytes)
                    }
                }
                logger.trace("Allocated new block at \(String(describing: ptr)) (\(bin_size_bytes[bin]) bytes)")
            }
            else {
                logger.trace("Reused cached block at \(String(describing: ptr)) (\(bin_size_bytes[bin]) bytes)")
            }

            assert(ptr != nil, "expected CUDA allocator to never return null-pointer")
            let old = live_blocks.withLockedValue { $0.updateValue(bin, forKey: ptr!) }
            assert(old == nil, "unexpectedly, block already exists (ptr=\(String(describing: ptr)))")
        }
        else {
            // This is an allocation larger than the maximum bin size that we
            // are caching. Allocate the request exactly and don't cache it for
            // reuse.
            ptr = swift_slowAlloc(bytes, 0)
            let old = live_blocks.withLockedValue { $0.updateValue(nil, forKey: ptr!) }
            assert(old == nil, "unexpectedly, block already exists (ptr=\(String(describing: ptr)))")
        }

        // TODO: Check if there any large blocks to remove. This could happen in
        // a low-priority background thread, or just check every N (say, 1000)
        // generic allocations. Right now these blocks just leak...

        return ptr!
        // swiftlint:enable force_unwrapping
    }

    /// Free a live allocation, returning it to the bin-cache. Once freed, the
    /// allocation becomes available for reuse once the given `ready_event` is
    /// complete.
    public func free(_ ptr: UnsafeMutableRawPointer, _ ready_event: Event) {
        let __zone = #Zone
        defer { __zone.end() }

        // Find corresponding block descriptor
        let block = BlockDescriptor(ptr: ptr, ready_event: ready_event)

        live_blocks.withLockedValue { blocks in
            if let exists = blocks[ptr] {
                blocks.removeValue(forKey: ptr)
                if let bin = exists {
                    _ = cached_blocks[bin].withLockedValue { $0.insert(block) }
                }
                else {
                    // This was a large-block allocation. We don't cache these, but just
                    // deallocate them (which still needs to happen asynchronously)
                    // deferred_free.insert(block)
                    // swiftlint:disable:next no_fatalerror
                    fatalError("TODO: asynchronously free large blocks")
                }
            }
            else {
                // swiftlint:disable:next no_fatalerror
                fatalError("free() called on a value that was either not live, or not managed by this allocator (\(ptr))")
            }
        }
    }

    /// Free all currently unused memory
    func cleanup() -> Bool {
        let __zone = #Zone
        defer { __zone.end() }

        var num_live_blocks = 0
        var live_bytes = 0

        var num_cached_blocks_outstanding = 0
        var num_cached_blocks_freed = 0

        var cached_bytes_outstanding = 0
        var cached_bytes_freed = 0

        live_blocks.withLockedValue { blocks in
            num_live_blocks = blocks.count
            live_bytes      = blocks.values.reduce(0, { x, y in x + y! }) // swiftlint:disable:this force_unwrapping
        }

        for bin in 0 ..< bin_size_bytes.count {
            let size = bin_size_bytes[bin]
            cached_blocks[bin].withLockedValue { blocks in
                for block in blocks {
                    if block.ready_event.complete() {
                        blocks.remove(block)
                        swift_slowDealloc(block.ptr, size, 0)
                        num_cached_blocks_freed += 1
                        cached_bytes_freed += size
                    }
                    else {
                        num_cached_blocks_outstanding += 1
                        cached_bytes_outstanding += size
                    }
                }
            }
        }

        logger
            .info(
                "Freed \(num_cached_blocks_freed) blocks (\(cached_bytes_freed) bytes). \(num_cached_blocks_outstanding) cached blocks (\(cached_bytes_outstanding) bytes), \(num_live_blocks) live blocks (\(live_bytes) bytes) outstanding"
            )

        return cached_bytes_freed > 0
    }

    /// Free all memory
    public func destroy() {
        let __zone = #Zone
        defer { __zone.end() }

        for bin in 0 ..< bin_size_bytes.count {
            assert(live_blocks.withLockedValue { $0.count } == 0, "allocator is still holding onto live memory")

            let size = bin_size_bytes[bin]
            cached_blocks[bin].withLockedValue { blocks in
                for block in blocks {
                    block.ready_event.sync()
                    blocks.remove(block)
                    swift_slowDealloc(block.ptr, size, 0)
                }
            }
        }
    }
}

private func pow(_ base: Int, _ exp: Int) -> Int {
    // swiftlint:disable identifier_name shorthand_operator
    var r = 1
    var b = base
    var e = exp

    while e > 0 {
        if e & 1 != 0 {
            r = r * b
        }
        b = b * b
        e = e >> 1
    }
    return r
    // swiftlint:enable identifier_name shorthand_operator
}

/// The default allocator used by the swift-to-ptx compiler pass, biased towards
/// small block sizes as that is what we encounter most often when lifting the
/// closure environment for execution on the GPU.
public let smallBlockAllocator = CachingHostAllocator(using: [4, 8, 12, 16, 24, 32, 64, 128, 192, 256])
// XXX: ↑ I have noticed @swift_retain and @swift_release calls in the generated
// LLVM, but we don't want this to ever to be deallocated once initialised; need
// to check this. ---TLM 2024-04-22
