import SwiftToPTX
import SwiftCheck
import Foundation

// Test a noinline function.
// This propagates the annotation to the generated kernel as well.
@inline(never)
fileprivate func body(_ x: Float) -> Float
{
    let y = x * x
    return sin(x) * cos(y)
}

func test08(_ arr: Array<Float>) -> Array<Float>
{
    Array<Float>.init(
        unsafeUninitializedCapacity: arr.count,
        initializingWith: { buffer, initializedCount in
            parallel_for(iterations: arr.count) { i in
                buffer[i] = body(arr[i])
            }.sync()
            initializedCount = arr.count
        })
}

extension Simple {
    func testNoinline() {
        property("noinline") <- forAll { (xs : Array<Float>) in
            let expected = xs.map{ body($0) }
            let actual   = test08(xs)

            return (actual ~= expected)
        }
    }
}

