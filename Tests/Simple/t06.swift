import SwiftToPTX
import XCTest

// standard `zipWith` operation (with intersection semantics)
fileprivate func test(_ xs: Array<Float>, _ ys: Array<Float>) -> Array<Float>
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
        let xs       = Array<Float>.random(count: .random(in: sizeRange, using: &generator), using: &generator)
        let ys       = Array<Float>.random(count: .random(in: sizeRange, using: &generator), using: &generator)
        let expected = zip(xs, ys).map{ (x,y) in x + y }
        let actual   = test(xs, ys)

        XCTAssert(actual ~= expected)
    }
}

