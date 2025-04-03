import SwiftToPTX
import SwiftCheck

// standard `zipWith` operation (with intersection semantics)
func test06(_ xs: Array<Float>, _ ys: Array<Float>) -> Array<Float>
{
    let count = min(xs.count, ys.count)
    return Array<Float>.init(
        unsafeUninitializedCapacity: count,
        initializingWith: { buffer, initializedCount in
            let event = parallel_for(iterations: count) { i in
                buffer[i] = xs[i] + ys[i]
            }
            initializedCount = count
            event.sync()
        })
}

extension Simple {
    func testZipWithPlus() {
        property("zipWith (+)") <- forAll { (xs : Array<Float>, ys : Array<Float>) in
            let expected = zip(xs, ys).map{ (x,y) in x + y }
            let actual   = test06(xs, ys)

            return (actual ~= expected)
        }
    }
}

