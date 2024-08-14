import SwiftToPTX
import XCTest

// standard `backpermute` operation
fileprivate func test(_ idx: Array<Int>, _ arr: Array<Float>) -> Array<Float>
{
    Array<Float>.init(
        unsafeUninitializedCapacity: idx.count,
        initializingWith: { buffer, initializedCount in
            parallel_for(iterations: idx.count) { i in
                buffer[i] = arr[idx[i]]
            }.sync()
            initializedCount = idx.count
        })
}

extension Simple {
    func testBackpermute() {
        let count    = Int.random(in: sizeRange, using: &generator)
        let xs       = Array<Float>.random(count: count, using: &generator)
        let idx      = (0..<count).map{ _ in Int.random(in: 0..<count, using: &generator) }
        let expected = (0..<count).map{ i in xs[idx[i]] }
        let actual   = test(idx, xs)

        XCTAssertEqual(actual, expected)
    }
}

