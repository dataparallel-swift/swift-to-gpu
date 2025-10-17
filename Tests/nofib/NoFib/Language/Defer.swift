// Copyright (c) 2025 PassiveLogic, Inc.

import Foundation
import SwiftCheck
import SwiftToPTX
import Testing

@Suite("defer") struct DeferSuite {
    @Test func test_defer1() { prop_defer1(Float32.self) }
    @Test func test_defer2() { prop_defer2(Float32.self) }
    // TODO: More tests, defer interacting with for loops, while loops, switch statements, in general multiple exit blocks
}

private func prop_defer1<T: Numeric & Arbitrary & Similar>(_: T.Type) {
    func defer1(_ x: T) -> T {
        var x = x
        defer { x *= 2 }
        x += 1
        return x
    }
    property(String(describing: T.self) + ".defer1") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map(defer1)
        let actual = map(xs, defer1)
        return try? #require(expected ~~~ actual)
      }
}

private func prop_defer2<T: Numeric & Arbitrary & Similar & Comparable>(_: T.Type) {
    func defer2(_ x: T) -> T {
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
    property(String(describing: T.self) + ".defer2") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map(defer2)
        let actual = map(xs, defer2)
        return try? #require(expected ~~~ actual)
      }
}
