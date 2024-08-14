import SwiftToPTX
import XCTest

// test lowering to libdevice
fileprivate func test(_ arr: Array<Float>) -> Array<Float>
{
    Array<Float>.init(
        unsafeUninitializedCapacity: arr.count,
        initializingWith: { buffer, initializedCount in
            parallel_for(iterations: arr.count) { i in
                buffer[i] = sin(arr[i])
            }.sync()
            initializedCount = arr.count
        })
}

extension Simple {
    func testMapSin() {
        let count    = Int.random(in: sizeRange, using: &generator)
        let xs       = Array<Float>.random(count: count, using: &generator)
        let expected = xs.map { sin($0) }
        let actual   = test(xs)

        XCTAssert(actual ~= expected)
    }
}

