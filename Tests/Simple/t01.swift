import SwiftToPTX
import SwiftCheck

// Fill an array with a known constant value
func test01(count: Int) -> Array<Float>
{
    Array<Float>.init(
        unsafeUninitializedCapacity: count,
        initializingWith: { buffer, initializedCount in
            let event = parallel_for(iterations: count) { i in
                buffer[i] = 42
            }
            initializedCount = count
            event.sync()
        })
}

extension Simple {
    func testFillWithKnownValue() throws {
        property("fill with known value") <- forAll { (i : Positive<Int>) in
            let count    = i.getPositive
            let expected = Array<Float>.init(repeating: 42, count: count)
            let actual   = test01(count: count)

            return (actual == expected)
        }
    }
}

