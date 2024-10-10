import SwiftToPTX
import SwiftCheck

// Fill an array with a known constant value
func test15(count: Int, allocator: CachingHostAllocator) -> Array<Float>
{
    Array<Float>.init(
        unsafeUninitializedCapacity: count,
        initializingWith: { buffer, initializedCount in
            parallel_for(iterations: count, allocator: allocator) { i in
                buffer[i] = 42
            }.sync()
            initializedCount = count
        })
}

extension Simple {
    func testCustomAlloc() {
        let alloc    = CachingHostAllocator.init()

        property("customAlloc") <- forAll { (i : Positive<Int>) in
            let count    = i.getPositive
            let expected = Array<Float>.init(repeating: 42, count: count)
            let actual   = test15(count: count, allocator: alloc)

            return (actual ~= expected)
        }
    }
}

