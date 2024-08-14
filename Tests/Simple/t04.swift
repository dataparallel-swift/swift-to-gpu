import SwiftToPTX
import XCTest

// standard `map` operation
fileprivate func test(_ arr: Array<Float>) -> Array<Float>
{
    Array<Float>.init(
        unsafeUninitializedCapacity: arr.count,
        initializingWith: { buffer, initializedCount in
            let event = parallel_for(iterations: arr.count) { i in
                let x = arr[i]
                buffer[i] = x * x
            }
            initializedCount = arr.count
            event.sync()
        })
}

extension Simple {
    func testMapSquare() {
        let count    = Int.random(in: sizeRange, using: &generator)
        let xs       = Array<Float>.random(count: count, using: &generator)
        let expected = xs.map { x in x * x}
        let actual   = test(xs)

        XCTAssertEqual(actual, expected)
    }
}

