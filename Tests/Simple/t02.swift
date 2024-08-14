import SwiftToPTX
import XCTest

// Fill an array with a given scalar value
fileprivate func test(count: Int, value: Float) -> Array<Float>
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
    func testFillWithGivenValue() {
        let count    = Int.random(in: sizeRange, using: &generator)
        let value    = Float.random(using: &generator)
        let expected = Array<Float>.init(repeating: value, count: count)
        let actual   = test(count: count, value: value)

        XCTAssertEqual(actual, expected)
    }
}

