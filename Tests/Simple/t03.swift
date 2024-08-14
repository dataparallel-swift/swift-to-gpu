import SwiftToPTX
import XCTest

fileprivate func test(size: Int) -> Array<Float>
{
    Array<Float>.init(
        unsafeUninitializedCapacity: size,
        initializingWith: { buffer, initializedCount in
            parallel_for(iterations: size) { i in
                buffer[i] = Float(i)
            }.sync()
            initializedCount = size
        })
}

extension Simple {
    func testFillWithIndex() {
        let count    = Int.random(in: sizeRange, using: &generator)
        let expected = Array(stride(from: 0, to: Float(count), by: 1))
        let actual   = test(size: count)

        XCTAssertEqual(actual, expected)
    }
}

