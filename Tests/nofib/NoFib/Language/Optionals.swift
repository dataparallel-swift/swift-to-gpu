import SwiftCheck
import SwiftToPTX
import Testing

@Suite("Optionals") struct Optionals {
    @Suite("Int") struct IntTests {
        @Test func test_if_let() { prop_if_let(Int.self) }
        @Test func test_optional_return_type() { prop_optional_return_type(Int.self) }
        @Test func test_force_unwrap() { prop_force_unwrap(Int.self) }
    }

    @Suite("Int8") struct Int8Tests {
        @Test func test_if_let() { prop_if_let(Int8.self) }
        @Test func test_optional_return_type() { prop_optional_return_type(Int8.self) }
        @Test func test_force_unwrap() { prop_force_unwrap(Int8.self) }
    }

    @Suite("Int16") struct Int16Tests {
        @Test func test_if_let() { prop_if_let(Int16.self) }
        @Test func test_optional_return_type() { prop_optional_return_type(Int16.self) }
        @Test func test_force_unwrap() { prop_force_unwrap(Int16.self) }
    }

    @Suite("Int32") struct Int32Tests {
        @Test func test_if_let() { prop_if_let(Int32.self) }
        @Test func test_optional_return_type() { prop_optional_return_type(Int32.self) }
        @Test func test_force_unwrap() { prop_force_unwrap(Int32.self) }
    }

    @Suite("Int64") struct Int64Tests {
        @Test func test_if_let() { prop_if_let(Int64.self) }
        @Test func test_optional_return_type() { prop_optional_return_type(Int64.self) }
        @Test func test_force_unwrap() { prop_force_unwrap(Int64.self) }
    }

    @Suite("UInt") struct UIntTests {
        @Test func test_if_let() { prop_if_let(UInt.self) }
        @Test func test_optional_return_type() { prop_optional_return_type(UInt.self) }
        @Test func test_force_unwrap() { prop_force_unwrap(UInt.self) }
    }

    @Suite("UInt8") struct UInt8Tests {
        @Test func test_if_let() { prop_if_let(UInt8.self) }
        @Test func test_optional_return_type() { prop_optional_return_type(UInt8.self) }
        @Test func test_force_unwrap() { prop_force_unwrap(UInt8.self) }
    }

    @Suite("UInt16") struct UInt16Tests {
        @Test func test_if_let() { prop_if_let(UInt16.self) }
        @Test func test_optional_return_type() { prop_optional_return_type(UInt16.self) }
        @Test func test_force_unwrap() { prop_force_unwrap(UInt16.self) }
    }

    @Suite("UInt32") struct UInt32Tests {
        @Test func test_if_let() { prop_if_let(UInt32.self) }
        @Test func test_optional_return_type() { prop_optional_return_type(UInt32.self) }
        @Test func test_force_unwrap() { prop_force_unwrap(UInt32.self) }
    }

    @Suite("UInt64") struct UInt64Tests {
        @Test func test_if_let() { prop_if_let(UInt64.self) }
        @Test func test_optional_return_type() { prop_optional_return_type(UInt64.self) }
        @Test func test_force_unwrap() { prop_force_unwrap(UInt64.self) }
    }

    @Suite("Float") struct FloatTests {
        @Test func test_if_let() { prop_if_let(Float.self) }
        @Test func test_optional_return_type() { prop_optional_return_type(Float.self) }
        @Test func test_force_unwrap() { prop_force_unwrap(Float.self) }
    }

    @Suite("Double") struct DoubleTests {
        @Test func test_if_let() { prop_if_let(Double.self) }
        @Test func test_optional_return_type() { prop_optional_return_type(Double.self) }
        @Test func test_force_unwrap() { prop_force_unwrap(Double.self) }
    }

    @Suite("Float32") struct Float32Tests {
        @Test func test_if_let() { prop_if_let(Float32.self) }
        @Test func test_optional_return_type() { prop_optional_return_type(Float32.self) }
        @Test func test_force_unwrap() { prop_force_unwrap(Float32.self) }
    }

    @Suite("Float64") struct Float64Tests {
        @Test func test_if_let() { prop_if_let(Float64.self) }
        @Test func test_optional_return_type() { prop_optional_return_type(Float64.self) }
        @Test func test_force_unwrap() { prop_force_unwrap(Float64.self) }
    }
}

private func prop_if_let<T: Arbitrary & Equatable & ExpressibleByIntegerLiteral>(_ proxy: T.Type) {
    func if_let(_ x: T?) -> T {
        if let unwrapped = x {
            return unwrapped
        }
        return 0
    }
    property(String(describing: T.self)+".if_let") <-
      forAllNoShrink([T?].arbitrary) { (xs: [T?]) in
        let expected = xs.map(if_let)
        let actual = map(xs, if_let)
        return try? #require( expected == actual )
      }
}

private func prop_optional_return_type<T: Arbitrary & Comparable & FloatingPoint>(_ proxy: T.Type) {
    func optional_return_type (_ x: T) -> T? {
        // equal probability of hitting both cases
        if x < 0 {
            return nil
        }
        return .some(x)
    }
    property(String(describing: T.self)+".optional_return_type") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map(optional_return_type)
        let actual = map(xs, optional_return_type)
        return try? #require( expected == actual )
      }
}

private func prop_optional_return_type<T: Arbitrary & Comparable & ExpressibleByIntegerLiteral & FixedWidthInteger>(_ proxy: T.Type) {
    func optional_return_type (_ x: T) -> T? {
        // equal probability of hitting both cases
        if x % 2 == 0 {
            return nil
        }
        return .some(x)
    }
    property(String(describing: T.self)+".optional_return_type") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map(optional_return_type)
        let actual = map(xs, optional_return_type)
        return try? #require( expected == actual )
      }
}

private func prop_force_unwrap<T: Arbitrary & Equatable>(_ proxy: T.Type) {
    func force_unwrap(_ x: T?) -> T {
        return x!
    }
    property(String(describing: T.self)+".force_unwrap") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let ws = xs.map { Optional($0) }
        let expected = ws.map(force_unwrap)
        let actual = map(ws, force_unwrap)
        return try? #require( expected == actual )
      }
}
