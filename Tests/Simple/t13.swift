import SwiftToPTX
import XCTest

// Return an index of the selected value in the array, if it exists. If multiple
// elements have the selected value, the result is non-deterministic
@inline(never)
func test(_ needle: Float, _ haystack: Array<Float>) -> Int?
{
    var found : Int? = nil

    parallel_for(iterations: haystack.count) { i in
        if haystack[i] == needle {
            found = i
        }
    }.sync()

    return found
}

extension Simple {
    func testNeedleInAHaystack() {
        let count    = 1_000_000
        let xs       = Array<Float>.random(count: count, using: &generator)
        let expected = Int.random(in: 0..<count)
        let actual   = test(xs[expected], xs)

        XCTAssertEqual(actual, expected)
    }
}
