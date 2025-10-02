import SwiftCheck
import SwiftToPTX
import Testing

@Suite("Optionals") struct Optionals {
    @Suite("Int") struct IntTests {
        @Test("Int.if_let") func test_if_let() { prop_if_let(Int.self) }
        @Test("Int.optional_return_type") func test_optional_return_type() { prop_optional_return_type(Int.self) }
        @Test("Int.force_unwrap_nonnil") func test_force_unwrap_nonnil() { prop_force_unwrap_nonnil(Int.self) }
    }

    @Suite("Int8") struct Int8Tests {
        @Test("Int8.if_let") func test_if_let() { prop_if_let(Int8.self) }
        @Test("Int8.optional_return_type") func test_optional_return_type() { prop_optional_return_type(Int8.self) }
        @Test("Int8.force_unwrap_nonnil") func test_force_unwrap_nonnil() { prop_force_unwrap_nonnil(Int8.self) }
    }

    @Suite("Int16") struct Int16Tests {
        @Test("Int64.if_let") func test_if_let() { prop_if_let(Int16.self) }
        @Test("Int64.optional_return_type") func test_optional_return_type() { prop_optional_return_type(Int16.self) }
        @Test("Int64.force_unwrap_nonnil") func test_force_unwrap_nonnil() { prop_force_unwrap_nonnil(Int16.self) }
    }

    @Suite("Int32") struct Int32Tests {
        @Test("Int32.if_let") func test_if_let() { prop_if_let(Int32.self) }
        @Test("Int32.optional_return_type") func test_optional_return_type() { prop_optional_return_type(Int32.self) }
        @Test("Int32.force_unwrap_nonnil") func test_force_unwrap_nonnil() { prop_force_unwrap_nonnil(Int32.self) }
    }

    @Suite("Int64") struct Int64Tests {
        @Test("Int64.if_let") func test_if_let() { prop_if_let(Int64.self) }
        @Test("Int64.optional_return_type") func test_optional_return_type() { prop_optional_return_type(Int64.self) }
        @Test("Int64.force_unwrap_nonnil") func test_force_unwrap_nonnil() { prop_force_unwrap_nonnil(Int64.self) }
    }

    @Suite("UInt") struct UIntTests {
        @Test("UInt.if_let") func test_if_let() { prop_if_let(UInt.self) }
        @Test("UInt.optional_return_type") func test_optional_return_type() { prop_optional_return_type(UInt.self) }
        @Test("UInt.force_unwrap_nonnil") func test_force_unwrap_nonnil() { prop_force_unwrap_nonnil(UInt.self) }
    }

    @Suite("UInt8") struct UInt8Tests {
        @Test("UInt8.if_let") func test_if_let() { prop_if_let(UInt8.self) }
        @Test("UInt8.optional_return_type") func test_optional_return_type() { prop_optional_return_type(UInt8.self) }
        @Test("UInt8.force_unwrap_nonnil") func test_force_unwrap_nonnil() { prop_force_unwrap_nonnil(UInt8.self) }
    }

    @Suite("UInt16") struct UInt16Tests {
        @Test("UInt16.if_let") func test_if_let() { prop_if_let(UInt16.self) }
        @Test("UInt16.optional_return_type") func test_optional_return_type() { prop_optional_return_type(UInt16.self) }
        @Test("UInt16.force_unwrap_nonnil") func test_force_unwrap_nonnil() { prop_force_unwrap_nonnil(UInt16.self) }
    }

    @Suite("UInt32") struct UInt32Tests {
        @Test("UInt32.if_let") func test_if_let() { prop_if_let(UInt32.self) }
        @Test("UInt32.optional_return_type") func test_optional_return_type() { prop_optional_return_type(UInt32.self) }
        @Test("UInt32.force_unwrap_nonnil") func test_force_unwrap_nonnil() { prop_force_unwrap_nonnil(UInt32.self) }
    }

    @Suite("UInt64") struct UInt64Tests {
        @Test("UInt64.if_let") func test_if_let() { prop_if_let(UInt64.self) }
        @Test("UInt64.optional_return_type") func test_optional_return_type() { prop_optional_return_type(UInt64.self) }
        @Test("UInt64.force_unwrap_nonnil") func test_force_unwrap_nonnil() { prop_force_unwrap_nonnil(UInt64.self) }
    }

    @Suite("Float") struct FloatTests {
        @Test("Float.if_let") func test_if_let() { prop_if_let(Float.self) }
        @Test("Float.optional_return_type") func test_optional_return_type() { prop_optional_return_type(Float.self) }
        @Test("Float.force_unwrap_nonnil") func test_force_unwrap_nonnil() { prop_force_unwrap_nonnil(Float.self) }
    }

    @Suite("Double") struct DoubleTests {
        @Test("Double.if_let") func test_if_let() { prop_if_let(Double.self) }
        @Test("Double.optional_return_type") func test_optional_return_type() { prop_optional_return_type(Double.self) }
        @Test("Double.force_unwrap_nonnil") func test_force_unwrap_nonnil() { prop_force_unwrap_nonnil(Double.self) }
    }

    @Suite("Float32") struct Float32Tests {
        @Test("Float32.if_let") func test_if_let() { prop_if_let(Float32.self) }
        @Test("Float32.optional_return_type") func test_optional_return_type() { prop_optional_return_type(Float32.self) }
        @Test("Float32.force_unwrap_nonnil") func test_force_unwrap_nonnil() { prop_force_unwrap_nonnil(Float32.self) }
    }

    @Suite("Float64") struct Float64Tests {
        @Test("Float64.if_let") func test_if_let() { prop_if_let(Float64.self) }
        @Test("Float64.optional_return_type") func test_optional_return_type() { prop_optional_return_type(Float64.self) }
        @Test("Float64.force_unwrap_nonnil") func test_force_unwrap_nonnil() { prop_force_unwrap_nonnil(Float64.self) }
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
    func optional_return_type(_ x: T) -> T? {
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
    func optional_return_type(_ x: T) -> T? {
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

private func prop_force_unwrap_nonnil<T: Arbitrary & Equatable>(_ proxy: T.Type) {
    // `x` assumed to be non-nil. force-unwrapping a nil is a non-recoverable error
    // and needs to be tested in e.g. a lit+FileCheck driven test.
    func force_unwrap_nonnil(_ x: T?) -> T {
        x!
    }
    property(String(describing: T.self)+".force_unwrap_nonnil") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let ws = xs.map { Optional($0) }
        let expected = ws.map(force_unwrap_nonnil)
        let actual = map(ws, force_unwrap_nonnil)
        return try? #require( expected == actual )
      }
}
