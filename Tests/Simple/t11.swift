import SwiftToPTX
import SwiftCheck

// standard `backpermute` operation
fileprivate func test(_ idx: Array<Int>, _ arr: Array<Float>) -> Array<Float>
{
    Array<Float>.init(
        unsafeUninitializedCapacity: idx.count,
        initializingWith: { buffer, initializedCount in
            parallel_for(iterations: idx.count) { i in
                buffer[i] = arr[idx[i]]
            }.sync()
            initializedCount = idx.count
        })
}

extension Simple {
    func testBackpermute() {
        property("backpermute") <- forAll { (i : Positive<Int>) in
            let count    = i.getPositive
            let xs       = Array<Float>.random(count: count, using: &self.generator)
            let idx      = (0..<count).map{ _ in Int.random(in: 0..<count, using: &self.generator) }
            let expected = (0..<count).map{ i in xs[idx[i]] }
            let actual   = test(idx, xs)

            return (actual == expected)
        }
    }
}

