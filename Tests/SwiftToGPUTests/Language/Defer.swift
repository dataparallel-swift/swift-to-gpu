// Copyright (c) 2025 PassiveLogic, Inc.

import Foundation
import SwiftCheck
import SwiftToGPU
import Testing

@Suite("Defer") struct DeferTests {
    @Test func defer1() {
        func defer1(_ x: Double) -> Double {
            var x = x
            defer { x *= 2 }
            x += 1
            return x
        }
        property(#function) <-
            forAllNoShrink([Double].arbitrary) { xs in
                let expected = xs.map(defer1)
                let actual = map(xs, defer1)
                return try? #require(expected ~~~ actual)
            }
    }

    @Test func defer2() {
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
        property(#function) <-
            forAllNoShrink([Double].arbitrary) { xs in
                let expected = xs.map(defer2)
                let actual = map(xs, defer2)
                return try? #require(expected ~~~ actual)
            }
    }

    // TODO: More tests, defer interacting with for loops, while loops,
    // switch statements, in general multiple exit blocks
}
