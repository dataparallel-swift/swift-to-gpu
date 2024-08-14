import SwiftToPTX
import XCTest

// standard `compact` (a.k.a. filter) operation
fileprivate func test(_ keep: Array<Bool>, _ arr: Array<Float>) -> Array<Float>
{
    // let (offset, count) = scanl' (+) 0 (map boolToInt keep)
    // TODO: parallel scans, reductions, etc...
    var count : Int = 0
    let offset = Array<Int>.init(
        unsafeUninitializedCapacity: keep.count,
        initializingWith: { buffer, initializedCount in
            for i in 0..<keep.count {
                buffer[i] = count
                if keep[i] {
                    count += 1
                }
            }
            initializedCount = keep.count
        })

    // standard (non-deterministic) forward `permute` operation. In this case we
    // know that each index in the output is only written to once, and that
    // every index in the output is written to.
    return Array<Float>.init(
        unsafeUninitializedCapacity: count,
        initializingWith: { buffer, initializedCount in
            parallel_for(iterations: keep.count) { i in
                if keep[i] {
                    buffer[offset[i]] = arr[i]
                }
            }.sync()
            initializedCount = count
        })
}

extension Simple {
    func testCompact() {
        let count    = Int.random(in: sizeRange, using: &generator)
        let xs       = Array<Float>.random(count: count, using: &generator)
        let keep     = Array<Bool>.random(count: count, using: &generator)
        let expected = zip(keep, xs).filter{ $0.0 }.map{ $0.1 }
        let actual   = test(keep, xs)

        XCTAssertEqual(actual, expected)
    }
}

