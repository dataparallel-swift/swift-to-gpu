// Copyright (c) 2025 PassiveLogic, Inc.

import Foundation
import SwiftCheck
import SwiftToGPU
import Testing

@Suite("Loop")
struct LoopTests {
    @Suite("For")
    struct ForLoopTests {
        @Suite("Int")
        struct IntTests {
            @Test func forLoop() { forLoopTest(Int.self) }
            @Test func forLoopContinue() { forLoopContinueTest(Int.self) }
            @Test func forLoopBreak() { forLoopBreakTest(Int.self) }
            @Test func forLoopNest() { forLoopNestTest(Int.self) }
            @Test func forLoopNestBreakInner() { forLoopNestBreakInnerTest(Int.self) }
            @Test func forLoopNestBreakOuter() { forLoopNestBreakOuterTest(Int.self) }
        }

        @Suite("Int32")
        struct Int32Tests {
            @Test func forLoop() { forLoopTest(Int32.self) }
            @Test func forLoopContinue() { forLoopContinueTest(Int32.self) }
            @Test func forLoopBreak() { forLoopBreakTest(Int32.self) }
            @Test func forLoopNest() { forLoopNestTest(Int32.self) }
            @Test func forLoopNestBreakInner() { forLoopNestBreakInnerTest(Int32.self) }
            @Test func forLoopNestBreakOuter() { forLoopNestBreakOuterTest(Int32.self) }
        }

        @Suite("Int64")
        struct Int64Tests {
            @Test func forLoop() { forLoopTest(Int64.self) }
            @Test func forLoopContinue() { forLoopContinueTest(Int64.self) }
            @Test func forLoopBreak() { forLoopBreakTest(Int64.self) }
            @Test func forLoopNest() { forLoopNestTest(Int64.self) }
            @Test func forLoopNestBreakInner() { forLoopNestBreakInnerTest(Int64.self) }
            @Test func forLoopNestBreakOuter() { forLoopNestBreakOuterTest(Int64.self) }
        }

        @Suite("UInt")
        struct UIntTests {
            @Test func forLoop() { forLoopTest(UInt.self) }
            @Test func forLoopContinue() { forLoopContinueTest(UInt.self) }
            @Test func forLoopBreak() { forLoopBreakTest(UInt.self) }
            @Test func forLoopNest() { forLoopNestTest(UInt.self) }
            @Test func forLoopNestBreakInner() { forLoopNestBreakInnerTest(UInt.self) }
            @Test func forLoopNestBreakOuter() { forLoopNestBreakOuterTest(UInt.self) }
        }

        @Suite("UInt32")
        struct UInt32Tests {
            @Test func forLoop() { forLoopTest(UInt32.self) }
            @Test func forLoopContinue() { forLoopContinueTest(UInt32.self) }
            @Test func forLoopBreak() { forLoopBreakTest(UInt32.self) }
            @Test func forLoopNest() { forLoopNestTest(UInt32.self) }
            @Test func forLoopNestBreakInner() { forLoopNestBreakInnerTest(UInt32.self) }
            @Test func forLoopNestBreakOuter() { forLoopNestBreakOuterTest(UInt32.self) }
        }

        @Suite("UInt64")
        struct UInt64Tests {
            @Test func forLoop() { forLoopTest(UInt64.self) }
            @Test func forLoopContinue() { forLoopContinueTest(UInt64.self) }
            @Test func forLoopBreak() { forLoopBreakTest(UInt64.self) }
            @Test func forLoopNest() { forLoopNestTest(UInt64.self) }
            @Test func forLoopNestBreakInner() { forLoopNestBreakInnerTest(UInt64.self) }
            @Test func forLoopNestBreakOuter() { forLoopNestBreakOuterTest(UInt64.self) }
        }
    }

    @Suite("While")
    struct WhileLoopTests {
        @Suite("Int")
        struct IntTests {
            @Test func whileLoop() { whileLoopTest(Int.self) }
            @Test func whileLoopContinue() { whileLoopContinueTest(Int.self) }
            @Test func whileLoopBreak() { whileLoopBreakTest(Int.self) }
            @Test func whileLoopNest() { whileLoopNestTest(Int.self) }
            @Test func whileLoopNestBreakInner() { whileLoopNestBreakInnerTest(Int.self) }
            @Test func whileLoopNestBreakOuter() { whileLoopNestBreakOuterTest(Int.self) }
        }

        @Suite("Int32")
        struct Int32Tests {
            @Test func whileLoop() { whileLoopTest(Int32.self) }
            @Test func whileLoopContinue() { whileLoopContinueTest(Int32.self) }
            @Test func whileLoopBreak() { whileLoopBreakTest(Int32.self) }
            @Test func whileLoopNest() { whileLoopNestTest(Int32.self) }
            @Test func whileLoopNestBreakInner() { whileLoopNestBreakInnerTest(Int32.self) }
            @Test func whileLoopNestBreakOuter() { whileLoopNestBreakOuterTest(Int32.self) }
        }

        @Suite("Int64")
        struct Int64Tests {
            @Test func whileLoop() { whileLoopTest(Int64.self) }
            @Test func whileLoopContinue() { whileLoopContinueTest(Int64.self) }
            @Test func whileLoopBreak() { whileLoopBreakTest(Int64.self) }
            @Test func whileLoopNest() { whileLoopNestTest(Int64.self) }
            @Test func whileLoopNestBreakInner() { whileLoopNestBreakInnerTest(Int64.self) }
            @Test func whileLoopNestBreakOuter() { whileLoopNestBreakOuterTest(Int64.self) }
        }

        @Suite("UInt")
        struct UIntTests {
            @Test func whileLoop() { whileLoopTest(UInt.self) }
            @Test func whileLoopContinue() { whileLoopContinueTest(UInt.self) }
            @Test func whileLoopBreak() { whileLoopBreakTest(UInt.self) }
            @Test func whileLoopNest() { whileLoopNestTest(UInt.self) }
            @Test func whileLoopNestBreakInner() { whileLoopNestBreakInnerTest(UInt.self) }
            @Test func whileLoopNestBreakOuter() { whileLoopNestBreakOuterTest(UInt.self) }
        }

        @Suite("UInt32")
        struct UInt32Tests {
            @Test func whileLoop() { whileLoopTest(UInt32.self) }
            @Test func whileLoopContinue() { whileLoopContinueTest(UInt32.self) }
            @Test func whileLoopBreak() { whileLoopBreakTest(UInt32.self) }
            @Test func whileLoopNest() { whileLoopNestTest(UInt32.self) }
            @Test func whileLoopNestBreakInner() { whileLoopNestBreakInnerTest(UInt32.self) }
            @Test func whileLoopNestBreakOuter() { whileLoopNestBreakOuterTest(UInt32.self) }
        }

        @Suite("UInt64")
        struct UInt64Tests {
            @Test func whileLoop() { whileLoopTest(UInt64.self) }
            @Test func whileLoopContinue() { whileLoopContinueTest(UInt64.self) }
            @Test func whileLoopBreak() { whileLoopBreakTest(UInt64.self) }
            @Test func whileLoopNest() { whileLoopNestTest(UInt64.self) }
            @Test func whileLoopNestBreakInner() { whileLoopNestBreakInnerTest(UInt64.self) }
            @Test func whileLoopNestBreakOuter() { whileLoopNestBreakOuterTest(UInt64.self) }
        }

        // non-range based loops, i.e. ones that defy transliteration to range-based for loops for
        @Test("while_loop_collatz") func whileLoopCollatz() {
            func collatz(_ n: Int) -> Int {
                var iterations = 0
                var n = n
                while n != 1 {
                    iterations += 1
                    if n % 2 == 0 {
                        n >>= 1
                    }
                    else {
                        n = 3 * n + 1
                    }
                }
                return iterations
            }
            // Collatz conjecture's iterations complete successfully without intermediate overflows in this range
            let gen = Int.arbitrary.suchThat { $0 > 0 && $0 < 100000 }
            property(#function) <-
                forAllNoShrink(gen.proliferate) { xs in
                    let expected = xs.map(collatz)
                    let actual = map(xs, collatz)
                    return try? #require(expected == actual)
                }
        }
    }
}

// MARK: functions with for loops

private func forLoopTest<T: Arbitrary & FixedWidthInteger>(_: T.Type) {
    func forLoop(_ n: T) -> Int {
        var result = 0
        let start = min(n, 0)
        let end = max(n, 0)
        for _ in start ..< end {
            result += 1
        }
        return result
    }
    property(#function) <-
        forAllNoShrink([T].arbitrary) { (xs: [T]) in
            let expected = xs.map(forLoop)
            let actual = map(xs, forLoop)
            return try? #require(expected == actual)
        }
}

private func forLoopBreakTest<T: Arbitrary & FixedWidthInteger>(_: T.Type) {
    func forLoopBreak(_ n: T, _ mod: Int) -> Int {
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
    property(#function) <-
        forAllNoShrink([T].arbitrary, gen) { (xs: [T], k: Int) in
            let expected = xs.map { x in forLoopBreak(x, k) }
            let actual = map(xs) { x in forLoopBreak(x, k) }
            return try? #require(expected == actual)
        }
}

private func forLoopContinueTest<T: Arbitrary & FixedWidthInteger>(_: T.Type) {
    func forLoopContinue(_ n: T, _ mod: Int) -> Int {
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
    property(#function) <-
        forAllNoShrink([T].arbitrary, gen) { (xs: [T], k: Int) in
            let expected = xs.map { x in forLoopContinue(x, k) }
            let actual = map(xs) { x in forLoopContinue(x, k) }
            return try? #require(expected == actual)
        }
}

private func forLoopNestTest<T: Arbitrary & FixedWidthInteger>(_: T.Type) {
    func forLoopNest(_ k: T, _ n: T) -> Double {
        var result: Double = 0.0 // be comfortable about avoiding overflows
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
    property(#function) <-
        forAllNoShrink([T].arbitrary, [T].arbitrary) { (xs: [T], ys: [T]) in
            let expected = zip(xs, ys).map { x, y in forLoopNest(x, y) }
            let actual = zipWith(xs, ys) { x, y in forLoopNest(x, y) }
            return try? #require(expected == actual)
        }
}

private func forLoopNestBreakInnerTest<T: Arbitrary & FixedWidthInteger>(_: T.Type) {
    func forLoopNestBreakInner(_ k: T, _ n: T) -> Double {
        var result: Double = 0.0 // Double to comfortably avoid overflow
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
    property(#function) <-
        forAllNoShrink([T].arbitrary, [T].arbitrary) { (xs: [T], ys: [T]) in
            let expected = zip(xs, ys).map { x, y in forLoopNestBreakInner(x, y) }
            let actual = zipWith(xs, ys) { x, y in forLoopNestBreakInner(x, y) }
            return try? #require(expected == actual)
        }
}

private func forLoopNestBreakOuterTest<T: Arbitrary & FixedWidthInteger>(_: T.Type) {
    func forLoopNestBreakOuter(_ k: T, _ n: T) -> Double {
        var result: Double = 0.0 // Double to comfortably avoid overflow
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
    property(#function) <-
        forAllNoShrink([T].arbitrary, [T].arbitrary) { (xs: [T], ys: [T]) in
            let expected = zip(xs, ys).map { x, y in forLoopNestBreakOuter(x, y) }
            let actual = zipWith(xs, ys) { x, y in forLoopNestBreakOuter(x, y) }
            return try? #require(expected == actual)
        }
}

private func whileLoopTest<T: Arbitrary & FixedWidthInteger>(_: T.Type) {
    func whileLoop(_ n: T) -> T {
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
    property(#function) <-
        forAllNoShrink([T].arbitrary) { (xs: [T]) in
            let expected = xs.map(whileLoop)
            let actual = map(xs, whileLoop)
            return try? #require(expected == actual)
        }
}

private func whileLoopBreakTest<T: Arbitrary & FixedWidthInteger>(_: T.Type) {
    func whileLoopBreak(_ n: T, _ mod: Int) -> Int {
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
    property(#function) <-
        forAllNoShrink([T].arbitrary, gen) { (xs: [T], k: Int) in
            let expected = xs.map { x in whileLoopBreak(x, k) }
            let actual = map(xs) { x in whileLoopBreak(x, k) }
            return try? #require(expected == actual)
        }
}

private func whileLoopContinueTest<T: Arbitrary & FixedWidthInteger>(_: T.Type) {
    func whileLoopContinue(_ n: T, _ mod: Int) -> Int {
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
    property(#function) <-
        forAllNoShrink([T].arbitrary, gen) { (xs: [T], k: Int) in
            let expected = xs.map { x in whileLoopContinue(x, k) }
            let actual = map(xs) { x in whileLoopContinue(x, k) }
            return try? #require(expected == actual)
        }
}

private func whileLoopNestTest<T: Arbitrary & FixedWidthInteger>(_: T.Type) {
    func whileLoopNest(_ k: T, _ n: T) -> Double {
        var result: Double = 0.0 // be comfortable about avoiding overflows
        let iStart = min(k, 0)
        let iEnd = max(k, 0)
        let jStart = min(n, 0)
        let jEnd = max(n, 0)
        var i = iStart
        while i < iEnd {
            var j = jStart
            while j < jEnd {
                result += Double(i) * Double(j)
                j += 1
            }
            i += 1
        }
        return result
    }
    property(#function) <-
        forAllNoShrink([T].arbitrary, [T].arbitrary) { (xs: [T], ys: [T]) in
            let expected = zip(xs, ys).map { x, y in whileLoopNest(x, y) }
            let actual = zipWith(xs, ys) { x, y in whileLoopNest(x, y) }
            return try? #require(expected == actual)
        }
}

private func whileLoopNestBreakInnerTest<T: Arbitrary & FixedWidthInteger>(_: T.Type) {
    func whileLoopNestBreakInner(_ k: T, _ n: T) -> Double {
        var result: Double = 0.0 // Double to comfortably avoid overflow
        let iStart = min(k, 0)
        let iEnd = max(k, 0)
        let jStart = min(k, 0)
        let jEnd = max(k, 0)
        var i = iStart
        while i < iEnd {
            var j = jStart
            while j < jEnd {
                result += Double(i) * Double(j)
                guard result < Double(k) + Double(n) else {
                    break
                }
                j += 1
            }
            result -= Double(k)
            i += 1
        }
        return result
    }
    property(#function) <-
        forAllNoShrink([T].arbitrary, [T].arbitrary) { (xs: [T], ys: [T]) in
            let expected = zip(xs, ys).map { x, y in whileLoopNestBreakInner(x, y) }
            let actual = zipWith(xs, ys) { x, y in whileLoopNestBreakInner(x, y) }
            return try? #require(expected == actual)
        }
}

private func whileLoopNestBreakOuterTest<T: Arbitrary & FixedWidthInteger>(_: T.Type) {
    func whileLoopNestBreakOuter(_ k: T, _ n: T) -> Double {
        var result: Double = 0.0 // Double to comfortably avoid overflow
        let iStart = min(k, 0)
        let iEnd = max(k, 0)
        let jStart = min(k, 0)
        let jEnd = max(k, 0)
        var i = iStart
        outer: while i < iEnd {
            var j = jStart
            while j < jEnd {
                result += Double(i) * Double(j)
                guard result < Double(k) + Double(n) else {
                    break outer
                }
                j += 1
            }
            i += 1
        }
        return result
    }
    property(#function) <-
        forAllNoShrink([T].arbitrary, [T].arbitrary) { (xs: [T], ys: [T]) in
            let expected = zip(xs, ys).map { x, y in whileLoopNestBreakOuter(x, y) }
            let actual = zipWith(xs, ys) { x, y in whileLoopNestBreakOuter(x, y) }
            return try? #require(expected == actual)
        }
}
