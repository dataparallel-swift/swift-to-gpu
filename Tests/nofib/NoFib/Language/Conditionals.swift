// Copyright (c) 2025 PassiveLogic, Inc.

import Foundation
import SwiftCheck
import SwiftToPTX
import Testing

@Suite("Conditionals") struct Conditionals {
    @Suite("if-else") struct IfElseTests {
        @Test func test_if_true() {
            func if_true(_ i: Int) -> Int {
                if true { return i }
                return 0
            }
            property("if_true") <-
              forAllNoShrink([Int].arbitrary) { (xs: [Int]) in
                let expected = xs.map(if_true)
                let actual = map(xs, if_true)
                return try? #require(actual == expected)
              }
        }

        @Test func test_if_false() {
            func if_false(_ i: Int) -> Int {
                if false { return i }
                return 0
            }
            property("if_false") <-
              forAllNoShrink([Int].arbitrary) { (xs: [Int]) in
                let expected = xs.map(if_false)
                let actual = map(xs, if_false)
                return try? #require(actual == expected)
              }
        }

        @Test func test_if() {
            func if_(_ x: Bool, _ y: Int) -> Int {
                if x {
                    return y
                }
                return 0
            }
            property("if") <-
              forAllNoShrink([Bool].arbitrary) { (xs: [Bool]) in
              forAllNoShrink([Int].arbitrary) { (ys: [Int]) in
                let expected = zip(xs, ys).map { x, y in if_(x, y) }
                let actual = zipWith(xs, ys) { x, y in if_(x, y) }
                return try? #require(actual == expected)
              }}
        }

        @Test func test_ternary_operator() {
            func ternary(_ x: Bool, _ y: Int) -> Int {
                x ? y : 0
            }
            property("ternary") <-
              forAllNoShrink([Bool].arbitrary) { (xs: [Bool]) in
              forAllNoShrink([Int].arbitrary) { (ys: [Int]) in
                let expected = zip(xs, ys).map { x, y in ternary(x, y) }
                let actual = zipWith(xs, ys) { x, y in ternary(x, y) }
                return try? #require(actual == expected)
              }}
        }

        @Test func test_if_else1() {
            func if_else(_ x: Bool, _ y: Int) -> Int {
                if x {
                    return y
                }
                else {
                    return 0
                }
            }
            property("if_else") <-
              forAllNoShrink([Bool].arbitrary) { (xs: [Bool]) in
              forAllNoShrink([Int].arbitrary) { (ys: [Int]) in
                let expected = zip(xs, ys).map { x, y in if_else(x, y) }
                let actual = zipWith(xs, ys, if_else)
                return try? #require(actual == expected)
              }}
        }

        @Test func test_if_else2() {
            func if_else2(_ b1: Bool, _ b2: Bool, _ x: Int) -> Int {
                if b1 {
                    return x
                }
                else if b2 {
                    return 0
                }
                else {
                    return 1
                }
            }
            property("if_else2") <-
              forAllNoShrink([Bool].arbitrary) { (b1s: [Bool]) in
              forAllNoShrink([Bool].arbitrary) { (b2s: [Bool]) in
              forAllNoShrink(Int.arbitrary) { (x: Int) in
                let expected = zip(b1s, b2s).map { b1, b2 in if_else2(b1, b2, x) }
                let actual = zipWith(b1s, b2s) { b1, b2 in if_else2(b1, b2, x) }
                return try? #require(actual == expected)
              }}}
        }

        @Test func test_if_else3() {
            func if_else3(_ b1: Bool, _ b2: Bool, _ b3: Bool, _ x: Int) -> Int {
                if b1 {
                    return x
                }
                else if b2 {
                    return 0
                }
                else if b3 {
                    return 1
                }
                else {
                    return 2
                }
            }
            property("if_else3") <-
              forAllNoShrink([Bool].arbitrary) { (b1s: [Bool]) in
              forAllNoShrink([Bool].arbitrary) { (b2s: [Bool]) in
              forAllNoShrink(Bool.arbitrary) { (b3: Bool) in
              forAllNoShrink(Int.arbitrary) { (x: Int) in
                let expected = zip(b1s, b2s).map { b1, b2 in if_else3(b1, b2, b3, x) }
                let actual = zipWith(b1s, b2s) { b1, b2 in if_else3(b1, b2, b3, x) }
                return try? #require(actual == expected)
              }}}}
        }

        @Test func test_nested_if() {
            func nested_if(_ b1: Bool, _ b2: Bool, _ x: Int) -> Int {
                if b1 {
                    if b2 {
                        return x
                    }
                    return 0
                }
                return 1
            }
            property("nested_if") <-
              forAllNoShrink([Bool].arbitrary) { (b1s: [Bool]) in
              forAllNoShrink([Bool].arbitrary) { (b2s: [Bool]) in
              forAllNoShrink(Int.arbitrary) { (x: Int) in
                let expected = zip(b1s, b2s).map { b1, b2 in nested_if(b1, b2, x) }
                let actual = zipWith(b1s, b2s) { b1, b2 in nested_if(b1, b2, x) }
                return try? #require(actual == expected)
              }}}
        }
    }

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
              forAllNoShrink([Bool].arbitrary) { (xs: [Bool]) in
              forAllNoShrink([Int].arbitrary) { (ys: [Int]) in
                let expected = zip(xs, ys).map { x, y in guard1(x, y) }
                let actual = zipWith(xs, ys, guard1)
                return try? #require(actual == expected)
              }}
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
              forAllNoShrink([Bool].arbitrary) { (b1s: [Bool]) in
              forAllNoShrink([Bool].arbitrary) { (b2s: [Bool]) in
                let x = 42
                let expected = zip(b1s, b2s).map { b1, b2 in guard2(b1, b2, x) }
                let actual = zipWith(b1s, b2s) { b1, b2 in guard2(b1, b2, x) }
                return try? #require(actual == expected)
              }}
        }
    }

    @Suite("switch-expressions") struct SwitchExpresions {
        @Test("switch1.Int") func test_switch1_1() { prop_switch1(Int.self) }
        @Test("switch1.Int8") func test_switch1_2() { prop_switch1(Int8.self) }
        @Test("switch1.Int16") func test_switch1_3() { prop_switch1(Int16.self) }
        @Test("switch1.Int32") func test_switch1_4() { prop_switch1(Int32.self) }
        @Test("switch1.Int64") func test_switch1_5() { prop_switch1(Int64.self) }
        @Test("switch1.UInt") func test_switch1_6() { prop_switch1(UInt.self) }
        @Test("switch1.UInt8") func test_switch1_7() { prop_switch1(UInt8.self) }
        @Test("switch1.UInt16") func test_switch1_8() { prop_switch1(UInt16.self) }
        @Test("switch1.UInt32") func test_switch1_9() { prop_switch1(UInt32.self) }
        @Test("switch1.UInt64") func test_switch1_10() { prop_switch1(UInt64.self) }

        @Test("switch2.Int") func test_switch2_1() { prop_switch2(Int.self) }
        @Test("switch2.Int8") func test_switch2_2() { prop_switch2(Int8.self) }
        @Test("switch2.Int16") func test_switch2_3() { prop_switch2(Int16.self) }
        @Test("switch2.Int32") func test_switch2_4() { prop_switch2(Int32.self) }
        @Test("switch2.Int64") func test_switch2_5() { prop_switch2(Int64.self) }
        @Test("switch2.UInt") func test_switch2_6() { prop_switch2(UInt.self) }
        @Test("switch2.UInt8") func test_switch2_7() { prop_switch2(UInt8.self) }
        @Test("switch2.UInt16") func test_switch2_8() { prop_switch2(UInt16.self) }
        @Test("switch2.UInt32") func test_switch2_9() { prop_switch2(UInt32.self) }
        @Test("switch2.UInt64") func test_switch2_10() { prop_switch2(UInt64.self) }

        @Test("switch3.Int") func test_switch3_1() { prop_switch3(Int.self) }
        @Test("switch3.Int8") func test_switch3_2() { prop_switch3(Int8.self) }
        @Test("switch3.Int16") func test_switch3_3() { prop_switch3(Int16.self) }
        @Test("switch3.Int32") func test_switch3_4() { prop_switch3(Int32.self) }
        @Test("switch3.Int64") func test_switch3_5() { prop_switch3(Int64.self) }
        @Test("switch3.UInt") func test_switch3_6() { prop_switch3(UInt.self) }
        @Test("switch3.UInt8") func test_switch3_7() { prop_switch3(UInt8.self) }
        @Test("switch3.UInt16") func test_switch3_8() { prop_switch3(UInt16.self) }
        @Test("switch3.UInt32") func test_switch3_9() { prop_switch3(UInt32.self) }
        @Test("switch3.UInt64") func test_switch3_10() { prop_switch3(UInt64.self) }

        // @Test("switch4.Int", .bug(id: "86b6xaz1f")) func test_switch4_1() { prop_switch4(Int.self) }
        // @Test("switch4.Int8", .bug(id: "86b6xaz1f")) func test_switch4_2() { prop_switch4(Int8.self) }
        // @Test("switch4.Int16", .bug(id: "86b6xaz1f")) func test_switch4_3() { prop_switch4(Int16.self) }
        // @Test("switch4.Int32", .bug(id: "86b6xaz1f")) func test_switch4_4() { prop_switch4(Int32.self) }
        // @Test("switch4.Int64", .bug(id: "86b6xaz1f")) func test_switch4_5() { prop_switch4(Int64.self) }
        // @Test("switch4.UInt", .bug(id: "86b6xaz1f")) func test_switch4_6() { prop_switch4(UInt.self) }
        // @Test("switch4.UInt8", .bug(id: "86b6xaz1f")) func test_switch4_7() { prop_switch4(UInt8.self) }
        // @Test("switch4.UInt16", .bug(id: "86b6xaz1f")) func test_switch4_8() { prop_switch4(UInt16.self) }
        // @Test("switch4.UInt32", .bug(id: "86b6xaz1f")) func test_switch4_9() { prop_switch4(UInt32.self) }
        // @Test("switch4.UInt64", .bug(id: "86b6xaz1f")) func test_switch4_10() { prop_switch4(UInt64.self) }

        @Test("switch5.Int") func test_switch5_1() { prop_switch5(Int.self) }
        @Test("switch5.Int8") func test_switch5_2() { prop_switch5(Int8.self) }
        @Test("switch5.Int16") func test_switch5_3() { prop_switch5(Int16.self) }
        @Test("switch5.Int32") func test_switch5_4() { prop_switch5(Int32.self) }
        @Test("switch5.Int64") func test_switch5_5() { prop_switch5(Int64.self) }
        @Test("switch5.UInt") func test_switch5_6() { prop_switch5(UInt.self) }
        @Test("switch5.UInt8") func test_switch5_7() { prop_switch5(UInt8.self) }
        @Test("switch5.UInt16") func test_switch5_8() { prop_switch5(UInt16.self) }
        @Test("switch5.UInt32") func test_switch5_9() { prop_switch5(UInt32.self) }
        @Test("switch5.UInt64") func test_switch5_10() { prop_switch5(UInt64.self) }

        @Test("switch6.Int") func test_switch6_1() { prop_switch6(Int.self) }
        @Test("switch6.Int8") func test_switch6_2() { prop_switch6(Int8.self) }
        @Test("switch6.Int16") func test_switch6_3() { prop_switch6(Int16.self) }
        @Test("switch6.Int32") func test_switch6_4() { prop_switch6(Int32.self) }
        @Test("switch6.Int64") func test_switch6_5() { prop_switch6(Int64.self) }
        @Test("switch6.UInt") func test_switch6_6() { prop_switch6(UInt.self) }
        @Test("switch6.UInt8") func test_switch6_7() { prop_switch6(UInt8.self) }
        @Test("switch6.UInt16") func test_switch6_8() { prop_switch6(UInt16.self) }
        @Test("switch6.UInt32") func test_switch6_9() { prop_switch6(UInt32.self) }
        @Test("switch6.UInt64") func test_switch6_10() { prop_switch6(UInt64.self) }
    }
}

private func prop_switch1<T: Arbitrary & Equatable & FixedWidthInteger & ExpressibleByIntegerLiteral>(_: T.Type) {
    func switch1(_ x: T) -> T {
        switch x {
            case 0: 42
            default: x
        }
    }
    property(String(describing: T.self) + ".switch1") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { x in switch1(x) }
        let actual = map(xs, switch1)
        return try? #require(actual == expected)
      }
}

private func prop_switch2<T: Arbitrary & Equatable & FixedWidthInteger & ExpressibleByIntegerLiteral>(_: T.Type) {
    func switch2(_ x: T) -> T {
        switch x {
            case 0: 0
            case 1: 2
            default: x
        }
    }
    property(String(describing: T.self) + ".switch2") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { x in switch2(x) }
        let actual = map(xs, switch2)
        return try? #require(actual == expected)
      }
}

private func prop_switch3<T: Arbitrary & Equatable & FixedWidthInteger & ExpressibleByIntegerLiteral>(_: T.Type) {
    func switch3(_ x: T) -> T {
        // introduce non-contiguity in the cases
        switch x {
            case 0: 1
            case 1: 3
            case 4: 7
            default: x
        }
    }
    property(String(describing: T.self) + ".switch3") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { x in switch3(x) }
        let actual = map(xs, switch3)
        return try? #require(actual == expected)
      }
}

private func prop_switch4<T: Arbitrary & Equatable & FixedWidthInteger & ExpressibleByIntegerLiteral>(_: T.Type) {
    func switch4(_ x: T) -> T {
        switch x {
            case 0: 1
            case 1: 3
            case 4: 7
            case 7: 255
            default: x
        }
    }
    property(String(describing: T.self) + ".switch4") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map(switch4)
        let actual = map(xs, switch4)
        return try? #require(actual == expected)
      }
}

private func prop_switch5<T: Arbitrary & Equatable & FixedWidthInteger & ExpressibleByIntegerLiteral & AdditiveArithmetic>(_: T.Type) {
    func switch5(_ x: T) -> T {
        switch x {
            case 0: 1
            case 1: 3
            case 4: 7
            case 7: 255
            case 214: 11
            default: x
        }
    }
    property(String(describing: T.self) + ".switch5") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map(switch5)
        let actual = map(xs, switch5)
        return try? #require(actual == expected)
      }
}

private func prop_switch6<T: Arbitrary & Equatable & FixedWidthInteger & ExpressibleByIntegerLiteral>(_: T.Type) {
    func switch6(_ x: T) -> T {
        // introduce range-based case in the mix
        switch x {
            case 8 ... 100: 99
            default: x
        }
    }
    property(String(describing: T.self) + ".switch5") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map(switch6)
        let actual = map(xs, switch6)
        return try? #require(actual == expected)
      }
}
