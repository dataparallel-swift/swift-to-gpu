import Randy
import XCTest

// Why can't I manually specify the test hierarchy? What a fucking joke...
class Simple : XCTestCase {
    let sizeRange : ClosedRange<Int> = 1...4096
    var generator : SeedableRandomNumberGenerators.RecommendedGenerator = .init()
}

