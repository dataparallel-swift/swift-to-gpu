import SwiftToPTX
import XCTest

// Fill an array with a known constant value
fileprivate func test(count: Int, allocator: CachingHostAllocator) -> Array<Float>
{
    Array<Float>.init(
        unsafeUninitializedCapacity: count,
        initializingWith: { buffer, initializedCount in
            parallel_for(iterations: count, allocator: allocator) { i in
                buffer[i] = 42
            }
            initializedCount = count
        })
}

extension Simple {
    func testCustomAlloc() {
        let alloc    = CachingHostAllocator.init()
        let count    = Int.random(in: sizeRange, using: &generator)
        let expected = Array<Float>.init(repeating: 42, count: count)
        let actual   = test(count: count, allocator: alloc)

        XCTAssert(actual ~= expected)
    }
}

