// Copyright (c) 2025 PassiveLogic, Inc.

import Foundation
import SwiftCheck
import SwiftToPTX
import Testing

// swiftformat:disable blankLinesBetweenScopes trailingCommas wrap wrapArguments

@Suite("Enums") struct Enums {
    @Suite("EnumsWithoutPayloads") struct EnumsWithoutPayloadsTests {
        enum E1: Arbitrary {
            case opt1

            static var arbitrary: Gen<Self> {
                Bool.arbitrary.map { _ in Self.opt1 }
            }
        }

        @Test func test_enum_switch1() {
            func enum_switch1(_ value: E1) -> Int32 {
                switch value {
                    case .opt1: 0
                }
            }
            property(String(describing: E1.self) + ".enum_switch1") <-
              forAllNoShrink([E1].arbitrary) { (xs: [E1]) in
                let expected = xs.map(enum_switch1)
                let actual = map(xs, enum_switch1)
                return try? #require(expected == actual)
              }
        }

        enum E2: Arbitrary {
            case opt1
            case opt2

            static var arbitrary: Gen<Self> {
                Bool.arbitrary.map { $0 ? Self.opt1 : Self.opt2 }
            }
        }

        @Test func test_enum_switch2() {
            func enum_switch2(_ value: E2) -> Int32 {
                switch value {
                    case .opt1: 0
                    case .opt2: 1
                }
            }
            property(String(describing: E2.self) + ".enum_switch2") <-
              forAllNoShrink([E2].arbitrary) { (xs: [E2]) in
                let expected = xs.map(enum_switch2)
                let actual = map(xs, enum_switch2)
                return try? #require(expected == actual)
              }
        }

        enum E3: Arbitrary, Equatable {
            case opt1
            case opt2
            case opt3

            static var arbitrary: Gen<Self> {
                UInt8.arbitrary.map {
                    switch $0 % 3 {
                        case 0: Self.opt1
                        case 1: Self.opt2
                        default: Self.opt3
                    }
                }
            }
        }

        @Test func test_enum_switch3() {
            func enum_switch3(_ value: E3) -> Int32 {
                switch value {
                    case .opt1: 0
                    case .opt2: 1
                    case .opt3: 2
                }
            }
            property(String(describing: E3.self) + ".enum_switch3") <-
              forAllNoShrink([E3].arbitrary) { (xs: [E3]) in
                let expected = xs.map(enum_switch3)
                let actual = map(xs, enum_switch3)
                return try? #require(expected == actual)
              }
        }

        enum E4: Arbitrary {
            case opt1
            case opt2
            case opt3
            case opt4

            static var arbitrary: Gen<Self> {
                UInt8.arbitrary.map {
                    switch $0 % 4 {
                        case 0: Self.opt1
                        case 1: Self.opt2
                        case 2: Self.opt3
                        default: Self.opt4
                    }
                }
            }
        }

        @Test func test_enum_switch4() {
            func enum_switch4(_ value: E4) -> Int32 {
                switch value {
                    case .opt1: 0
                    case .opt2: 1
                    case .opt3: 2
                    case .opt4: 3
                }
            }
            property(String(describing: E4.self) + ".enum_switch4") <-
              forAllNoShrink([E4].arbitrary) { (xs: [E4]) in
                let expected = xs.map(enum_switch4)
                let actual = map(xs, enum_switch4)
                return try? #require(expected == actual)
              }
        }
    }

    // Enums With Payloads
    // The types of the payloads are parameterized. The size and alignment of the enum will depend
    // on the sizes and alignment requirements of the payload types and how they are organized therein.
    // The purpose of the "EnumsWithPayloads" suite is to explore whether the GPU codegen is able to handle
    // varying layouts requirements.

    @Suite("EnumsWithPayloads") struct EnumsWithPayloadsTests {
        @Test("enum_switch_payload1.Int") func test_enum_switch_payload1_1() { prop_enum_switch_payload1(Int.self) }
        @Test("enum_switch_payload1.Int8") func test_enum_switch_payload1_2() { prop_enum_switch_payload1(Int8.self) }
        @Test("enum_switch_payload1.Int16") func test_enum_switch_payload1_3() { prop_enum_switch_payload1(Int16.self) }
        @Test("enum_switch_payload1.Int32") func test_enum_switch_payload1_4() { prop_enum_switch_payload1(Int32.self) }
        @Test("enum_switch_payload1.Int64") func test_enum_switch_payload1_5() { prop_enum_switch_payload1(Int64.self) }
        @Test("enum_switch_payload1.UInt") func test_enum_switch_payload1_6() { prop_enum_switch_payload1(UInt.self) }
        @Test("enum_switch_payload1.UInt8") func test_enum_switch_payload1_7() { prop_enum_switch_payload1(UInt8.self) }
        @Test("enum_switch_payload1.UInt16") func test_enum_switch_payload1_8() { prop_enum_switch_payload1(UInt16.self) }
        @Test("enum_switch_payload1.UInt32") func test_enum_switch_payload1_9() { prop_enum_switch_payload1(UInt32.self) }
        @Test("enum_switch_payload1.UInt64") func test_enum_switch_payload1_10() { prop_enum_switch_payload1(UInt64.self) }

        // T1 = Int8
        @Test("enum_switch_payload2.Int8,Int") func test_enum_switch_payload2_i8_1() { prop_enum_switch_payload2(Int8.self, Int.self) }
        @Test("enum_switch_payload2.Int8,Int8") func test_enum_switch_payload2_i8_2() { prop_enum_switch_payload2(Int8.self, Int8.self) }
        @Test("enum_switch_payload2.Int8,Int16") func test_enum_switch_payload2_i8_3() { prop_enum_switch_payload2(Int8.self, Int16.self) }
        @Test("enum_switch_payload2.Int8,Int32") func test_enum_switch_payload2_i8_4() { prop_enum_switch_payload2(Int8.self, Int32.self) }
        @Test("enum_switch_payload2.Int8,Int64") func test_enum_switch_payload2_i8_5() { prop_enum_switch_payload2(Int8.self, Int64.self) }
        @Test("enum_switch_payload2.Int8,UInt") func test_enum_switch_payload2_i8_6() { prop_enum_switch_payload2(Int8.self, UInt.self) }
        @Test("enum_switch_payload2.Int8,UInt8") func test_enum_switch_payload2_i8_7() { prop_enum_switch_payload2(Int8.self, UInt8.self) }
        @Test("enum_switch_payload2.Int8,UInt16") func test_enum_switch_payload2_i8_8() { prop_enum_switch_payload2(Int8.self, UInt16.self) }
        @Test("enum_switch_payload2.Int8,UInt32") func test_enum_switch_payload2_i8_9() { prop_enum_switch_payload2(Int8.self, UInt32.self) }
        @Test("enum_switch_payload2.Int8,UInt64") func test_enum_switch_payload2_i8_10() { prop_enum_switch_payload2(Int8.self, UInt64.self) }
        // T1 = Int32
        @Test("enum_switch_payload2.Int32,Int") func test_enum_switch_payload2_i32_1() { prop_enum_switch_payload2(Int8.self, Int.self) }
        @Test("enum_switch_payload2.Int32,Int8") func test_enum_switch_payload2_i32_2() { prop_enum_switch_payload2(Int8.self, Int8.self) }
        @Test("enum_switch_payload2.Int32,Int16") func test_enum_switch_payload2_i32_3() { prop_enum_switch_payload2(Int8.self, Int16.self) }
        @Test("enum_switch_payload2.Int32,Int32") func test_enum_switch_payload2_i32_4() { prop_enum_switch_payload2(Int8.self, Int32.self) }
        @Test("enum_switch_payload2.Int32,Int64") func test_enum_switch_payload2_i32_5() { prop_enum_switch_payload2(Int8.self, Int64.self) }
        @Test("enum_switch_payload2.Int32,UInt") func test_enum_switch_payload2_i32_6() { prop_enum_switch_payload2(Int8.self, UInt.self) }
        @Test("enum_switch_payload2.Int32,UInt8") func test_enum_switch_payload2_i32_7() { prop_enum_switch_payload2(Int8.self, UInt8.self) }
        @Test("enum_switch_payload2.Int32,UInt16") func test_enum_switch_payload2_i32_8() { prop_enum_switch_payload2(Int8.self, UInt16.self) }
        @Test("enum_switch_payload2.Int32,UInt32") func test_enum_switch_payload2_i32_9() { prop_enum_switch_payload2(Int8.self, UInt32.self) }
        @Test("enum_switch_payload2.Int32,UInt64") func test_enum_switch_payload2_i32_10() { prop_enum_switch_payload2(Int8.self, UInt64.self) }

        // T1 = Int8
        @Test("enum_switch_payload3.Int8,Int") func test_enum_switch_payload3_i8_1() { prop_enum_switch_payload3(Int8.self, Int.self) }
        @Test("enum_switch_payload3.Int8,Int8") func test_enum_switch_payload3_i8_2() { prop_enum_switch_payload3(Int8.self, Int8.self) }
        @Test("enum_switch_payload3.Int8,Int16") func test_enum_switch_payload3_i8_3() { prop_enum_switch_payload3(Int8.self, Int16.self) }
        @Test("enum_switch_payload3.Int8,Int32") func test_enum_switch_payload3_i8_4() { prop_enum_switch_payload3(Int8.self, Int32.self) }
        @Test("enum_switch_payload3.Int8,Int64") func test_enum_switch_payload3_i8_5() { prop_enum_switch_payload3(Int8.self, Int64.self) }
        @Test("enum_switch_payload3.Int8,UInt") func test_enum_switch_payload3_i8_6() { prop_enum_switch_payload3(Int8.self, UInt.self) }
        @Test("enum_switch_payload3.Int8,UInt8") func test_enum_switch_payload3_i8_7() { prop_enum_switch_payload3(Int8.self, UInt8.self) }
        @Test("enum_switch_payload3.Int8,UInt16") func test_enum_switch_payload3_i8_8() { prop_enum_switch_payload3(Int8.self, UInt16.self) }
        @Test("enum_switch_payload3.Int8,UInt32") func test_enum_switch_payload3_i8_9() { prop_enum_switch_payload3(Int8.self, UInt32.self) }
        @Test("enum_switch_payload3.Int8,UInt64") func test_enum_switch_payload3_i8_10() { prop_enum_switch_payload3(Int8.self, UInt64.self) }
        // T1 = Int32
        @Test("enum_switch_payload3.Int32,Int") func test_enum_switch_payload3_i32_1() { prop_enum_switch_payload3(Int8.self, Int.self) }
        @Test("enum_switch_payload3.Int32,Int8") func test_enum_switch_payload3_i32_2() { prop_enum_switch_payload3(Int8.self, Int8.self) }
        @Test("enum_switch_payload3.Int32,Int16") func test_enum_switch_payload3_i32_3() { prop_enum_switch_payload3(Int8.self, Int16.self) }
        @Test("enum_switch_payload3.Int32,Int32") func test_enum_switch_payload3_i32_4() { prop_enum_switch_payload3(Int8.self, Int32.self) }
        @Test("enum_switch_payload3.Int32,Int64") func test_enum_switch_payload3_i32_5() { prop_enum_switch_payload3(Int8.self, Int64.self) }
        @Test("enum_switch_payload3.Int32,UInt") func test_enum_switch_payload3_i32_6() { prop_enum_switch_payload3(Int8.self, UInt.self) }
        @Test("enum_switch_payload3.Int32,UInt8") func test_enum_switch_payload3_i32_7() { prop_enum_switch_payload3(Int8.self, UInt8.self) }
        @Test("enum_switch_payload3.Int32,UInt16") func test_enum_switch_payload3_i32_8() { prop_enum_switch_payload3(Int8.self, UInt16.self) }
        @Test("enum_switch_payload3.Int32,UInt32") func test_enum_switch_payload3_i32_9() { prop_enum_switch_payload3(Int8.self, UInt32.self) }
        @Test("enum_switch_payload3.Int32,UInt64") func test_enum_switch_payload3_i32_10() { prop_enum_switch_payload3(Int8.self, UInt64.self) }

        // T1 = Int8
        @Test("enum_switch_payload4.Int8,Int") func test_enum_switch_payload4_i8_1() { prop_enum_switch_payload4(Int8.self, Int.self) }
        @Test("enum_switch_payload4.Int8,Int8") func test_enum_switch_payload4_i8_2() { prop_enum_switch_payload4(Int8.self, Int8.self) }
        @Test("enum_switch_payload4.Int8,Int16") func test_enum_switch_payload4_i8_3() { prop_enum_switch_payload4(Int8.self, Int16.self) }
        @Test("enum_switch_payload4.Int8,Int32") func test_enum_switch_payload4_i8_4() { prop_enum_switch_payload4(Int8.self, Int32.self) }
        @Test("enum_switch_payload4.Int8,Int64") func test_enum_switch_payload4_i8_5() { prop_enum_switch_payload4(Int8.self, Int64.self) }
        @Test("enum_switch_payload4.Int8,UInt") func test_enum_switch_payload4_i8_6() { prop_enum_switch_payload4(Int8.self, UInt.self) }
        @Test("enum_switch_payload4.Int8,UInt8") func test_enum_switch_payload4_i8_7() { prop_enum_switch_payload4(Int8.self, UInt8.self) }
        @Test("enum_switch_payload4.Int8,UInt16") func test_enum_switch_payload4_i8_8() { prop_enum_switch_payload4(Int8.self, UInt16.self) }
        @Test("enum_switch_payload4.Int8,UInt32") func test_enum_switch_payload4_i8_9() { prop_enum_switch_payload4(Int8.self, UInt32.self) }
        @Test("enum_switch_payload4.Int8,UInt64") func test_enum_switch_payload4_i8_10() { prop_enum_switch_payload4(Int8.self, UInt64.self) }
        // T1 = Int32
        @Test("enum_switch_payload4.Int32,Int") func test_enum_switch_payload4_i32_1() { prop_enum_switch_payload4(Int8.self, Int.self) }
        @Test("enum_switch_payload4.Int32,Int8") func test_enum_switch_payload4_i32_2() { prop_enum_switch_payload4(Int8.self, Int8.self) }
        @Test("enum_switch_payload4.Int32,Int16") func test_enum_switch_payload4_i32_3() { prop_enum_switch_payload4(Int8.self, Int16.self) }
        @Test("enum_switch_payload4.Int32,Int32") func test_enum_switch_payload4_i32_4() { prop_enum_switch_payload4(Int8.self, Int32.self) }
        @Test("enum_switch_payload4.Int32,Int64") func test_enum_switch_payload4_i32_5() { prop_enum_switch_payload4(Int8.self, Int64.self) }
        @Test("enum_switch_payload4.Int32,UInt") func test_enum_switch_payload4_i32_6() { prop_enum_switch_payload4(Int8.self, UInt.self) }
        @Test("enum_switch_payload4.Int32,UInt8") func test_enum_switch_payload4_i32_7() { prop_enum_switch_payload4(Int8.self, UInt8.self) }
        @Test("enum_switch_payload4.Int32,UInt16") func test_enum_switch_payload4_i32_8() { prop_enum_switch_payload4(Int8.self, UInt16.self) }
        @Test("enum_switch_payload4.Int32,UInt32") func test_enum_switch_payload4_i32_9() { prop_enum_switch_payload4(Int8.self, UInt32.self) }
        @Test("enum_switch_payload4.Int32,UInt64") func test_enum_switch_payload4_i32_10() { prop_enum_switch_payload4(Int8.self, UInt64.self) }
    }
}

// MARK: enums with primitive payloads

enum E1P<T: Arbitrary>: Arbitrary {
    case opt1(T)

    static var arbitrary: Gen<Self> {
        T.arbitrary.map { Self.opt1($0) }
    }
}

private func prop_enum_switch_payload1<T: Arbitrary & Equatable>(_: T.Type) {
    func enum_switch_payload1(_ value: E1P<T>) -> T {
        switch value {
            case let .opt1(payload): payload
        }
    }
    property(String(describing: E1P<T>.self) + ".enum_switch_payload1") <-
      forAllNoShrink([E1P<T>].arbitrary) { (xs: [E1P<T>]) in
        let expected = xs.map(enum_switch_payload1)
        let actual = map(xs, enum_switch_payload1)
        return try? #require(expected == actual)
      }
}

enum E2P<T1: Arbitrary & FixedWidthInteger, T2: Arbitrary & FixedWidthInteger>: Arbitrary {
    case opt1(T1)
    case opt2(T2)

    static var arbitrary: Gen<Self> {
        Gen<E2P>.compose { composer -> E2P in
            let select: Bool = composer.generate()
            return select ? Self.opt1(composer.generate()) : Self.opt2(composer.generate())
        }
    }
}

// swiftformat:disable:next wrapArguments
private func prop_enum_switch_payload2<T1: Arbitrary & FixedWidthInteger, T2: Arbitrary & FixedWidthInteger>(_: T1.Type, _: T2.Type) {
    func enum_switch_payload2(_ value: E2P<T1, T2>) -> Float64 {
        switch value {
            case let .opt1(payload): Float64(payload)
            case let .opt2(payload): Float64(payload)
        }
    }
    property(String(describing: E2P<T1, T2>.self) + ".enum_switch_payload2") <-
      forAllNoShrink([E2P<T1, T2>].arbitrary) { (xs: [E2P<T1, T2>]) in
        let expected = xs.map(enum_switch_payload2)
        let actual = map(xs, enum_switch_payload2)
        return try? #require(expected == actual)
      }
}

enum E3P<T1: Arbitrary & FixedWidthInteger, T2: Arbitrary & FixedWidthInteger>: Arbitrary {
    case opt1(T1)
    case opt2(T2)
    case opt3(T1, T2)

    static var arbitrary: Gen<Self> {
        Gen<E3P>.compose { composer -> E3P in
            let select: UInt8 = composer.generate()
            return switch select % 3 {
                case 0: Self.opt1(composer.generate())
                case 1: Self.opt2(composer.generate())
                default: Self.opt3(composer.generate(), composer.generate())
            }
        }
    }
}

// swiftformat:disable:next wrapArguments
private func prop_enum_switch_payload3<T1: Arbitrary & FixedWidthInteger, T2: Arbitrary & FixedWidthInteger>(_: T1.Type, _: T2.Type) {
    func enum_switch_payload3(_ value: E3P<T1, T2>) -> Float64 {
        switch value {
            case let .opt1(payload): Float64(payload)
            case let .opt2(payload): Float64(payload)
            case let .opt3(payload1, payload2): Float64(payload1) + Float64(payload2)
        }
    }
    property(String(describing: E3P<T1, T2>.self) + ".enum_switch_payload3") <-
      forAllNoShrink([E3P<T1, T2>].arbitrary) { (xs: [E3P<T1, T2>]) in
        let expected = xs.map(enum_switch_payload3)
        let actual = map(xs, enum_switch_payload3)
        return try? #require(expected == actual)
      }
}

enum E4P<T1: Arbitrary & FixedWidthInteger, T2: Arbitrary & FixedWidthInteger>: Arbitrary {
    case opt1(T1)
    case opt2(T2)
    case opt3(T1, T2)
    case opt4

    static var arbitrary: Gen<Self> {
        Gen<E4P>.compose { composer -> E4P in
            let select: UInt8 = composer.generate()
            return switch select % 4 {
                case 0: Self.opt1(composer.generate())
                case 1: Self.opt2(composer.generate())
                case 2: Self.opt3(composer.generate(), composer.generate())
                default: Self.opt4
            }
        }
    }
}

// swiftformat:disable:next wrapArguments
private func prop_enum_switch_payload4<T1: Arbitrary & FixedWidthInteger, T2: Arbitrary & FixedWidthInteger>(_: T1.Type, _: T2.Type) {
    func enum_switch_payload4(_ value: E4P<T1, T2>) -> Float64 {
        switch value {
            case let .opt1(payload): Double(payload)
            case let .opt2(payload): Double(payload)
            case let .opt3(payload1, payload2): Double(payload1) + Double(payload2)
            case .opt4: 0
        }
    }
    property(String(describing: E4P<T1, T2>.self) + ".enum_switch_payload4") <-
      forAllNoShrink([E4P<T1, T2>].arbitrary) { (xs: [E4P<T1, T2>]) in
        let expected = xs.map(enum_switch_payload4)
        let actual = map(xs, enum_switch_payload4)
        return try? #require(expected == actual)
      }
}
