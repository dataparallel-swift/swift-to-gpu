import Foundation
import SwiftCheck
import SwiftToPTX
import Testing

@Suite("Loops") struct Loops {
    @Suite("For Loops") struct ForLoops {
        @Suite("Int32") struct Int32Tests {
            @Test func test_simple_for_loop() { prop_simple_for_loop(Int32.self) }
            @Test func test_for_loop_break() { prop_for_loop_break(Int32.self) }
            @Test func test_for_loop_continue() { prop_for_loop_continue(Int32.self) }
        }
    }
}

// MARK: functions with for loops
private func prop_simple_for_loop<T: Arbitrary & FixedWidthInteger>(_ proxy: T.Type) {
    func fn(_ n: T) -> T {
        var result: T = 0
        let start = min(n, 0)
        let end = max(n, 0)
        for _ in start..<end {
            result += 1
        }
        return result
    }
    property(String(describing: T.self)+"+simple_for_loop") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map(fn)
        let actual = map(xs, fn)
        return try? #require( expected == actual )
      }
}

private func prop_for_loop_break<T: Arbitrary & FixedWidthInteger>(_ proxy: T.Type) {
    func fn(_ n: T, _ mod: T) -> T {
        var result: T = 0
        let start = min(n, 0)
        let end = max(n, 0)
        for _ in start..<end {
            result += 1
            guard result % mod != 0 else {
                break
            }
        }
        return result
    }
    let gen = T.arbitrary.suchThat { !($0 == 0) }
    property(String(describing: T.self)+"+for_loop_break") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink(gen) { (m: T) in
        let expected = xs.map { x in fn(x, m) }
        let actual = map(xs) { x in fn(x, m) }
        return try? #require( expected == actual )
      }}
}

private func prop_for_loop_continue<T: Arbitrary & FixedWidthInteger>(_ proxy: T.Type) {
    func fn(_ n: T, _ mod: T) -> T {
        var result: T = 0
        let start = min(n, 0)
        let end = max(n, 0)
        for _ in start..<end {
            result += 1
            guard result % mod == 0 else {
                continue
            }
            result %= mod
        }
        return result
    }
    let gen = T.arbitrary.suchThat { !($0 == 0) }
    property(String(describing: T.self)+"+for_loop_continue") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink(gen) { (m: T) in
        let expected = xs.map { x in fn(x, m) }
        let actual = map(xs) { x in fn(x, m) }
        return try? #require( expected == actual )
      }}
}

private func prop_nested_for_loops<T: Arbitrary & FixedWidthInteger>(_ proxy: T.Type) {
    func fn(_ m: T, _ n: T) -> Double {
        var result: Double = 0.0  // be comfortable about avoiding overflows
        let iStart = min(m, 0)
        let iEnd = max(m, 0)
        let jStart = min(m, 0)
        let jEnd = max(m, 0)
        for i in iStart..<iEnd {
            for j in jStart..<jEnd {
                result += Double(i) * Double(j)
            }
        }
        return result
    }
    property(String(describing: T.self)+"+nested_for_loops") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink([T].arbitrary) { (ys: [T]) in
        let expected = zip(xs, ys).map { (x, y) in fn(x, y) }
        let actual = zipWith(xs, ys) { (x, y) in fn(x, y) }
        return try? #require( expected == actual )
      }}
}

private func prop_nested_for_loops_break_inner<T: Arbitrary & FixedWidthInteger>(_ proxy: T.Type) {
    func fn(_ m: T, _ n: T) -> Double {
        var result: Double = 0.0  // Double to comfortably avoid overflow
        let iStart = min(m, 0)
        let iEnd = max(m, 0)
        let jStart = min(m, 0)
        let jEnd = max(m, 0)
        for i in iStart..<iEnd {
            for j in jStart..<jEnd {
                result += Double(i) * Double(j)
                guard result < Double(m) + Double(n) else {
                    break
                }
            }
            result -= Double(m)
        }
        return result
    }
    property(String(describing: T.self)+"+nested_for_loops_break_inner") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink([T].arbitrary) { (ys: [T]) in
        let expected = zip(xs, ys).map { (x, y) in fn(x, y) }
        let actual = zipWith(xs, ys) { (x, y) in fn(x, y) }
        return try? #require( expected == actual )
      }}
}

private func prop_nested_for_loops_break_outer<T: Arbitrary & FixedWidthInteger>(_ proxy: T.Type) {
    func fn(_ m: T, _ n: T) -> Double {
        var result: Double = 0.0  // Double to comfortably avoid overflow
        let iStart = min(m, 0)
        let iEnd = max(m, 0)
        let jStart = min(m, 0)
        let jEnd = max(m, 0)
        outer: for i in iStart..<iEnd {
            for j in jStart..<jEnd {
                result += Double(i) * Double(j)
                guard result < Double(m) + Double(n) else {
                    break outer
                }
            }
        }
        return result
    }
    property(String(describing: T.self)+"+nested_for_loops_break_outer") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink([T].arbitrary) { (ys: [T]) in
        let expected = zip(xs, ys).map { (x, y) in fn(x, y) }
        let actual = zipWith(xs, ys) { (x, y) in fn(x, y) }
        return try? #require( expected == actual )
      }}
}

private func prop_simple_while_loop<T: Arbitrary & FixedWidthInteger>(_ proxy: T.Type) {
    func fn(_ n: T) -> T {
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
    property(String(describing: T.self)+"+simple_while_loop") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map(fn)
        let actual = map(xs, fn)
        return try? #require( expected == actual )
      }
}

private func prop_while_loop_break<T: Arbitrary & FixedWidthInteger>(_ proxy: T.Type) {
    func fn(_ n: T, _ mod: T) -> T {
        var result: T = 0
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
    let gen = T.arbitrary.suchThat { !($0 == 0) }
    property(String(describing: T.self)+"+while_loop_break") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink(gen) { (m: T) in
        let expected = xs.map { x in fn(x, m) }
        let actual = map(xs) { x in fn(x, m) }
        return try? #require( expected == actual )
      }}
}

private func prop_while_loop_continue<T: Arbitrary & FixedWidthInteger>(_ proxy: T.Type) {
    func fn(_ n: T, _ mod: T) -> T {
        var result: T = 0
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
    let gen = T.arbitrary.suchThat { !($0 == 0) }
    property(String(describing: T.self)+"+while_loop_continue") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink(gen) { (m: T) in
        let expected = xs.map { x in fn(x, m) }
        let actual = map(xs) { x in fn(x, m) }
        return try? #require( expected == actual )
      }}
}


// TODO: nested loops
// TODO: nested loops break inner
// TODO: nested loops break outer
