// Copyright (c) 2025 PassiveLogic, Inc.

import SwiftCheck
import SwiftToPTX
import Testing

@Suite("Optionals") struct Optionals {
    @Test("if_let.Int") func test_if_let_1() { prop_if_let(Int.self) }
    @Test("if_let.Int8") func test_if_let_2() { prop_if_let(Int8.self) }
    @Test("if_let.Int64") func test_if_let_3() { prop_if_let(Int16.self) }
    @Test("if_let.Int32") func test_if_let_4() { prop_if_let(Int32.self) }
    @Test("if_let.Int64") func test_if_let_5() { prop_if_let(Int64.self) }
    @Test("if_let.UInt") func test_if_let_6() { prop_if_let(UInt.self) }
    @Test("if_let.UInt8") func test_if_let_7() { prop_if_let(UInt8.self) }
    @Test("if_let.UInt16") func test_if_let_8() { prop_if_let(UInt16.self) }
    @Test("if_let.UInt32") func test_if_let_9() { prop_if_let(UInt32.self) }
    @Test("if_let.UInt64") func test_if_let_10() { prop_if_let(UInt64.self) }
    @Test("if_let.Float32") func test_if_let_13() { prop_if_let(Float32.self) }
    @Test("if_let.Float64") func test_if_let_14() { prop_if_let(Float64.self) }

    @Test("optional_return_type.Int") func test_optional_return_type_1() { prop_optional_return_type(Int.self) }
    @Test("optional_return_type.Int8") func test_optional_return_type_2() { prop_optional_return_type(Int8.self) }
    @Test("optional_return_type.Int32") func test_optional_return_type_3() { prop_optional_return_type(Int32.self) }
    @Test("optional_return_type.Int64") func test_optional_return_type_4() { prop_optional_return_type(Int16.self) }
    @Test("optional_return_type.Int64") func test_optional_return_type_5() { prop_optional_return_type(Int64.self) }
    @Test("optional_return_type.UInt") func test_optional_return_type_6() { prop_optional_return_type(UInt.self) }
    @Test("optional_return_type.UInt8") func test_optional_return_type_7() { prop_optional_return_type(UInt8.self) }
    @Test("optional_return_type.UInt16") func test_optional_return_type_8() { prop_optional_return_type(UInt16.self) }
    @Test("optional_return_type.UInt32") func test_optional_return_type_9() { prop_optional_return_type(UInt32.self) }
    @Test("optional_return_type.UInt64") func test_optional_return_type_10() { prop_optional_return_type(UInt64.self) }
    @Test("optional_return_type.Float32") func test_optional_return_type_13() { prop_optional_return_type(Float32.self) }
    @Test("optional_return_type.Float64") func test_optional_return_type_14() { prop_optional_return_type(Float64.self) }

    @Test("force_unwrap_nonnil.Int") func test_force_unwrap_nonnil_1() { prop_force_unwrap_nonnil(Int.self) }
    @Test("force_unwrap_nonnil.Int8") func test_force_unwrap_nonnil_2() { prop_force_unwrap_nonnil(Int8.self) }
    @Test("force_unwrap_nonnil.Int64") func test_force_unwrap_nonnil_3() { prop_force_unwrap_nonnil(Int16.self) }
    @Test("force_unwrap_nonnil.Int32") func test_force_unwrap_nonnil_4() { prop_force_unwrap_nonnil(Int32.self) }
    @Test("force_unwrap_nonnil.Int64") func test_force_unwrap_nonnil_5() { prop_force_unwrap_nonnil(Int64.self) }
    @Test("force_unwrap_nonnil.UInt") func test_force_unwrap_nonnil_6() { prop_force_unwrap_nonnil(UInt.self) }
    @Test("force_unwrap_nonnil.UInt8") func test_force_unwrap_nonnil_7() { prop_force_unwrap_nonnil(UInt8.self) }
    @Test("force_unwrap_nonnil.UInt16") func test_force_unwrap_nonnil_8() { prop_force_unwrap_nonnil(UInt16.self) }
    @Test("force_unwrap_nonnil.UInt32") func test_force_unwrap_nonnil_9() { prop_force_unwrap_nonnil(UInt32.self) }
    @Test("force_unwrap_nonnil.UInt64") func test_force_unwrap_nonnil_10() { prop_force_unwrap_nonnil(UInt64.self) }
    @Test("force_unwrap_nonnil.Float32") func test_force_unwrap_nonnil_13() { prop_force_unwrap_nonnil(Float32.self) }
    @Test("force_unwrap_nonnil.Float64") func test_force_unwrap_nonnil_14() { prop_force_unwrap_nonnil(Float64.self) }
}

private func prop_if_let<T: Arbitrary & Equatable & ExpressibleByIntegerLiteral>(_: T.Type) {
    func if_let(_ x: T?) -> T {
        if let unwrapped = x {
            return unwrapped
        }
        return 0
    }
    property(String(describing: T.self) + ".if_let") <-
      forAllNoShrink([T?].arbitrary) { (xs: [T?]) in
        let expected = xs.map(if_let)
        let actual = map(xs, if_let)
        return try? #require(expected == actual)
      }
}

private func prop_optional_return_type<T: Arbitrary & Comparable & FloatingPoint>(_: T.Type) {
    func optional_return_type(_ x: T) -> T? {
        // equal probability of hitting both cases
        if x < 0 {
            return nil
        }
        return .some(x)
    }
    property(String(describing: T.self) + ".optional_return_type") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map(optional_return_type)
        let actual = map(xs, optional_return_type)
        return try? #require(expected == actual)
      }
}

private func prop_optional_return_type<T: Arbitrary & Comparable & ExpressibleByIntegerLiteral & FixedWidthInteger>(_: T.Type) {
    func optional_return_type(_ x: T) -> T? {
        // equal probability of hitting both cases
        if x % 2 == 0 {
            return nil
        }
        return .some(x)
    }
    property(String(describing: T.self) + ".optional_return_type") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map(optional_return_type)
        let actual = map(xs, optional_return_type)
        return try? #require(expected == actual)
      }
}

private func prop_force_unwrap_nonnil<T: Arbitrary & Equatable>(_: T.Type) {
    // `x` assumed to be non-nil. force-unwrapping a nil is a non-recoverable error
    // and needs to be tested in e.g. a lit+FileCheck driven test.
    func force_unwrap_nonnil(_ x: T?) -> T {
        // swiftlint:disable:next force_unwrapping
        x!
    }
    property(String(describing: T.self) + ".force_unwrap_nonnil") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let ys = xs.map { Optional($0) }
        let expected = ys.map(force_unwrap_nonnil)
        let actual = map(ys, force_unwrap_nonnil)
        return try? #require(expected == actual)
      }
}
