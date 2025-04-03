import SwiftToPTX
import SwiftCheck

func test03(size: Int) -> Array<Float>
{
    Array<Float>.init(
        unsafeUninitializedCapacity: size,
        initializingWith: { buffer, initializedCount in
            parallel_for(iterations: size) { i in
                buffer[i] = Float(i)
            }.sync()
            initializedCount = size
        })
}

extension Simple {
    func testFillWithIndex() {
        property("fill with index") <- forAll { (i : Positive<Int>) in
            let count    = i.getPositive
            let expected = Array(stride(from: 0, to: Float(count), by: 1))
            let actual   = test03(size: count)

            return (actual == expected)
        }
    }
}

