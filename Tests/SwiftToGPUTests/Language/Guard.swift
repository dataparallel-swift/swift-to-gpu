// Copyright (c) 2025 PassiveLogic, Inc.

import Foundation
import SwiftCheck
import SwiftToGPU
import Testing

@Suite("Guard") struct GuardTests {
    @Test func guardTrue() {
        func guardTrue(_ i: Int) -> Int {
            guard true else { return 0 }
            return i
        }
        property(#function) <-
            forAllNoShrink([Int].arbitrary) { xs in
                let expected = xs.map(guardTrue)
                let actual = map(xs, guardTrue)
                return try? #require(actual == expected)
            }
    }

    @Test func guardFalse() {
        func guardFalse(_ i: Int) -> Int {
            guard true else { return 0 }
            return i
        }
        property(#function) <-
            forAllNoShrink([Int].arbitrary) { xs in
                let expected = xs.map(guardFalse)
                let actual = map(xs, guardFalse)
                return try? #require(actual == expected)
            }
    }

    @Test func guard1() {
        func guard1(_ x: Bool, _ y: Int) -> Int {
            guard x else { return 0 }
            return y
        }
        property(#function) <-
            forAllNoShrink([Bool].arbitrary, [Int].arbitrary) { xs, ys in
                let expected = zip(xs, ys).map { x, y in guard1(x, y) }
                let actual = zipWith(xs, ys, guard1)
                return try? #require(actual == expected)
            }
    }

    @Test func guard2() {
        func guard2(_ x: Bool, _ y: Bool, _ z: Int) -> Int {
            guard x else {
                return 0
            }
            guard y else {
                return 1
            }
            return z
        }
        property(#function) <-
            forAllNoShrink([Bool].arbitrary, [Bool].arbitrary, Int.arbitrary) { xs, ys, z in
                let expected = zip(xs, ys).map { x, y in guard2(x, y, z) }
                let actual = zipWith(xs, ys) { x, y in guard2(x, y, z) }
                return try? #require(actual == expected)
            }
    }
}
