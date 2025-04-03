import SwiftToPTX
import SwiftCheck
import Foundation

// test lowering to libdevice
func test05(_ arr: Array<Float>) -> Array<Float>
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
        property("map sin") <- forAll { (xs : Array<Float>) in
            let expected = xs.map { sin($0) }
            let actual   = test05(xs)

            return (actual ~= expected)
        }
    }
}

