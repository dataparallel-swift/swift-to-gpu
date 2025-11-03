import SwiftToPTX
import SwiftCheck

// Return an index of the selected value in the array, if it exists. If multiple
// elements have the selected value, the result is non-deterministic
@inline(never)
func test13(_ needle: Float, _ haystack: Array<Float>) -> Int?
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
        let count    = 100_000

        property ("needle-in-a-haystack") <- forAll(Gen<Int>.choose((0,count-1))) { (expected : Int) in
            let xs       = Array<Float>.random(count: count, using: &self.generator)
            let actual   = test13(xs[expected], xs)

            return (actual == expected) ||
                   (actual != nil && xs[actual!] == xs[expected])
        }
    }
}
