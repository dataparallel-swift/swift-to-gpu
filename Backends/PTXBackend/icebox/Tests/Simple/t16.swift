import SwiftToPTX
import SwiftCheck

@inline(never)
// TODO: ↑ This is required otherwise we will get the error:
// .../swift-to-ptx-cbits.cpp:107 CUDA call failed with error CUDA_ERROR_ILLEGAL_ADDRESS (700): an illegal memory access was encountered
//
// We still need to diagnose this and find a fix. ---TLM 2024-10-10
func test16(_ xs: Array<Float>) -> (Array<Float>, Array<Float>)
{
    var result1 = Array<Float>.init(unsafeUninitializedCapacity: xs.count)
    var result2 = Array<Float>.init(unsafeUninitializedCapacity: xs.count)

    result1.withUnsafeMutableBufferPointer { buffer1 in
    result2.withUnsafeMutableBufferPointer { buffer2 in
        parallel_for(iterations: xs.count) { i in
            buffer1[i] = xs[i]
            buffer2[i] = xs[i]
        }.sync()
    }}

    return (result1, result2)
}

extension Simple {
    func testMultipleOutputs() {
        property("multiple outputs") <- forAll { (xs : Array<Float>) in
            let expected = (xs, xs)
            let actual   = test16(xs)

            return (actual == expected)
        }
    }
}

fileprivate extension Array {
    init(unsafeUninitializedCapacity count: Int) {
        precondition(count >= 0, "arrays must have non-negative sizes")
        self.init(
            unsafeUninitializedCapacity: count,
            initializingWith: { _, initializedCount in
                initializedCount = count
            })
    }
}

