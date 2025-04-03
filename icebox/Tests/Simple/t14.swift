import SwiftToPTX
import SwiftCheck

// standard saxpy operation
func test14(_ alpha: Float, _ xs: Array<Float>, _ ys: Array<Float>) -> Array<Float>
{
    let count = min(xs.count, ys.count)
    return Array<Float>.init(
        unsafeUninitializedCapacity: count,
        initializingWith: { buffer, initializedCount in
            parallel_for(iterations: count) { i in
                buffer[i] = alpha * xs[i] + ys[i]
            }.sync()
            initializedCount = count
        })
}

extension Simple {
    func testSAXPY() {
        property("saxpy") <- forAll { (xs : Array<Float>, ys : Array<Float>, alpha : Float) in
            let actual   = test14(alpha, xs, ys)
            let expected = zip(xs,ys).map{ alpha * $0.0 + $0.1 }

            return (actual ~= expected)
        }
    }
}

