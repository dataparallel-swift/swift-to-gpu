import SwiftToPTX
import XCTest

// standard `map` operation, but the output array is allocated first.
//
// NOTE: We need to array via withUnsafeMutableBufferPointer(), to ensure that
// it is available for the lifetime of the kernel invocation, and (it seems) to
// work around the CoW mechanism of arrays, which is not thread safe?
fileprivate func test(_ arr: Array<Float>) -> Array<Float>
{
    var result = Array<Float>.init(repeating: 0, count: arr.count)

    result.withUnsafeMutableBufferPointer { buffer in
        parallel_for(iterations: arr.count) { i in
            let x = arr[i]
            buffer[i] = sin(x) * cos(x)
        }
    }.sync()

    return result
}

extension Simple {
    func testWithUnsafeMutableBufferPointer() {
        let count    = Int.random(in: sizeRange, using: &generator)
        let xs       = Array<Float>.random(count: count, using: &generator)
        let expected = xs.map{ x in sin(x) * cos(x) }
        let actual   = test(xs)

        XCTAssert(actual ~= expected)
    }
}

