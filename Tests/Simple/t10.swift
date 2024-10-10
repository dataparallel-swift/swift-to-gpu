import SwiftToPTX
import SwiftCheck
import Foundation
import _Differentiation

// SwiftCheck (just like its inspiration QuickCheck) do not make it easy to
// generate an array where the elements are drawn from a given generator. Thus
// we can't guarantee that we, e.g. only have positive numbers to feed to
// sqrt(). Work around this by first squaring the input.
fileprivate func body(_ x: Float) -> Float
{
    let y = x * x
    return sqrt(y) * cos(x)
}

func test10(_ arr: Array<Float>) -> Array<Float>
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
func testGradientAtSqrtCosSquare() {
        property ("gradientAt:sqrt.square.cos") <- forAll { (xs : Array<Float>) in
            let expected = xs.map{ x in gradient(at: x, of: body) }
            let actual   = test10(xs)

            return (actual ~= expected)
        }
    }
}

