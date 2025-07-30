import Foundation
import SwiftCheck
import SwiftToPTX
import Testing

@Suite("Enums") struct EnumsSuite {
    @Suite struct PlainEnumTests {
        @Test func test_switch1() { prop_switch1() }
        @Test func test_switch2() { prop_switch2() }
        @Test func test_switch3() { prop_switch3() }
        @Test func test_switch4() { prop_switch4() }
    }

    @Suite struct PayloadEnumTests {
        @Test func test_switch_payload1() { prop_switch_payload1(Int32.self) }
        @Test func test_switch_payload2() { prop_switch_payload2(Int32.self, Float64.self) }
        @Test func test_switch_payload3() { prop_switch_payload3(Int32.self, Float64.self) }
        @Test func test_switch_payload4() { prop_switch_payload4(Int32.self, Float64.self) }
    }
}

// MARK: enums without payloads
enum E1: Arbitrary {
    case a

    public static var arbitrary: Gen<Self> {
        return Bool.arbitrary.map { _ in Self.a }
    }
}
private func prop_switch1() {
    func fn(_ e: E1) -> Int32 {
        return switch e {
        case .a: 0
        }
    }
    property("switch1") <-
      forAllNoShrink([E1].arbitrary) { (xs: [E1]) in
        let expected = xs.map(fn)
        let actual = map(xs, fn)
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
private func prop_switch2() {
    func fn(_ e: E2) -> Int32 {
        return switch e {
        case .a: 0
        case .b: 1
        }
    }
    property("switch2") <-
      forAllNoShrink([E2].arbitrary) { (xs: [E2]) in
        let expected = xs.map(fn)
        let actual = map(xs, fn)
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
private func prop_switch3() {
    func fn(_ e: E3) -> Int32 {
        return switch e {
        case .a: 0
        case .b: 1
        case .c: 2
        }
    }
    property("switch3") <-
      forAllNoShrink([E3].arbitrary) { (xs: [E3]) in
        let expected = xs.map(fn)
        let actual = map(xs, fn)
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
private func prop_switch4() {
    func fn(_ e: E4) -> Int32 {
        return switch e {
        case .a: 0
        case .b: 1
        case .c: 2
        case .d: 3
        }
    }
    property("switch4") <-
      forAllNoShrink([E4].arbitrary) { (xs: [E4]) in
        let expected = xs.map(fn)
        let actual = map(xs, fn)
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
private func prop_switch_payload1<T: Arbitrary & Equatable>(_ proxy: T.Type) {
    func fn(_ e: E1P<T>) -> T {
        return switch e {
        case .a(let payload): payload
        }
    }
    property("switch_payload1") <-
      forAllNoShrink([E1P<T>].arbitrary) { (xs: [E1P<T>]) in
        let expected = xs.map(fn)
        let actual = map(xs, fn)
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
private func prop_switch_payload2<I: Arbitrary & BinaryInteger, F: Arbitrary & FloatingPoint>(
    _ iProxy: I.Type, _ fProxy: F.Type
) {
    func fn(_ e: E2P<I, F>) -> F {
        return switch e {
        case .a(let i): F(i)
        case .b(let f): f
        }
    }
    property("switch_payload2") <-
      forAllNoShrink([E2P<I, F>].arbitrary) { (xs: [E2P<I, F>]) in
        let expected = xs.map(fn)
        let actual = map(xs, fn)
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

private func prop_switch_payload3<I: Arbitrary & BinaryInteger, F: Arbitrary & FloatingPoint & AdditiveArithmetic>(
    _ iProxy: I.Type, _ fProxy: F.Type
) {
    func fn(_ e: E3P<I, F>) -> F {
        return switch e {
        case .a(let i): F(i)
        case .b(let f): f
        case .c(let i, let f): F(i) + f
        }
    }
    property("switch_payload3") <-
      forAllNoShrink([E3P<I,F>].arbitrary) { (xs: [E3P<I,F>]) in
        let expected = xs.map(fn)
        let actual = map(xs, fn)
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

private func prop_switch_payload4<I: Arbitrary & BinaryInteger, F: Arbitrary & FloatingPoint & AdditiveArithmetic>(
    _ iProxy: I.Type, _ fProxy: F.Type
) {
    func fn(_ e: E4P<I, F>) -> F {
        return switch e {
        case .a(let i): F(i)
        case .b(let f): f
        case .c(let i, let f): F(i) + f
        case .d: F(0)
        }
    }
    property("switch_payload4") <-
      forAllNoShrink([E4P<I,F>].arbitrary) { (xs: [E4P<I,F>]) in
        let expected = xs.map(fn)
        let actual = map(xs, fn)
        return try? #require( expected == actual )
      }
}
