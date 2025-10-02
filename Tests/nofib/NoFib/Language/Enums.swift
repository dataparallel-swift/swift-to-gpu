import Foundation
import SwiftCheck
import SwiftToPTX
import Testing

@Suite("Enums") struct Enums {
    @Suite("EnumsWithoutPayloads") struct EnumsWithoutPayloadsTests {
        @Test func test_enum_switch1() { prop_enum_switch1() }
        @Test func test_enum_switch2() { prop_enum_switch2() }
        @Test func test_enum_switch3() { prop_enum_switch3() }
        @Test func test_enum_switch4() { prop_enum_switch4() }
    }

    // Enums With Payloads
    // The types of the payloads are parameterized. The size and alignment of the enum will depend
    // on the sizes and alignment requirements of the payload types and how they are organized therein.
    // The purpose of the "EnumsWithPayloads" suite is to explore whether the GPU codegen is able to handle
    // varying layouts requirements.

    @Suite("EnumsWithPayloads") struct EnumsWithPayloadsTests {
        @Suite("Int8") struct Int8Tests {
            @Test("Int8.enum_switch_payload1") func test_enum_switch_payload1() { prop_enum_switch_payload1(Int8.self) }
        }

        @Suite("Int32") struct Int32Tests {
            @Test("Int32.enum_switch_payload1") func test_enum_switch_payload1() { prop_enum_switch_payload1(Int32.self) }
        }

        @Suite("Int8Int32") struct Int8Int32Tests {
            @Test("Int8Int32.enum_switch_payload2") func test_enum_switch_payload2() { prop_enum_switch_payload2(Int8.self, Int32.self) }
            @Test("Int8Int32.enum_switch_payload3") func test_enum_switch_payload3() { prop_enum_switch_payload3(Int8.self, Int32.self) }
            @Test("Int8Int32.enum_switch_payload4") func test_enum_switch_payload4() { prop_enum_switch_payload4(Int8.self, Int32.self) }
        }

        @Suite("Int8Int64") struct Int8Int64Tests {
            @Test("Int8Int64.enum_switch_payload2") func test_enum_switch_payload2() { prop_enum_switch_payload2(Int8.self, Int64.self) }
            @Test("Int8Int64.enum_switch_payload3") func test_enum_switch_payload3() { prop_enum_switch_payload3(Int8.self, Int64.self) }
            @Test("Int8Int64.enum_switch_payload4") func test_enum_switch_payload4() { prop_enum_switch_payload4(Int8.self, Int64.self) }
        }

        @Suite("Int32Int64") struct Int32Int64Tests {
            @Test("Int32Int64.enum_switch_payload2") func test_enum_switch_payload2() { prop_enum_switch_payload2(Int32.self, Int64.self) }
            @Test("Int32Int64.enum_switch_payload3") func test_enum_switch_payload3() { prop_enum_switch_payload3(Int32.self, Int64.self) }
            @Test("Int32Int64.enum_switch_payload3") func test_enum_switch_payload4() { prop_enum_switch_payload4(Int32.self, Int64.self) }
        }
    }
}

// MARK: enums without payloads

enum E1: Arbitrary {
    case a

    public static var arbitrary: Gen<Self> {
        Bool.arbitrary.map { _ in Self.a }
    }
}

private func prop_enum_switch1() {
    func enum_switch1(_ e: E1) -> Int32 {
        switch e {
            case .a: 0
        }
    }
    property(String(describing: E1.self)+".enum_switch1") <-
      forAllNoShrink([E1].arbitrary) { (xs: [E1]) in
        let expected = xs.map(enum_switch1)
        let actual = map(xs, enum_switch1)
        return try? #require( expected == actual )
      }
}

enum E2: Arbitrary {
    case a
    case b

    public static var arbitrary: Gen<Self> {
        Bool.arbitrary.map { $0 ? Self.a : Self.b }
    }
}

private func prop_enum_switch2() {
    func enum_switch2(_ e: E2) -> Int32 {
        switch e {
            case .a: 0
            case .b: 1
        }
    }
    property(String(describing: E2.self)+".enum_switch2") <-
      forAllNoShrink([E2].arbitrary) { (xs: [E2]) in
        let expected = xs.map(enum_switch2)
        let actual = map(xs, enum_switch2)
        return try? #require( expected == actual )
      }
}

enum E3: Arbitrary, Equatable {
    case a
    case b
    case c

    public static var arbitrary: Gen<Self> {
        UInt8.arbitrary.map {
            switch $0 % 3 {
                case 0: Self.a
                case 1: Self.b
                default: Self.c
            }
        }
    }
}

private func prop_enum_switch3() {
    func enum_switch3(_ e: E3) -> Int32 {
        switch e {
            case .a: 0
            case .b: 1
            case .c: 2
        }
    }
    property(String(describing: E3.self)+".enum_switch3") <-
      forAllNoShrink([E3].arbitrary) { (xs: [E3]) in
        let expected = xs.map(enum_switch3)
        let actual = map(xs, enum_switch3)
        return try? #require( expected == actual )
      }
}

enum E4: Arbitrary {
    case a
    case b
    case c
    case d

    public static var arbitrary: Gen<Self> {
        UInt8.arbitrary.map {
            switch $0 % 4 {
                case 0: Self.a
                case 1: Self.b
                case 2: Self.c
                default: Self.d
            }
        }
    }
}

private func prop_enum_switch4() {
    func enum_switch4(_ e: E4) -> Int32 {
        switch e {
            case .a: 0
            case .b: 1
            case .c: 2
            case .d: 3
        }
    }
    property(String(describing: E4.self)+".enum_switch4") <-
      forAllNoShrink([E4].arbitrary) { (xs: [E4]) in
        let expected = xs.map(enum_switch4)
        let actual = map(xs, enum_switch4)
        return try? #require( expected == actual )
      }
}

// MARK: enums with primitive payloads

enum E1P<T: Arbitrary>: Arbitrary {
    case a(T)

    public static var arbitrary: Gen<Self> {
        T.arbitrary.map { Self.a($0) }
    }
}

private func prop_enum_switch_payload1<T: Arbitrary & Equatable>(_ proxy: T.Type) {
    func enum_switch_payload1(_ e: E1P<T>) -> T {
        switch e {
            case let .a(payload): payload
        }
    }
    property(String(describing: E1P<T>.self)+".enum_switch_payload1") <-
      forAllNoShrink([E1P<T>].arbitrary) { (xs: [E1P<T>]) in
        let expected = xs.map(enum_switch_payload1)
        let actual = map(xs, enum_switch_payload1)
        return try? #require( expected == actual )
      }
}

enum E2P<T1: Arbitrary & FixedWidthInteger, T2: Arbitrary & FixedWidthInteger>: Arbitrary {
    case a(T1)
    case b(T2)

    public static var arbitrary: Gen<Self> {
        Gen<E2P>.compose { c -> E2P in
            let select: Bool = c.generate()
            return select ? Self.a(c.generate()) : Self.b(c.generate())
        }
    }
}

private func prop_enum_switch_payload2<T1: Arbitrary & FixedWidthInteger, T2: Arbitrary & FixedWidthInteger>(
    _ proxy1: T1.Type, _ proxy2: T2.Type
) {
    func enum_switch_payload2(_ e: E2P<T1, T2>) -> Float64 {
        switch e {
            case let .a(v): Float64(v)
            case let .b(v): Float64(v)
        }
    }
    property(String(describing: E2P<T1, T2>.self)+".enum_switch_payload2") <-
      forAllNoShrink([E2P<T1, T2>].arbitrary) { (xs: [E2P<T1, T2>]) in
        let expected = xs.map(enum_switch_payload2)
        let actual = map(xs, enum_switch_payload2)
        return try? #require( expected == actual )
      }
}

enum E3P<T1: Arbitrary & FixedWidthInteger, T2: Arbitrary & FixedWidthInteger>: Arbitrary {
    case a(T1)
    case b(T2)
    case c(T1, T2)

    public static var arbitrary: Gen<Self> {
        Gen<E3P>.compose { c -> E3P in
            let select: UInt8 = c.generate()
            return switch select % 3 {
                case 0: Self.a(c.generate())
                case 1: Self.b(c.generate())
                default: Self.c(c.generate(), c.generate())
            }
        }
    }
}

private func prop_enum_switch_payload3<T1: Arbitrary & FixedWidthInteger, T2: Arbitrary & FixedWidthInteger>(
    _ proxy1: T1.Type, _ proxy2: T2.Type
) {
    func enum_switch_payload3(_ e: E3P<T1, T2>) -> Float64 {
        switch e {
            case let .a(v): Float64(v)
            case let .b(v): Float64(v)
            case let .c(v1, v2): Float64(v1) + Float64(v2)
        }
    }
    property(String(describing: E3P<T1, T2>.self)+".enum_switch_payload3") <-
      forAllNoShrink([E3P<T1, T2>].arbitrary) { (xs: [E3P<T1, T2>]) in
        let expected = xs.map(enum_switch_payload3)
        let actual = map(xs, enum_switch_payload3)
        return try? #require( expected == actual )
      }
}

enum E4P<T1: Arbitrary & FixedWidthInteger, T2: Arbitrary & FixedWidthInteger>: Arbitrary {
    case a(T1)
    case b(T2)
    case c(T1, T2)
    case d

    public static var arbitrary: Gen<Self> {
        Gen<E4P>.compose { c -> E4P in
            let select: UInt8 = c.generate()
            return switch select % 4 {
                case 0: Self.a(c.generate())
                case 1: Self.b(c.generate())
                case 2: Self.c(c.generate(), c.generate())
                default: Self.d
            }
        }
    }
}

private func prop_enum_switch_payload4<T1: Arbitrary & FixedWidthInteger, T2: Arbitrary & FixedWidthInteger>(
    _ proxy1: T1.Type, _ proxy2: T2.Type
) {
    func enum_switch_payload4(_ e: E4P<T1, T2>) -> Float64 {
        switch e {
            case let .a(v): Double(v)
            case let .b(v): Double(v)
            case let .c(v1, v2): Double(v1) + Double(v2)
            case .d: 0
        }
    }
    property(String(describing: E4P<T1, T2>.self)+".enum_switch_payload4") <-
      forAllNoShrink([E4P<T1, T2>].arbitrary) { (xs: [E4P<T1, T2>]) in
        let expected = xs.map(enum_switch_payload4)
        let actual = map(xs, enum_switch_payload4)
        return try? #require( expected == actual )
      }
}
