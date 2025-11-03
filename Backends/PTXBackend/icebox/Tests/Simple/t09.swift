import SwiftToPTX
import SwiftCheck
import _Differentiation

fileprivate func body(_ x: Float) -> Float
{
    return x * x
}

func test09(_ arr: Array<Float>) -> Array<Float>
{
    Array<Float>.init(
        unsafeUninitializedCapacity: arr.count,
        initializingWith: { buffer, initializedCount in
            parallel_for(iterations: arr.count) { i in
                buffer[i] = gradient(at: arr[i], of: body)
            }.sync()
            initializedCount = arr.count
        })
}

extension Simple {
    func testGradientAtSquare() {
        property("gradientAt:square") <- forAll { (xs : Array<Float>) in
            let expected = xs.map{ x in gradient(at: x, of: body) }
            let actual   = test09(xs)

            return (actual ~= expected)
        }
    }
}

