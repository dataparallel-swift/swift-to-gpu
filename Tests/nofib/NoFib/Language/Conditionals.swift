import Foundation
import SwiftToPTX
import Testing
import SwiftCheck

@Suite("Conditionals") struct Conditionals {
    @Suite("if-else") struct IfElseTests {
        @Test func test_if_true() { prop_if_true() }
        @Test func test_if_false() { prop_if_false() }

        @Suite("Float64") struct Float64Tests {
            @Test func test_if_else() { prop_if_else(Float64.self) }
            @Test func test_if_elseif_else() { prop_if_elseif_else(Float64.self) }
            @Test func test_if_2xelseif_else() { prop_if_2xelseif_else(Float64.self) }
            @Test func test_nested_if() { prop_nested_if(Float64.self) }
        }
        @Suite("Int64") struct Int64Tests {
            @Test func test_if_else() { prop_if_else(Int64.self) }
            @Test func test_if_elseif_else() { prop_if_elseif_else(Int64.self) }
            @Test func test_if_2xelseif_else() { prop_if_2xelseif_else(Int64.self) }
            @Test func test_nested_if() { prop_nested_if(Int64.self) }
        }
    }

    @Suite("guard-statements") struct GuardStatements {
        @Test func test_guard_true() { prop_guard_true() }
        @Test func test_guard_false() { prop_guard_false() }
        @Suite("Int64") struct Int64Tests {
            @Test func test_gaurd1() { prop_guard1(Int64.self) }
            @Test func test_guard2() { prop_guard2(Int64.self) }
        }
        @Suite("Float64") struct Float64Tests {
            @Test func test_gaurd1() { prop_guard1(Float64.self) }
            @Test func test_guard2() { prop_guard2(Float64.self) }
        }
    }

    @Suite("switch-expressions") struct SwitchExpresions {
        @Suite("Int64") struct Int64Tests {
            @Test func test_switch1() { prop_switch1(Int64.self) }
            @Test func test_switch2() { prop_switch2(Int64.self) }
            @Test func test_switch3() { prop_switch3(Int64.self) }
            @Test func test_switch4() { prop_switch4(Int64.self) }
            @Test func test_switch5() { prop_switch5(Int64.self) }
        }
        @Suite("Int32") struct Int32Tests {
            @Test func test_switch1() { prop_switch1(Int32.self) }
            @Test func test_switch2() { prop_switch2(Int32.self) }
            @Test func test_switch3() { prop_switch3(Int32.self) }
            @Test func test_switch4() { prop_switch4(Int32.self) }
            @Test func test_switch5() { prop_switch5(Int32.self) }
        }
        @Suite("Int") struct IntTests {
            @Test func test_switch1() { prop_switch1(Int.self) }
            @Test func test_switch2() { prop_switch2(Int.self) }
            @Test func test_switch3() { prop_switch3(Int.self) }
            @Test func test_switch4() { prop_switch4(Int.self) }
            @Test func test_switch5() { prop_switch5(Int.self) }
        }
    }
}

// MARK: test functions

// MARK: if-statements
private func prop_if_true() {
    func if_true(_ i: Int) -> Int {
        if true { return i }
        return 0
    }
    let count = 100_000
    property("if true") <- forAll(Gen<Int>.choose((0,count-1))) { (expected: Int) in
        let expected = (0..<count).map(if_true)
        let actual = generate(count: count, if_true)
        return try? #require( actual ~~~ expected )
    }
}

private func prop_if_false() {
    func if_false(_ i: Int) -> Int {
        if false { return i }
        return 0
    }
    let count = 100_000
    property("if true") <- forAll(Gen<Int>.choose((0,count-1))) { (expected: Int) in
        let expected = (0..<count).map(if_false)
        let actual = generate(count: count, if_false)
        return try? #require( actual ~~~ expected )
    }
}

private func prop_if_else<T: Arbitrary & Comparable>(_ proxy: T.Type) {
    // NOTE: return type `Int32` is chosen as a conventient way to return different values from different branches.
    // Can be any primitive type representable as integer literal and supported by the device.
    func if_else(_ x: T, _ y: T) -> Int32 {
        if x < y {
            return 0
        } else {
            return 1
        }
    }
    property(String(describing: T.self)+"+if-else") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink([T].arbitrary) { (ys: [T]) in
        let expected = zip(xs, ys).map { (x, y) in if_else(x, y) }
        let actual = zipWith(xs, ys, if_else)
        return try? #require( actual ~~~ expected )
      }}
}

private func prop_if_elseif_else<T: Arbitrary & Comparable>(_ proxy: T.Type) {
    func if_elseif_else(_ x: T, _ y: T) -> Int {
        if x < y {
            return 0
        } else if x == y {
            return 1
        } else {
            return 2
        }
    }
    property(String(describing: T.self)+"+if-elseif-else") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink([T].arbitrary) { (ys: [T]) in
        let expected = zip(xs, ys).map { (x, y) in if_elseif_else(x, y) }
        let actual = zipWith(xs, ys, if_elseif_else)
        return try? #require( actual ~~~ expected )
      }}
}

private func prop_if_2xelseif_else<T: Arbitrary & Comparable & AdditiveArithmetic>(_ proxy: T.Type) {
    func if_2xelseif_else(_ x: T, _ y: T) -> Int32 {
        if x - y > x {
            return 0
        } else if x < y {
            return 1
        } else if x == y{
            return 2
        } else {
            return 3
        }
    }
    property(String(describing: T.self)+"+if-2xelseif-else") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink([T].arbitrary) { (ys: [T]) in
        let expected = zip(xs, ys).map { (x, y) in if_2xelseif_else(x,y) }
        let actual = zipWith(xs, ys, if_2xelseif_else)
        return try? #require( actual ~~~ expected )
      }}
}

private func prop_nested_if<T: Arbitrary & Comparable & AdditiveArithmetic>(_ proxy: T.Type) {
    func nested_if(_ x: T, _ y: T) -> Int32 {
        if x < y {
            if x < T.zero {
                return 0
            }
            return 1
        }
        return 2
    }
    property(String(describing: T.self)+".nested-if") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink([T].arbitrary) { (ys: [T]) in
        let expected = zip(xs, ys).map { (x, y) in nested_if(x,y) }
        let actual = zipWith(xs, ys, nested_if)
        return try? #require( actual ~~~ expected )
      }}
}


// MARK: guard-statements
private func prop_guard_true() {
    func guard_true(_ x: Int) -> Int {
        guard true else { return 0 }
        return 1
    }
    let count = 100_000
    property("guard-true") <- forAll(Gen<Int>.choose((0,count-1))) { (expected: Int) in
        let expected = (0..<count).map(guard_true)
        let actual = generate(count: count, guard_true)
        return try? #require( actual ~~~ expected )
    }
}

private func prop_guard_false() {
    func guard_true(_ i: Int) -> Int {
        guard true else { return i }
        return 1
    }
    let count = 100_000
    property("guard-false") <- forAll(Gen<Int>.choose((0,count-1))) { (expected: Int) in
        let expected = (0..<count).map(guard_true)
        let actual = generate(count: count, guard_true)
        return try? #require( actual ~~~ expected )
    }
}

private func prop_guard1<T: Arbitrary & Comparable>(_ proxy: T.Type) {
    func guard1(_ x: T, _ y: T) -> Int32 {
        guard x > y else { return 0 }
        return 1
    }
    property(String(describing: T.self)+"+guard") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink([T].arbitrary) { (ys: [T]) in
        let expected = zip(xs, ys).map { (x, y) in guard1(x,y) }
        let actual = zipWith(xs, ys, guard1)
        return try? #require( actual ~~~ expected )
      }}
}
private func prop_guard2<T: Arbitrary & Comparable & AdditiveArithmetic & Numeric>(_ proxy: T.Type) {
    func guard2(_ x: T, _ y: T) -> Int32 {
        let z = x + y
        guard z < x else {
            return 0
        }
        let w = y * z
        guard w == x else {
            return 1
        }
        return 2
    }
    property(String(describing: T.self)+"+guard") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink([T].arbitrary) { (ys: [T]) in
        let expected = zip(xs, ys).map { (x, y) in guard2(x,y) }
        let actual = zipWith(xs, ys, guard2)
        return try? #require( actual ~~~ expected )
      }}
}

// // MARK: switch-expressions
private func prop_switch1<T: Arbitrary & Similar & FixedWidthInteger & ExpressibleByIntegerLiteral>(_ proxy: T.Type) {
    func fn(_ x: T) -> T {
        return switch x {
        case 0: 0
        default: x
        }
    }
    property(String(describing: T.self)+"+switch") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { x in fn(x) }
        let actual = map(xs, fn)
        return try? #require( actual ~~~ expected )
      }
}

private func prop_switch2<T: Arbitrary & Similar & FixedWidthInteger & ExpressibleByIntegerLiteral>(_ proxy: T.Type) {
    func fn(_ x: T) -> T {
        return switch x {
            case 0: 0
            case 1: 2
            default: x
        }
    }
    property(String(describing: T.self)+"+switch") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { x in fn(x) }
        let actual = map(xs, fn)
        return try? #require( actual ~~~ expected )
      }
}

private func prop_switch3<T: Arbitrary & Similar & FixedWidthInteger & ExpressibleByIntegerLiteral & AdditiveArithmetic>(_ proxy: T.Type) {
    func fn(_ x: T) -> T {
        let y = x + 42
        return switch y {
            case 0: 0
            case 1: x
            default: y
        }
    }
    property(String(describing: T.self)+"+switch") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { x in fn(x) }
        let actual = map(xs, fn)
        return try? #require( actual ~~~ expected )
      }
}

private func prop_switch4<T: Arbitrary & Similar & FixedWidthInteger & ExpressibleByIntegerLiteral & AdditiveArithmetic>(_ proxy: T.Type) {
    func fn(_ x: T) -> T {
        var y = x
        switch x {
            case 0: y += 1
            default: return y
        }
        return y
    }
    property(String(describing: T.self)+"+switch") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map(fn) 
        let actual = map(xs, fn)
        return try? #require( actual ~~~ expected )
      }
}

private func prop_switch5<T: Arbitrary & Similar & FixedWidthInteger & ExpressibleByIntegerLiteral & AdditiveArithmetic>(_ proxy: T.Type) {
    func fn(_ x: T) -> T {
        var y = x
        switch x {
            case 0: y += 1
            default: break
        }
        return y
    }
    property(String(describing: T.self)+"+switch") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map(fn) 
        let actual = map(xs, fn)
        return try? #require( actual ~~~ expected )
      }
}
