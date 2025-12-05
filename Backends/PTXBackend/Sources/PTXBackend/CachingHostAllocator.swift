// Copyright (c) 2025 The swift-to-gpu authors. All rights reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import Logging
import NIOConcurrencyHelpers
import PTXBackendC
import Tracy

private let logger = Logger(label: "CachingHostAllocator")

struct BlockDescriptor: Hashable, Equatable {
    let ptr: UnsafeMutableRawPointer
    let readyEvent: PTXEvent

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
 *     `binGrowth` provided during construction. Unused allocations within a
 *     larger bin cache are not reused for allocation requests that categorise
 *     to smaller bin sizes.
 *
 *   - Allocation requests below `binGrowth` ^ `binMin` are rounded up to
 *     `binGrowth` ^ `binMin`
 *
 *   - TODO: Allocations above `binGrowth` ^ `binMax` are not rounded up to the
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
    let binSizesInBytes: Array<Int>
    let cachedBlocks: Array<NIOLockedValueBox<Set<BlockDescriptor>>>
    let liveBlocks: NIOLockedValueBox<Dictionary<UnsafeMutableRawPointer, Int?>>

    /// The default allocator used by the swift-to-ptx compiler pass, biased towards
    /// small block sizes as that is what we encounter most often when lifting the
    /// closure environment for execution on the GPU.
    public static let smallBlockAllocator = CachingHostAllocator(using: [4, 8, 12, 16, 24, 32, 64, 128, 192, 256])
    // XXX: ↑ I have noticed @swift_retain and @swift_release calls in the generated
    // LLVM, but we don't want this to ever to be deallocated once initialised; need
    // to check this. ---TLM 2024-04-22

    /// Initialise the allocator using the given bin sizes, in bytes. The sizes
    /// must be monotonically increasing.
    public init(using bins: Array<Int>) {
        let zone = #Zone
        defer { zone.end() }

        // assert the input is monotonically increasing
        assert(bins.count > 1)
        assert(bins[0] > 0)
        for i in 0 ..< bins.count - 1 { // XXX: check this loop disappears in release mode
            assert(bins[i] < bins[i + 1])
        }

        logger.trace(".init(using: \(bins))")
        self.cachedBlocks = .init(count: bins.count, generator: { _ in .init(.init()) })
        self.liveBlocks = .init(.init())
        self.binSizesInBytes = bins
    }

    /// Initialise the allocator using the given bin parameters. The default
    /// parameters delineate five bin sizes: 512B, 4KB, 32KB, 256KB, and 2MB.
    public init(binMin: Int = 3, binMax: Int = 7, binGrowth: Int = 8) {
        assert(binGrowth > 1)
        assert(binMax - binMin > 0)

        let zone = #Zone
        defer { zone.end() }

        let count = binMax - binMin + 1
        let bins = Array(unsafeUninitializedCapacity: count, initializingWith: { buffer, initialisedCount in
            for i in 0 ..< count {
                buffer[i] = pow(binGrowth, binMin + i)
            }
            initialisedCount = count
        })

        logger.trace(".init(binMin: \(binMin), binMax: \(binMax), binGrowth: \(binGrowth)) --> \(bins)")
        self.cachedBlocks = .init(count: bins.count, generator: { _ in .init(.init()) })
        self.liveBlocks = .init(.init())
        self.binSizesInBytes = bins
    }

    func findBin(for value: Int) -> Int? {
        let zone = #Zone
        defer { zone.end() }

        // XXX: We could certainly be clever here--for example, doing binary
        // search or computing the value directly if we initialised the
        // allocator using geometrically increasing bin sizes--but we assume
        // that the number of bins is relatively small and so doing the dumb
        // thing is actually probably fastest.
        for i in 0 ..< binSizesInBytes.count {
            // swiftlint:disable:next for_where
            if value <= binSizesInBytes[i] {
                return i
            }
        }
        return nil
    }

    /// Return a suitable allocation for the given size
    public func alloc(_ bytes: Int) -> UnsafeMutableRawPointer {
        let zone = #Zone
        defer { zone.end() }

        // swiftlint:disable force_unwrapping
        var ptr: UnsafeMutableRawPointer? = nil

        if let bin = findBin(for: bytes) {
            // This allocation is within one of the bins that we are caching.

            // First iterate through the cached blocks of the given bin size
            // looking for an allocation that is ready to be reused.
            cachedBlocks[bin].withLockedValue { blocks in
                for block in blocks where try! block.readyEvent.complete() { // swiftlint:disable:this force_try
                    blocks.remove(block)
                    ptr = block.ptr
                    break
                }
            }

            // Otherwise, allocate a new block.
            if ptr == nil {
                ptr = swift_slowAlloc(binSizesInBytes[bin], 0)
                if ptr == nil {
                    logger.trace("Failed to allocate \(binSizesInBytes[bin]) bytes, retrying after freeing cached allocations")
                    if self.cleanup() {
                        return alloc(bytes)
                    }
                }
                logger.trace("Allocated new block at \(String(describing: ptr)) (\(binSizesInBytes[bin]) bytes)")
            }
            else {
                logger.trace("Reused cached block at \(String(describing: ptr)) (\(binSizesInBytes[bin]) bytes)")
            }

            assert(ptr != nil, "expected CUDA allocator to never return null-pointer")
            let old = liveBlocks.withLockedValue { $0.updateValue(bin, forKey: ptr!) }
            assert(old == nil, "unexpectedly, block already exists (ptr=\(String(describing: ptr)))")
        }
        else {
            // This is an allocation larger than the maximum bin size that we
            // are caching. Allocate the request exactly and don't cache it for
            // reuse.
            ptr = swift_slowAlloc(bytes, 0)
            let old = liveBlocks.withLockedValue { $0.updateValue(nil, forKey: ptr!) }
            assert(old == nil, "unexpectedly, block already exists (ptr=\(String(describing: ptr)))")
        }

        // TODO: Check if there any large blocks to remove. This could happen in
        // a low-priority background thread, or just check every N (say, 1000)
        // generic allocations. Right now these blocks just leak...

        return ptr!
        // swiftlint:enable force_unwrapping
    }

    /// Free a live allocation, returning it to the bin-cache. Once freed, the
    /// allocation becomes available for reuse once the given `readyEvent` is
    /// complete.
    public func free(_ ptr: UnsafeMutableRawPointer, _ readyEvent: PTXEvent) {
        let zone = #Zone
        defer { zone.end() }

        // Find corresponding block descriptor
        let block = BlockDescriptor(ptr: ptr, readyEvent: readyEvent)

        liveBlocks.withLockedValue { blocks in
            if let exists = blocks[ptr] {
                blocks.removeValue(forKey: ptr)
                if let bin = exists {
                    _ = cachedBlocks[bin].withLockedValue { $0.insert(block) }
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
        let zone = #Zone
        defer { zone.end() }

        var numLiveBlocks = 0
        var liveBytes = 0

        var numCachedBlocksOutstanding = 0
        var numCachedBlocksFreed = 0

        var cachedBytesOutstanding = 0
        var cachedBytesFreed = 0

        liveBlocks.withLockedValue { blocks in
            numLiveBlocks = blocks.count
            liveBytes = blocks.values.reduce(0, { x, y in x + y! }) // swiftlint:disable:this force_unwrapping
        }

        for bin in 0 ..< binSizesInBytes.count {
            let size = binSizesInBytes[bin]
            cachedBlocks[bin].withLockedValue { blocks in
                for block in blocks {
                    if try! block.readyEvent.complete() { // swiftlint:disable:this force_try
                        blocks.remove(block)
                        swift_slowDealloc(block.ptr, size, 0)
                        numCachedBlocksFreed += 1
                        cachedBytesFreed += size
                    }
                    else {
                        numCachedBlocksOutstanding += 1
                        cachedBytesOutstanding += size
                    }
                }
            }
        }

        logger
            .info(
                "Freed \(numCachedBlocksFreed) blocks (\(cachedBytesFreed) bytes). \(numCachedBlocksOutstanding) cached blocks (\(cachedBytesOutstanding) bytes), \(numLiveBlocks) live blocks (\(liveBytes) bytes) outstanding"
            )

        return cachedBytesFreed > 0
    }

    /// Free all memory
    public func destroy() {
        let zone = #Zone
        defer { zone.end() }

        for bin in 0 ..< binSizesInBytes.count {
            assert(liveBlocks.withLockedValue { $0.count } == 0, "allocator is still holding onto live memory")

            let size = binSizesInBytes[bin]
            cachedBlocks[bin].withLockedValue { blocks in
                for block in blocks {
                    try! block.readyEvent.sync() // swiftlint:disable:this force_try
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
