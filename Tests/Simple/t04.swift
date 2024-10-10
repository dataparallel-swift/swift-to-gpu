import SwiftToPTX
import SwiftCheck
import XCTest

// standard `map` operation
func test04(_ arr: Array<Float>) -> Array<Float>
{
    Array<Float>.init(
        unsafeUninitializedCapacity: arr.count,
        initializingWith: { buffer, initializedCount in
            let event = parallel_for(iterations: arr.count) { i in
                let x = arr[i]
                buffer[i] = x * x
            }
            initializedCount = arr.count
            event.sync()
        })
}

extension Simple {
    func testMapSquare() {
        property("map square") <- forAll { (xs : Array<Float>) in
            let expected = xs.map { x in x * x}
            let actual   = test04(xs)

            return (actual ~= expected)
        }
    }
}

