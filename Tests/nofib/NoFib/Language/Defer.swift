import SwiftToPTX
import Testing
import Foundation

@Suite("defer") struct DeferSuite {
    @Test("defer") func test_defer() {
        let xs = [Double].random(count: 1017, using: &generator)
        test_transfer(input: xs, d1)
        test_transfer(input: xs, d2)
    }
}

@inline(__always)
private func test_transfer<A, B: Similar>(input xs: [A], _ fn: (A) -> B) {
    #expect(map(xs, stream: streamPerThread, fn) ~~~ xs.map(fn))
}
private func d1(_ x: Double) -> Double {
    var x = x
    defer { x *= 2.0 }
    x += 1.0
    return x
}
private func d2(_ x: Double) -> Double {
    var x = x
    var i = 0
    while i < 10 {
        defer { i += 1 }
        x /= 3.0
        x *= Double(i)
    }
    return x
}
