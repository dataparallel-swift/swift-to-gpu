import SwiftToPTX
import XCTest
import _Differentiation

fileprivate func body(_ x: Float) -> Float
{
    let y = x * x
    return sqrt(x) * cos(y)
}

fileprivate func test(_ arr: Array<Float>) -> Array<Float>
{
    Array<Float>.init(
        unsafeUninitializedCapacity: arr.count,
        initializingWith: { buffer, initializedCount in
            parallel_for(iterations: arr.count) { i in
                buffer[i] = gradient(at: arr[i], of: body)
            }
            initializedCount = arr.count
        })
}

extension Simple {
    func testGradientAtSqrtCosSquare() {
        let count    = Int.random(in: sizeRange, using: &generator)
        let xs       = Array<Float>.random(count: count, using: &generator)
        let expected = xs.map{ x in gradient(at: x, of: body) }
        let actual   = test(xs)

        XCTAssert(actual ~= expected)
    }
}

