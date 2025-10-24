// Copyright (c) 2025 PassiveLogic, Inc.

import Foundation
import SwiftCheck
import SwiftToPTX
import Testing

@Suite("defer") struct DeferSuite {
    @Test func test_defer1() { prop_defer1() }
    @Test func test_defer2() { prop_defer2() }
    // TODO: More tests, defer interacting with for loops, while loops,
    // switch statements, in general multiple exit blocks
}

private func prop_defer1() {
    func defer1(_ x: Double) -> Double {
        var x = x
        defer { x *= 2 }
        x += 1
        return x
    }
    property("defer1") <-
      forAllNoShrink([Double].arbitrary) { (xs: [Double]) in
        let expected = xs.map(defer1)
        let actual = map(xs, defer1)
        return try? #require(expected ~~~ actual)
      }
}

private func prop_defer2() {
    func defer2(_ x: Double) -> Double {
        var x = x
        var i = 0
        while i < 10 {
            defer { i += 1 }
            x *= 3
            if x < 3 {
                x += 2
            }
            else {
                x -= 2
            }
        }
        return x
    }
    property("defer2") <-
      forAllNoShrink([Double].arbitrary) { (xs: [Double]) in
        let expected = xs.map(defer2)
        let actual = map(xs, defer2)
        return try? #require(expected ~~~ actual)
      }
}
