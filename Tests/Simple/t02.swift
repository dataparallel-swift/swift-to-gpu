import SwiftToPTX
import SwiftCheck

// Fill an array with a given scalar value
func test02(count: Int, value: Float) -> Array<Float>
{
    Array<Float>.init(
        unsafeUninitializedCapacity: count,
        initializingWith: { buffer, initializedCount in
            parallel_for(iterations: count) { i in
                buffer[i] = value
            }.sync()
            initializedCount = count
        })
}

extension Simple {
    func testFillWithGivenValue() throws {
        property("fill with given value") <- forAll { (i : Positive<Int>, value : Float) in
            let count    = i.getPositive
            let expected = Array<Float>.init(repeating: value, count: count)
            let actual   = test02(count: count, value: value)

            return (actual == expected)
        }
    }
}

