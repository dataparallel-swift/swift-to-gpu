import SwiftToPTX
import XCTest

// Fill an array with a known constant value
fileprivate func test(count: Int) -> Array<Float>
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
    func testFillWithKnownValue() {
        let count    = Int.random(in: sizeRange, using: &generator)
        let expected = Array<Float>.init(repeating: 42, count: count)
        let actual   = test(count: count)

        XCTAssertEqual(actual, expected)
    }
}

