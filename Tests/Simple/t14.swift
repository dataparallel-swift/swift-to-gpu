import SwiftToPTX
import XCTest

// standard saxpy operation
fileprivate func test(_ alpha: Float, _ xs: Array<Float>, _ ys: Array<Float>) -> Array<Float>
{
    let count = min(xs.count, ys.count)
    return Array<Float>.init(
        unsafeUninitializedCapacity: count,
        initializingWith: { buffer, initializedCount in
            parallel_for(iterations: count) { i in
                buffer[i] = alpha * xs[i] + ys[i]
            }
            initializedCount = count
        })
}

extension Simple {
    func testSAXPY() {
        let count    = 1_000_000
        let xs       = Array<Float>.random(count: count, using: &generator)
        let ys       = Array<Float>.random(count: count, using: &generator)
        let alpha    = Float.random(using: &generator)
        let actual   = test(alpha, xs, ys)
        let expected = zip(xs,ys).map{ alpha * $0.0 + $0.1 }

        XCTAssert(actual ~= expected)
    }
}

