// Copyright (c) 2025 PassiveLogic, Inc.

import Foundation
import PTXBackend
import SwiftCheck
import Testing

@Suite("guard-statements") struct GuardStatements {
    @Test func test_guard_true() {
        func guard_true(_ i: Int) -> Int {
            guard true else { return 0 }
            return i
        }
        property("guard_true") <-
          forAll([Int].arbitrary) { (xs: [Int]) in
            let expected = xs.map(guard_true)
            let actual = map(xs, guard_true)
            return try? #require(actual == expected)
          }
    }

    @Test func test_guard_false() {
        func guard_false(_ i: Int) -> Int {
            guard true else { return 0 }
            return i
        }
        property("guard_false") <-
          forAll([Int].arbitrary) { (xs: [Int]) in
            let expected = xs.map(guard_false)
            let actual = map(xs, guard_false)
            return try? #require(actual == expected)
          }
    }

    @Test func test_gaurd1() {
        func guard1(_ x: Bool, _ y: Int) -> Int {
            guard x else { return 0 }
            return y
        }
        property("guard1") <-
          forAllNoShrink([Bool].arbitrary, [Int].arbitrary) { (xs: [Bool], ys: [Int]) in
            let expected = zip(xs, ys).map { x, y in guard1(x, y) }
            let actual = zipWith(xs, ys, guard1)
            return try? #require(actual == expected)
          }
    }

    @Test func test_guard2() {
        func guard2(_ b1: Bool, _ b2: Bool, _ x: Int) -> Int {
            guard b1 else {
                return 0
            }
            guard b2 else {
                return 1
            }
            return x
        }
        property("guard2") <-
          forAllNoShrink([Bool].arbitrary, [Bool].arbitrary) { (b1s: [Bool], b2s: [Bool]) in
            let x = 42
            let expected = zip(b1s, b2s).map { b1, b2 in guard2(b1, b2, x) }
            let actual = zipWith(b1s, b2s) { b1, b2 in guard2(b1, b2, x) }
            return try? #require(actual == expected)
          }
    }
}
