import SwiftToPTX
import SwiftCheck

func test16(_ xs: Array<Float>, _ idx: Array<Int>) -> (Array<Float>, Array<Float>)
{
    var result1 = Array<Float>.init(repeating: 0, count: xs.count)
    let result2 = Array<Float>.init(
        unsafeUninitializedCapacity: xs.count,
        initializingWith: { buffer2, initializedCount in
            result1.withUnsafeMutableBufferPointer { buffer1 in
                parallel_for(iterations: xs.count) { i in
                    buffer1[i] = xs[xs.count - i - 1]
                    buffer2[i] = xs[idx[i % idx.count]]
                }.sync()
            }
            initializedCount = xs.count
        })

    return (result1, result2)
}

extension Simple {
    func testMultipleOutputs() {
        property("multiple outputs") <- forAll { (i : Positive<Int>) in

            let lorge = 100_000
            let smol  = i.getPositive
            let input = Array<Float>.random(count: lorge, using: &self.generator)
            let idx   = (0..<smol).map{ _ in Int.random(in: 0..<lorge, using: &self.generator) }

            let expected = ( (0..<lorge).map{ i in input[input.count - i - 1] }
                           , (0..<lorge).map{ i in input[idx[i % idx.count]]  } )
            let actual   = test16(input, idx)

            return (actual == expected)
        }
    }
}

