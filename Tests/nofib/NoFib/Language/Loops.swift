// Copyright (c) 2025 PassiveLogic, Inc.

import Foundation
import SwiftCheck
import SwiftToPTX
import Testing

// swiftlint:disable file_length type_body_length

// swiftformat:disable wrap wrapArguments wrapSingleLineComments trailingCommas blankLinesBetweenScopes
@Suite("Loops") struct Loops {
    @Suite("ForLoops") struct ForLoops {
        @Test("simple_for_loop.Int") func test_simple_for_loop_1() { prop_simple_for_loop(Int.self) }
        @Test("simple_for_loop.Int32") func test_simple_for_loop_2() { prop_simple_for_loop(Int32.self) }
        @Test("simple_for_loop.UInt") func test_simple_for_loop_3() { prop_simple_for_loop(UInt.self) }
        @Test("simple_for_loop.UInt32") func test_simple_for_loop_4() { prop_simple_for_loop(UInt32.self) }

        @Test("for_loop_continue.Int") func test_for_loop_continue_1() { prop_for_loop_continue(Int.self) }
        @Test("for_loop_continue.Int32") func test_for_loop_continue_2() { prop_for_loop_continue(Int32.self) }
        @Test("for_loop_continue.UInt") func test_for_loop_continue_3() { prop_for_loop_continue(UInt.self) }
        @Test("for_loop_continue.UInt32") func test_for_loop_continue_4() { prop_for_loop_continue(UInt32.self) }

        @Test("for_loop_break.Int") func test_for_loop_break_1() { prop_for_loop_break(Int.self) }
        @Test("for_loop_break.Int32") func test_for_loop_break_2() { prop_for_loop_break(Int32.self) }
        @Test("for_loop_break.UInt") func test_for_loop_break_3() { prop_for_loop_break(UInt.self) }
        @Test("for_loop_break.UInt32") func test_for_loop_break_4() { prop_for_loop_break(UInt32.self) }

        @Test("nested_for_loop.Int") func test_nested_for_loop_1() { prop_nested_for_loops(Int.self) }
        @Test("nested_for_loop.Int32") func test_nested_for_loop_2() { prop_nested_for_loops(Int32.self) }
        @Test("nested_for_loop.UInt") func test_nested_for_loop_3() { prop_nested_for_loops(UInt.self) }
        @Test("nested_for_loop.UInt32") func test_nested_for_loop_4() { prop_nested_for_loops(UInt32.self) }

        @Test("nested_for_loops_break_inner.Int") func test_nested_for_loops_break_inner_1() { prop_nested_for_loops_break_inner(Int.self) }
        @Test("nested_for_loops_break_inner.Int32") func test_nested_for_loops_break_inner_2() { prop_nested_for_loops_break_inner(Int32.self) }
        @Test("nested_for_loops_break_inner.UInt") func test_nested_for_loops_break_inner_3() { prop_nested_for_loops_break_inner(UInt.self) }
        @Test("nested_for_loops_break_inner.UInt32") func test_nested_for_loops_break_inner_4() { prop_nested_for_loops_break_inner(UInt32.self) }

        @Test("nested_for_loops_break_outer.Int") func test_nested_for_loops_break_outer_1() { prop_nested_for_loops_break_outer(Int.self) }
        @Test("nested_for_loops_break_outer.Int32") func test_nested_for_loops_break_outer_2() { prop_nested_for_loops_break_outer(Int32.self) }
        @Test("nested_for_loops_break_outer.UInt") func test_nested_for_loops_break_outer_3() { prop_nested_for_loops_break_outer(UInt.self) }
        @Test("nested_for_loops_break_outer.UInt32") func test_nested_for_loops_break_outer_4() { prop_nested_for_loops_break_outer(UInt32.self) }
    }

    @Suite("WhileLoops") struct WhileLoops {
        @Test("simple_while_loop.Int") func test_simple_while_loop_1() { prop_simple_while_loop(Int.self) }
        @Test("simple_while_loop.Int32") func test_simple_while_loop_2() { prop_simple_while_loop(Int32.self) }
        @Test("simple_while_loop.UInt") func test_simple_while_loop_3() { prop_simple_while_loop(UInt.self) }
        @Test("simple_while_loop.UInt32") func test_simple_while_loop_4() { prop_simple_while_loop(UInt32.self) }

        @Test("while_loop_break.Int") func test_while_loop_break_1() { prop_while_loop_break(Int.self) }
        @Test("while_loop_break.Int32") func test_while_loop_break_2() { prop_while_loop_break(Int32.self) }
        @Test("while_loop_break.UInt") func test_while_loop_break_3() { prop_while_loop_break(UInt.self) }
        @Test("while_loop_break.UInt32") func test_while_loop_break_4() { prop_while_loop_break(UInt32.self) }

        @Test("while_loop_continue.Int") func test_while_loop_continue_1() { prop_while_loop_continue(Int.self) }
        @Test("while_loop_continue.Int32") func test_while_loop_continue_2() { prop_while_loop_continue(Int32.self) }
        @Test("while_loop_continue.UInt") func test_while_loop_continue_3() { prop_while_loop_continue(UInt.self) }
        @Test("while_loop_continue.UInt32") func test_while_loop_continue_4() { prop_while_loop_continue(UInt32.self) }
    }
}

// MARK: functions with for loops

private func prop_simple_for_loop<T: Arbitrary & FixedWidthInteger>(_: T.Type) {
    func simple_for_loop(_ n: T) -> Int {
        var result = 0
        let start = min(n, 0)
        let end = max(n, 0)
        for _ in start ..< end {
            result += 1
        }
        return result
    }
    property(String(describing: T.self) + ".simple_for_loop") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map(simple_for_loop)
        let actual = map(xs, simple_for_loop)
        return try? #require(expected == actual)
      }
}

private func prop_for_loop_break<T: Arbitrary & FixedWidthInteger>(_: T.Type) {
    func for_loop_break(_ n: T, _ mod: Int) -> Int {
        var result = 0
        let start = min(n, 0)
        let end = max(n, 0)
        for _ in start ..< end {
            result += 1
            guard result % mod != 0 else {
                break
            }
        }
        return result
    }
    let gen = Int.arbitrary.suchThat { $0 != 0 }
    property(String(describing: T.self) + ".for_loop_break") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink(gen) { (k: Int) in
        let expected = xs.map { x in for_loop_break(x, k) }
        let actual = map(xs) { x in for_loop_break(x, k) }
        return try? #require(expected == actual)
      }}
}

private func prop_for_loop_continue<T: Arbitrary & FixedWidthInteger>(_: T.Type) {
    func for_loop_continue(_ n: T, _ mod: Int) -> Int {
        var result = 0
        let start = min(n, 0)
        let end = max(n, 0)
        for _ in start ..< end {
            result += 1
            guard result % mod == 0 else {
                continue
            }
            result %= mod
        }
        return result
    }
    let gen = Int.arbitrary.suchThat { $0 != 0 }
    property(String(describing: T.self) + ".for_loop_continue") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink(gen) { (k: Int) in
        let expected = xs.map { x in for_loop_continue(x, k) }
        let actual = map(xs) { x in for_loop_continue(x, k) }
        return try? #require(expected == actual)
      }}
}

private func prop_nested_for_loops<T: Arbitrary & FixedWidthInteger>(_: T.Type) {
    func nested_for_loops(_ k: T, _ n: T) -> Double {
        var result: Double = 0.0  // be comfortable about avoiding overflows
        let iStart = min(k, 0)
        let iEnd = max(k, 0)
        let jStart = min(n, 0)
        let jEnd = max(n, 0)
        for i in iStart ..< iEnd {
            for j in jStart ..< jEnd {
                result += Double(i) * Double(j)
            }
        }
        return result
    }
    property(String(describing: T.self) + ".nested_for_loops") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink([T].arbitrary) { (ys: [T]) in
        let expected = zip(xs, ys).map { x, y in nested_for_loops(x, y) }
        let actual = zipWith(xs, ys) { x, y in nested_for_loops(x, y) }
        return try? #require(expected == actual)
      }}
}

private func prop_nested_for_loops_break_inner<T: Arbitrary & FixedWidthInteger>(_: T.Type) {
    func nested_for_loops_break_inner(_ k: T, _ n: T) -> Double {
        var result: Double = 0.0  // Double to comfortably avoid overflow
        let iStart = min(k, 0)
        let iEnd = max(k, 0)
        let jStart = min(k, 0)
        let jEnd = max(k, 0)
        for i in iStart ..< iEnd {
            for j in jStart ..< jEnd {
                result += Double(i) * Double(j)
                guard result < Double(k) + Double(n) else {
                    break
                }
            }
            result -= Double(k)
        }
        return result
    }
    property(String(describing: T.self) + ".nested_for_loops_break_inner") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink([T].arbitrary) { (ys: [T]) in
        let expected = zip(xs, ys).map { x, y in nested_for_loops_break_inner(x, y) }
        let actual = zipWith(xs, ys) { x, y in nested_for_loops_break_inner(x, y) }
        return try? #require(expected == actual)
      }}
}

private func prop_nested_for_loops_break_outer<T: Arbitrary & FixedWidthInteger>(_: T.Type) {
    func nested_for_loops_break_outer(_ k: T, _ n: T) -> Double {
        var result: Double = 0.0  // Double to comfortably avoid overflow
        let iStart = min(k, 0)
        let iEnd = max(k, 0)
        let jStart = min(k, 0)
        let jEnd = max(k, 0)
        outer: for i in iStart ..< iEnd {
            for j in jStart ..< jEnd {
                result += Double(i) * Double(j)
                guard result < Double(k) + Double(n) else {
                    break outer
                }
            }
        }
        return result
    }
    property(String(describing: T.self) + ".nested_for_loops_break_outer") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink([T].arbitrary) { (ys: [T]) in
        let expected = zip(xs, ys).map { x, y in nested_for_loops_break_outer(x, y) }
        let actual = zipWith(xs, ys) { x, y in nested_for_loops_break_outer(x, y) }
        return try? #require(expected == actual)
      }}
}

private func prop_simple_while_loop<T: Arbitrary & FixedWidthInteger>(_: T.Type) {
    func simple_while_loop(_ n: T) -> T {
        var result: T = 0
        let start = min(n, 0)
        let end = max(n, 0)
        var i: T = start
        while i < end {
            result += 1
            i += 1
        }
        return result
    }
    property(String(describing: T.self) + ".simple_while_loop") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map(simple_while_loop)
        let actual = map(xs, simple_while_loop)
        return try? #require(expected == actual)
      }
}

private func prop_while_loop_break<T: Arbitrary & FixedWidthInteger>(_: T.Type) {
    func while_loop_break(_ n: T, _ mod: Int) -> Int {
        var result = 0
        let start = min(n, 0)
        let end = max(n, 0)
        var i: T = start
        while i < end {
            result += 1
            guard result % mod != 0 else {
                break
            }
            i += 1
        }
        return result
    }
    let gen = Int.arbitrary.suchThat { $0 != 0 }
    property(String(describing: T.self) + ".while_loop_break") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink(gen) { (k: Int) in
        let expected = xs.map { x in while_loop_break(x, k) }
        let actual = map(xs) { x in while_loop_break(x, k) }
        return try? #require(expected == actual)
      }}
}

private func prop_while_loop_continue<T: Arbitrary & FixedWidthInteger>(_: T.Type) {
    func while_loop_continue(_ n: T, _ mod: Int) -> Int {
        var result = 0
        let start = min(n, 0)
        let end = max(n, 0)
        var i: T = start
        while i < end {
            result += 1
            guard result % mod == 0 else {
                i += 1
                continue
            }
            result %= mod
            i += 1
        }
        return result
    }
    let gen = Int.arbitrary.suchThat { $0 != 0 }
    property(String(describing: T.self) + ".while_loop_continue") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink(gen) { (k: Int) in
        let expected = xs.map { x in while_loop_continue(x, k) }
        let actual = map(xs) { x in while_loop_continue(x, k) }
        return try? #require(expected == actual)
      }}
}
