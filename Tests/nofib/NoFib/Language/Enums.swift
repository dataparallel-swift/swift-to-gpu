import Foundation
import SwiftCheck
import SwiftToPTX
import Testing

@Suite("Enums") struct Enums {
    @Suite("Plain Enum Tests") struct PlainEnumTests {
        @Test func test_enum_switch1() { prop_enum_switch1() }
        @Test func test_enum_switch2() { prop_enum_switch2() }
        @Test func test_enum_switch3() { prop_enum_switch3() }
        @Test func test_enum_switch4() { prop_enum_switch4() }
    }

    @Suite("Payload Enum Tests") struct PayloadEnumTests {
        @Suite("Int32") struct Int32Tests {
            @Test func test_enum_switch_payload1() { prop_enum_switch_payload1(Int32.self) }
        }
        @Suite("Int32,Float64") struct Int32Float64Tests {
            @Test func test_enum_switch_payload2() { prop_enum_switch_payload2(Int32.self, Float64.self) }
            @Test func test_enum_switch_payload3() { prop_enum_switch_payload3(Int32.self, Float64.self) }
            @Test func test_enum_switch_payload4() { prop_enum_switch_payload4(Int32.self, Float64.self) }
        }
    }
}

// MARK: enums without payloads
enum E1: Arbitrary {
    case a

    public static var arbitrary: Gen<Self> {
        return Bool.arbitrary.map { _ in Self.a }
    }
}
private func prop_enum_switch1() {
    func enum_switch1(_ e: E1) -> Int32 {
        return switch e {
        case .a: 0
        }
    }
    property(String(describing: E1.self)+".enum_switch1") <-
      forAllNoShrink([E1].arbitrary) { (xs: [E1]) in
        let expected = xs.map(enum_switch1)
        let actual = map(xs, enum_switch1)
        return try? #require(expected == actual)
      }
}

enum E2: Arbitrary {
    case a
    case b

    public static var arbitrary: Gen<Self> {
        return Bool.arbitrary.map { $0 ? Self.a : Self.b }
    }
}
private func prop_enum_switch2() {
    func enum_switch2(_ e: E2) -> Int32 {
        return switch e {
        case .a: 0
        case .b: 1
        }
    }
    property(String(describing: E2.self)+".enum_switch2") <-
      forAllNoShrink([E2].arbitrary) { (xs: [E2]) in
        let expected = xs.map(enum_switch2)
        let actual = map(xs, enum_switch2)
        return try? #require(expected == actual)
      }
}

enum E3: Arbitrary, Equatable {
    case a
    case b
    case c

    public static var arbitrary: Gen<Self> {
        return UInt8.arbitrary.map {
            return switch $0 % 3 {
            case 0: Self.a
            case 1: Self.b
            default: Self.c
            }
        }
    }
}
private func prop_enum_switch3() {
    func enum_switch3(_ e: E3) -> Int32 {
        return switch e {
        case .a: 0
        case .b: 1
        case .c: 2
        }
    }
    property(String(describing: E3.self)+".enum_switch3") <-
      forAllNoShrink([E3].arbitrary) { (xs: [E3]) in
        let expected = xs.map(enum_switch3)
        let actual = map(xs, enum_switch3)
        return try? #require(expected == actual)
      }
}

enum E4: Arbitrary {
    case a
    case b
    case c
    case d

    public static var arbitrary: Gen<Self> {
        return UInt8.arbitrary.map {
            return switch $0 % 4 {
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
        return switch e {
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
        return try? #require(expected == actual)
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
        return switch e {
        case .a(let payload): payload
        }
    }
    property(String(describing: E1P<T>.self)+".enum_switch_payload1") <-
      forAllNoShrink([E1P<T>].arbitrary) { (xs: [E1P<T>]) in
        let expected = xs.map(enum_switch_payload1)
        let actual = map(xs, enum_switch_payload1)
        return try? #require(expected == actual)
      }
}

enum E2P<I: Arbitrary & BinaryInteger, F: Arbitrary & FloatingPoint>: Arbitrary {
    case a(I)
    case b(F)

    public static var arbitrary: Gen<Self> {
        return Gen<E2P>.compose { (c) -> E2P in
            let select: Bool = c.generate()
            return select ? Self.a(c.generate()) : Self.b(c.generate())
        }
    }
}
private func prop_enum_switch_payload2<I: Arbitrary & BinaryInteger, F: Arbitrary & FloatingPoint>(
    _ iProxy: I.Type, _ fProxy: F.Type
) {
    func enum_switch_payload2(_ e: E2P<I, F>) -> F {
        return switch e {
        case .a(let i): F(i)
        case .b(let f): f
        }
    }
    property(String(describing: E2P<I,F>.self)+".enum_switch_payload2") <-
      forAllNoShrink([E2P<I, F>].arbitrary) { (xs: [E2P<I, F>]) in
        let expected = xs.map(enum_switch_payload2)
        let actual = map(xs, enum_switch_payload2)
        return try? #require(expected == actual)
      }
}

enum E3P<I: Arbitrary & BinaryInteger, F: Arbitrary & FloatingPoint>: Arbitrary {
    case a(I)
    case b(F)
    case c(I, F)

    public static var arbitrary: Gen<Self> {
        return Gen<E3P>.compose { (c) -> E3P in
            let select: UInt8 = c.generate()
            return switch select % 3 {
            case 0: Self.a(c.generate())
            case 1: Self.b(c.generate())
            default: Self.c(c.generate(), c.generate())
            }
        }
    }
}

private func prop_enum_switch_payload3<I: Arbitrary & BinaryInteger, F: Arbitrary & FloatingPoint & AdditiveArithmetic>(
    _ iProxy: I.Type, _ fProxy: F.Type
) {
    func enum_switch_payload3(_ e: E3P<I, F>) -> F {
        return switch e {
        case .a(let i): F(i)
        case .b(let f): f
        case .c(let i, let f): F(i) + f
        }
    }
    property(String(describing: E3P<I,F>.self)+".enum_switch_payload3") <-
      forAllNoShrink([E3P<I,F>].arbitrary) { (xs: [E3P<I,F>]) in
        let expected = xs.map(enum_switch_payload3)
        let actual = map(xs, enum_switch_payload3)
        return try? #require( expected == actual )
      }
}

enum E4P<I: Arbitrary & BinaryInteger, F: Arbitrary & FloatingPoint>: Arbitrary {
    case a(I)
    case b(F)
    case c(I, F)
    case d

    public static var arbitrary: Gen<Self> {
        return Gen<E4P>.compose { (c) -> E4P in
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

private func prop_enum_switch_payload4<I: Arbitrary & BinaryInteger, F: Arbitrary & FloatingPoint & AdditiveArithmetic>(
    _ iProxy: I.Type, _ fProxy: F.Type
) {
    func enum_switch_payload4(_ e: E4P<I, F>) -> F {
        return switch e {
        case .a(let i): F(i)
        case .b(let f): f
        case .c(let i, let f): F(i) + f
        case .d: F(0)
        }
    }
    property(String(describing: E4P<I, F>.self)+".enum_switch_payload4") <-
      forAllNoShrink([E4P<I,F>].arbitrary) { (xs: [E4P<I,F>]) in
        let expected = xs.map(enum_switch_payload4)
        let actual = map(xs, enum_switch_payload4)
        return try? #require( expected == actual )
      }
}
