import SwiftCheck
import SwiftToPTX
import Testing

@Suite("function calls") struct FunctionCallsSuite {
    @Suite("Int") struct IntTests {
        @Test("Int.unary") func test_unary() { prop_unary(Int.self) }
        @Test("Int.binary") func test_binary() { prop_binary(Int.self) }
        @Test("Int.ternary") func test_ternary() { prop_ternary(Int.self) }
        @Test("Int.unary_noinline") func test_unary_noinline() { prop_unary_noinline(Int.self) }
        @Test("Int.binary_noinline") func test_binary_noinline() { prop_binary_noinline(Int.self) }
        @Test("Int.ternary_noinline") func test_ternary_noinline() { prop_ternary_noinline(Int.self) }
        // @Test("Int.unary_inout", .bug(id: "86b6ycdvn")) func test_unary_inout() { prop_unary_inout(Int.self) }
        // @Test("Int.binary_inout", .bug(id: "86b6ycdvn")) func test_binary_inout() { prop_binary_inout(Int.self) }
        @Test("Int.factorial_recursive") func test_factorial_recursive() { prop_factorial_recursive(Int.self) }
        @Test("Int.factorial_tailcall") func test_factorial_tailcall() { prop_factorial_tailcall(Int.self) }
        @Test("Int.factorial_recursive_noinline") func test_factorial_recursive_noinline() { prop_factorial_recursive_noinline(Int.self) }
        @Test("Int.factorial_tailcall_noinline") func test_factorial_tailcall_noinline() { prop_factorial_tailcall_noinline(Int.self) }
        @Test("Int.mutually_recursive") func test_mutually_recursive() { prop_mutually_recursive(Int.self) }
        @Test("Int.mutually_recursive_noinline") func test_mutually_recursive_noinline() { prop_mutually_recursive_noinline(Int.self) }
        @Test("Int.fibonacci_recursive") func test_fibonacci_recursive() { prop_fibonacci_recursive(Int.self) }
        @Test("Int.fibonacci_recursive_noinline") func test_fibonacci_recursive_noinline() { prop_fibonacci_recursive_noinline(Int.self) }
    }

    @Suite("Int8") struct Int8Tests {
        @Test("Int8.unary") func test_unary() { prop_unary(Int8.self) }
        @Test("Int8.binary") func test_binary() { prop_binary(Int8.self) }
        @Test("Int8.ternary") func test_ternary() { prop_ternary(Int8.self) }
        @Test("Int8.unary_noinline") func test_unary_noinline() { prop_unary_noinline(Int8.self) }
        @Test("Int8.binary_noinline") func test_binary_noinline() { prop_binary_noinline(Int8.self) }
        @Test("Int8.ternary_noinline") func test_ternary_noinline() { prop_ternary_noinline(Int8.self) }
        // @Test("Int8.unary_inout", .bug(id: "86b6ycdvn")) func test_unary_inout() { prop_unary_inout(Int8.self) }
        // @Test("Int8.binary_inout", .bug(id: "86b6ycdvn")) func test_binary_inout() { prop_binary_inout(Int8.self) }
        @Test("Int8.factorial_recursive") func test_factorial_recursive() { prop_factorial_recursive(Int8.self) }
        @Test("Int8.factorial_tailcall") func test_factorial_tailcall() { prop_factorial_tailcall(Int8.self) }
        @Test("Int8.factorial_recursive_noinline") func test_factorial_recursive_noinline() { prop_factorial_recursive_noinline(Int8.self) }
        @Test("Int8.factorial_tailcall_noinline") func test_factorial_tailcall_noinline() { prop_factorial_tailcall_noinline(Int8.self) }
        @Test("Int8.mutually_recursive") func test_mutually_recursive() { prop_mutually_recursive(Int8.self) }
        @Test("Int8.mutually_recursive_noinline") func test_mutually_recursive_noinline() { prop_mutually_recursive_noinline(Int8.self) }
        @Test("Int8.fibonacci_recursive") func test_fibonacci_recursive() { prop_fibonacci_recursive(Int8.self) }
        @Test("Int8.fibonacci_recursive_noinline") func test_fibonacci_recursive_noinline() { prop_fibonacci_recursive_noinline(Int8.self) }
    }

    @Suite("Int16") struct Int16Tests {
        @Test("Int16.unary") func test_unary() { prop_unary(Int16.self) }
        @Test("Int16.binary") func test_binary() { prop_binary(Int16.self) }
        @Test("Int16.ternary") func test_ternary() { prop_ternary(Int16.self) }
        @Test("Int16.unary_noinline") func test_unary_noinline() { prop_unary_noinline(Int16.self) }
        @Test("Int16.binary_noinline") func test_binary_noinline() { prop_binary_noinline(Int16.self) }
        @Test("Int16.ternary_noinline") func test_ternary_noinline() { prop_ternary_noinline(Int16.self) }
        // @Test("Int16.unary_inout", .bug(id: "86b6ycdvn")) func test_unary_inout() { prop_unary_inout(Int16.self) }
        // @Test("Int16.binary_inout", .bug(id: "86b6ycdvn")) func test_binary_inout() { prop_binary_inout(Int16.self) }
        @Test("Int16.factorial_recursive") func test_factorial_recursive() { prop_factorial_recursive(Int16.self) }
        @Test("Int16.factorial_tailcall") func test_factorial_tailcall() { prop_factorial_tailcall(Int16.self) }
        @Test("Int16.factorial_recursive_noinline") func test_factorial_recursive_noinline() { prop_factorial_recursive_noinline(Int16.self) }
        @Test("Int16.factorial_tailcall_noinline") func test_factorial_tailcall_noinline() { prop_factorial_tailcall_noinline(Int16.self) }
        @Test("Int16.mutually_recursive") func test_mutually_recursive() { prop_mutually_recursive(Int16.self) }
        @Test("Int16.mutually_recursive_noinline") func test_mutually_recursive_noinline() { prop_mutually_recursive_noinline(Int16.self) }
        @Test("Int16.fibonacci_recursive") func test_fibonacci_recursive() { prop_fibonacci_recursive(Int16.self) }
        @Test("Int16.fibonacci_recursive_noinline") func test_fibonacci_recursive_noinline() { prop_fibonacci_recursive_noinline(Int16.self) }
    }

    @Suite("Int32") struct Int32Tests {
        @Test("Int32.unary") func test_unary() { prop_unary(Int32.self) }
        @Test("Int32.binary") func test_binary() { prop_binary(Int32.self) }
        @Test("Int32.ternary") func test_ternary() { prop_ternary(Int32.self) }
        @Test("Int32.unary_noinline") func test_unary_noinline() { prop_unary_noinline(Int32.self) }
        @Test("Int32.binary_noinline") func test_binary_noinline() { prop_binary_noinline(Int32.self) }
        @Test("Int32.ternary_noinline") func test_ternary_noinline() { prop_ternary_noinline(Int32.self) }
        // @Test("Int32.unary_inout", .bug(id: "86b6ycdvn")) func test_unary_inout() { prop_unary_inout(Int32.self) }
        // @Test("Int32.binary_inout", .bug(id: "86b6ycdvn")) func test_binary_inout() { prop_binary_inout(Int32.self) }
        @Test("Int32.factorial_recursive") func test_factorial_recursive() { prop_factorial_recursive(Int32.self) }
        @Test("Int32.factorial_tailcall") func test_factorial_tailcall() { prop_factorial_tailcall(Int32.self) }
        @Test("Int32.factorial_recursive_noinline") func test_factorial_recursive_noinline() { prop_factorial_recursive_noinline(Int32.self) }
        @Test("Int32.factorial_tailcall_noinline") func test_factorial_tailcall_noinline() { prop_factorial_tailcall_noinline(Int32.self) }
        @Test("Int32.mutually_recursive") func test_mutually_recursive() { prop_mutually_recursive(Int32.self) }
        @Test("Int32.mutually_recursive_noinline") func test_mutually_recursive_noinline() { prop_mutually_recursive_noinline(Int32.self) }
        @Test("Int32.fibonacci_recursive") func test_fibonacci_recursive() { prop_fibonacci_recursive(Int32.self) }
        @Test("Int32.fibonacci_recursive_noinline") func test_fibonacci_recursive_noinline() { prop_fibonacci_recursive_noinline(Int32.self) }
    }

    @Suite("Int64") struct Int64Tests {
        @Test("Int64.unary") func test_unary() { prop_unary(Int64.self) }
        @Test("Int64.binary") func test_binary() { prop_binary(Int64.self) }
        @Test("Int64.ternary") func test_ternary() { prop_ternary(Int64.self) }
        @Test("Int64.unary_noinline") func test_unary_noinline() { prop_unary_noinline(Int64.self) }
        @Test("Int64.binary_noinline") func test_binary_noinline() { prop_binary_noinline(Int64.self) }
        @Test("Int64.ternary_noinline") func test_ternary_noinline() { prop_ternary_noinline(Int64.self) }
        // @Test("Int64.unary_inout", .bug(id: "86b6ycdvn")) func test_unary_inout() { prop_unary_inout(Int64.self) }
        // @Test("Int64.binary_inout", .bug(id: "86b6ycdvn")) func test_binary_inout() { prop_binary_inout(Int64.self) }
        @Test("Int64.factorial_recursive") func test_factorial_recursive() { prop_factorial_recursive(Int64.self) }
        @Test("Int64.factorial_tailcall") func test_factorial_tailcall() { prop_factorial_tailcall(Int64.self) }
        @Test("Int64.factorial_recursive_noinline") func test_factorial_recursive_noinline() { prop_factorial_recursive_noinline(Int64.self) }
        @Test("Int64.factorial_tailcall_noinline") func test_factorial_tailcall_noinline() { prop_factorial_tailcall_noinline(Int64.self) }
        @Test("Int64.mutually_recursive") func test_mutually_recursive() { prop_mutually_recursive(Int64.self) }
        @Test("Int64.mutually_recursive_noinline") func test_mutually_recursive_noinline() { prop_mutually_recursive_noinline(Int64.self) }
        @Test("Int64.fibonacci_recursive") func test_fibonacci_recursive() { prop_fibonacci_recursive(Int64.self) }
        @Test("Int64.fibonacci_recursive_noinline") func test_fibonacci_recursive_noinline() { prop_fibonacci_recursive_noinline(Int64.self) }
    }

    @Suite("UInt") struct UIntTests {
        @Test("UInt.unary") func test_unary() { prop_unary(UInt.self) }
        @Test("UInt.binary") func test_binary() { prop_binary(UInt.self) }
        @Test("UInt.ternary") func test_ternary() { prop_ternary(UInt.self) }
        @Test("UInt.unary_noinline") func test_unary_noinline() { prop_unary_noinline(UInt.self) }
        @Test("UInt.binary_noinline") func test_binary_noinline() { prop_binary_noinline(UInt.self) }
        @Test("UInt.ternary_noinline") func test_ternary_noinline() { prop_ternary_noinline(UInt.self) }
        // @Test("UInt.unary_inout", .bug(id: "86b6ycdvn")) func test_unary_inout() { prop_unary_inout(Int.self) }
        // @Test("UInt.binary_inout", .bug(id: "86b6ycdvn")) func test_binary_inout() { prop_binary_inout(Int.self) }
        @Test("UInt.factorial_recursive") func test_factorial_recursive() { prop_factorial_recursive(UInt.self) }
        @Test("UInt.factorial_tailcall") func test_factorial_tailcall() { prop_factorial_tailcall(UInt.self) }
        @Test("UInt.factorial_recursive_noinline") func test_factorial_recursive_noinline() { prop_factorial_recursive_noinline(UInt.self) }
        @Test("UInt.factorial_tailcall_noinline") func test_factorial_tailcall_noinline() { prop_factorial_tailcall_noinline(UInt.self) }
        @Test("UInt.mutually_recursive") func test_mutually_recursive() { prop_mutually_recursive(UInt.self) }
        @Test("UInt.mutually_recursive_noinline") func test_mutually_recursive_noinline() { prop_mutually_recursive_noinline(UInt.self) }
        @Test("UInt.fibonacci_recursive") func test_fibonacci_recursive() { prop_fibonacci_recursive(UInt.self) }
        @Test("UInt.fibonacci_recursive_noinline") func test_fibonacci_recursive_noinline() { prop_fibonacci_recursive_noinline(UInt.self) }
    }

    @Suite("UInt8") struct UInt8Tests {
        @Test("UInt8.unary") func test_unary() { prop_unary(UInt8.self) }
        @Test("UInt8.binary") func test_binary() { prop_binary(UInt8.self) }
        @Test("UInt8.ternary") func test_ternary() { prop_ternary(UInt8.self) }
        @Test("UInt8.unary_noinline") func test_unary_noinline() { prop_unary_noinline(UInt8.self) }
        @Test("UInt8.binary_noinline") func test_binary_noinline() { prop_binary_noinline(UInt8.self) }
        @Test("UInt8.ternary_noinline") func test_ternary_noinline() { prop_ternary_noinline(UInt8.self) }
        // @Test("UInt8.unary_inout", .bug(id: "86b6ycdvn")) func test_unary_inout() { prop_unary_inout(Int.self) }
        // @Test("UInt8.binary_inout", .bug(id: "86b6ycdvn")) func test_binary_inout() { prop_binary_inout(Int.self) }
        @Test("UInt8.factorial_recursive") func test_factorial_recursive() { prop_factorial_recursive(UInt8.self) }
        @Test("UInt8.factorial_tailcall") func test_factorial_tailcall() { prop_factorial_tailcall(UInt8.self) }
        @Test("UInt8.factorial_recursive_noinline") func test_factorial_recursive_noinline() { prop_factorial_recursive_noinline(UInt8.self) }
        @Test("UInt8.factorial_tailcall_noinline") func test_factorial_tailcall_noinline() { prop_factorial_tailcall_noinline(UInt8.self) }
        @Test("UInt8.mutually_recursive") func test_mutually_recursive() { prop_mutually_recursive(UInt8.self) }
        @Test("UInt8.mutually_recursive_noinline") func test_mutually_recursive_noinline() { prop_mutually_recursive_noinline(UInt8.self) }
        @Test("UInt8.fibonacci_recursive") func test_fibonacci_recursive() { prop_fibonacci_recursive(UInt8.self) }
        @Test("UInt8.fibonacci_recursive_noinline") func test_fibonacci_recursive_noinline() { prop_fibonacci_recursive_noinline(UInt8.self) }
    }

    @Suite("UInt16") struct UInt16Tests {
        @Test("UInt8.unary") func test_unary() { prop_unary(UInt16.self) }
        @Test("UInt8.binary") func test_binary() { prop_binary(UInt16.self) }
        @Test("UInt8.ternary") func test_ternary() { prop_ternary(UInt16.self) }
        @Test("UInt8.unary_noinline") func test_unary_noinline() { prop_unary_noinline(UInt16.self) }
        @Test("UInt8.binary_noinline") func test_binary_noinline() { prop_binary_noinline(UInt16.self) }
        @Test("UInt8.ternary_noinline") func test_ternary_noinline() { prop_ternary_noinline(UInt16.self) }
        // @Test("UInt8.unary_inout", .bug(id: "86b6ycdvn")) func test_unary_inout() { prop_unary_inout(Int.self) }
        // @Test("UInt8.binary_inout", .bug(id: "86b6ycdvn")) func test_binary_inout() { prop_binary_inout(Int.self) }
        @Test("UInt8.factorial_recursive") func test_factorial_recursive() { prop_factorial_recursive(UInt16.self) }
        @Test("UInt8.factorial_tailcall") func test_factorial_tailcall() { prop_factorial_tailcall(UInt16.self) }
        @Test("UInt8.factorial_recursive_noinline") func test_factorial_recursive_noinline() { prop_factorial_recursive_noinline(UInt16.self) }
        @Test("UInt8.factorial_tailcall_noinline") func test_factorial_tailcall_noinline() { prop_factorial_tailcall_noinline(UInt16.self) }
        @Test("UInt8.mutually_recursive") func test_mutually_recursive() { prop_mutually_recursive(UInt16.self) }
        @Test("UInt8.mutually_recursive_noinline") func test_mutually_recursive_noinline() { prop_mutually_recursive_noinline(UInt16.self) }
        @Test("UInt8.fibonacci_recursive") func test_fibonacci_recursive() { prop_fibonacci_recursive(UInt16.self) }
        @Test("UInt8.fibonacci_recursive_noinline") func test_fibonacci_recursive_noinline() { prop_fibonacci_recursive_noinline(UInt16.self) }
    }

    @Suite("UInt32") struct UInt32Tests {
        @Test("UInt32.unary") func test_unary() { prop_unary(UInt32.self) }
        @Test("UInt32.binary") func test_binary() { prop_binary(UInt32.self) }
        @Test("UInt32.ternary") func test_ternary() { prop_ternary(UInt32.self) }
        @Test("UInt32.unary_noinline") func test_unary_noinline() { prop_unary_noinline(UInt32.self) }
        @Test("UInt32.binary_noinline") func test_binary_noinline() { prop_binary_noinline(UInt32.self) }
        @Test("UInt32.ternary_noinline") func test_ternary_noinline() { prop_ternary_noinline(UInt32.self) }
        // @Test("UInt32.unary_inout", .bug(id: "86b6ycdvn")) func test_unary_inout() { prop_unary_inout(Int.self) }
        // @Test("UInt32.binary_inout", .bug(id: "86b6ycdvn")) func test_binary_inout() { prop_binary_inout(Int.self) }
        @Test("UInt32.factorial_recursive") func test_factorial_recursive() { prop_factorial_recursive(UInt32.self) }
        @Test("UInt32.factorial_tailcall") func test_factorial_tailcall() { prop_factorial_tailcall(UInt32.self) }
        @Test("UInt32.factorial_recursive_noinline") func test_factorial_recursive_noinline() { prop_factorial_recursive_noinline(UInt32.self) }
        @Test("UInt32.factorial_tailcall_noinline") func test_factorial_tailcall_noinline() { prop_factorial_tailcall_noinline(UInt32.self) }
        @Test("UInt32.mutually_recursive") func test_mutually_recursive() { prop_mutually_recursive(UInt32.self) }
        @Test("UInt32.mutually_recursive_noinline") func test_mutually_recursive_noinline() { prop_mutually_recursive_noinline(UInt32.self) }
        @Test("UInt32.fibonacci_recursive") func test_fibonacci_recursive() { prop_fibonacci_recursive(UInt32.self) }
        @Test("UInt32.fibonacci_recursive_noinline") func test_fibonacci_recursive_noinline() { prop_fibonacci_recursive_noinline(UInt32.self) }
    }

    @Suite("UInt64") struct UInt64Tests {
        @Test("UInt64.unary") func test_unary() { prop_unary(UInt64.self) }
        @Test("UInt64.binary") func test_binary() { prop_binary(UInt64.self) }
        @Test("UInt64.ternary") func test_ternary() { prop_ternary(UInt64.self) }
        @Test("UInt64.unary_noinline") func test_unary_noinline() { prop_unary_noinline(UInt64.self) }
        @Test("UInt64.binary_noinline") func test_binary_noinline() { prop_binary_noinline(UInt64.self) }
        @Test("UInt64.ternary_noinline") func test_ternary_noinline() { prop_ternary_noinline(UInt64.self) }
        // @Test("UInt64.unary_inout", .bug(id: "86b6ycdvn")) func test_unary_inout() { prop_unary_inout(Int.self) }
        // @Test("UInt64.binary_inout", .bug(id: "86b6ycdvn")) func test_binary_inout() { prop_binary_inout(Int.self) }
        @Test("UInt64.factorial_recursive") func test_factorial_recursive() { prop_factorial_recursive(UInt64.self) }
        @Test("UInt64.factorial_tailcall") func test_factorial_tailcall() { prop_factorial_tailcall(UInt64.self) }
        @Test("UInt64.factorial_recursive_noinline") func test_factorial_recursive_noinline() { prop_factorial_recursive_noinline(UInt64.self) }
        @Test("UInt64.factorial_tailcall_noinline") func test_factorial_tailcall_noinline() { prop_factorial_tailcall_noinline(UInt64.self) }
        @Test("UInt64.mutually_recursive") func test_mutually_recursive() { prop_mutually_recursive(UInt64.self) }
        @Test("UInt64.mutually_recursive_noinline") func test_mutually_recursive_noinline() { prop_mutually_recursive_noinline(UInt64.self) }
        @Test("UInt64.fibonacci_recursive") func test_fibonacci_recursive() { prop_fibonacci_recursive(UInt64.self) }
        @Test("UInt64.fibonacci_recursive_noinline") func test_fibonacci_recursive_noinline() { prop_fibonacci_recursive_noinline(UInt64.self) }
    }
}

// MARK: simple function calls

private func prop_unary<T: Arbitrary & Similar>(_ proxy: T.Type) {
    func unary(_ x: T) -> T { x }
    property("unary(\(String(describing: T.self)))") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map(unary)
        let actual = map(xs, unary)
        return try? #require( expected ~~~ actual )
      }
}

private func prop_binary<T: Arbitrary & Similar & BinaryInteger>(_ proxy: T.Type) {
    // function that does not boil down to a primitive
    func binary(_ x1: T, _ x2: T) -> T {
        (x1 & x2) >> 1
    }
    property(String(describing: T.self)+".binary_function") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink([T].arbitrary) { (ys: [T]) in
        let expected = zip(xs, ys).map { (x, y) in binary(x, y) }
        let actual = zipWith(xs, ys, binary)
        return try? #require( expected ~~~ actual )
      }}
}

private func prop_binary<T: Arbitrary & Similar & FloatingPoint>(_ proxy: T.Type) {
    // function that does not boil down to a primitive
    func binary(_ x1: T, _ x2: T) -> T {
        x1 + x2 * (x1 * x2)
    }
    property("binary(\(String(describing: T.self)))") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink([T].arbitrary) { (ys: [T]) in
        let expected = zip(xs, ys).map { (x, y) in binary(x, y) }
        let actual = zipWith(xs, ys, binary)
        return try? #require( expected ~~~ actual )
      }}
}

// TODO: tests for multi-arity functions with heterogeneous types, i.e.
// (T1, T2) -> T3, where T1 != T2 != T3 != T1 in general

private func prop_ternary<T: Arbitrary & Similar & Comparable>(_ proxy: T.Type) {
    func ternary(_ x1: T, _ x2: T, _ x3: T) -> T { min(max(x1, x2), x3) }
    property("ternary(\(String(describing: T.self)))") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink([T].arbitrary) { (ys: [T]) in
      forAllNoShrink([T].arbitrary) { (zs: [T]) in
        let size = min(min(xs.count, ys.count), zs.count)
        let expected = (0 ..< size).map { i in ternary(xs[i], ys[i], zs[i]) }
        let actual = generate(count: size) { i in ternary(xs[i], ys[i], zs[i]) }
        return try? #require( expected ~~~ actual )
      }}}
}

private func prop_unary_noinline<T: Arbitrary & Similar & Numeric>(_ proxy: T.Type) {
    @inline(never)
    func unary(_ x: T) -> T { x }
    property("unary_noinline(\(T.self))") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map(unary)
        let actual = map(xs, unary)
        return try? #require( expected ~~~ actual )
      }
}

private func prop_binary_noinline<T: Arbitrary & Similar & BinaryInteger>(_ proxy: T.Type) {
    @inline(never)
    func binary(_ x1: T, _ x2: T) -> T {
        (x1 & x2) >> 1
    }
    property("binary_noinline(\(String(describing: T.self))") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink([T].arbitrary) { (ys: [T]) in
        let expected = zip(xs, ys).map { (x, y) in binary(x, y) }
        let actual = zipWith(xs, ys, binary)
        return try? #require( expected ~~~ actual )
      }}
}

private func prop_binary_noinline<T: Arbitrary & Similar & FloatingPoint>(_ proxy: T.Type) {
    @inline(never)
    func binary(_ x1: T, _ x2: T) -> T {
        x1 + x2 * (x1 * x2)
    }
    property("binary_noinline(\(String(describing: T.self))") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink([T].arbitrary) { (ys: [T]) in
        let expected = zip(xs, ys).map { (x, y) in binary(x, y) }
        let actual = zipWith(xs, ys, binary)
        return try? #require( expected ~~~ actual )
      }}
}

private func prop_ternary_noinline<T: Arbitrary & Similar & Comparable>(_ proxy: T.Type) {
    @inline(never)
    func ternary(_ x1: T, _ x2: T, _ x3: T) -> T { min(max(x1, x2), x3) }
    property("ternary_noinline(\(String(describing: T.self)))") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink([T].arbitrary) { (ys: [T]) in
      forAllNoShrink([T].arbitrary) { (zs: [T]) in
        let size = min(min(xs.count, ys.count), zs.count)
        let expected = (0 ..< size).map { i in ternary(xs[i], ys[i], zs[i]) }
        let actual = generate(count: size) { i in ternary(xs[i], ys[i], zs[i]) }
        return try? #require( expected ~~~ actual )
      }}}
}

private func prop_unary_inout<T: Arbitrary & Similar & ExpressibleByIntegerLiteral>(_ proxy: T.Type) {
    func unary_inout(_ x: inout T) {
        x = 0
    }
    property("unary_inout(\(String(describing: T.self)))") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected: [T] = fill(count: xs.count, with: 0)
        var actual = xs
        // NOTE: `parallel_for` required here because of in-place mutation,
        // i.e. modify accessor instead of subscript set
        parallel_for(iterations: xs.count) { i in
            unary_inout(&actual[i])
        }.sync()
        return try? #require( expected ~~~ actual )
      }
}

private func prop_binary_inout<T: Arbitrary & Similar & ExpressibleByIntegerLiteral>(_ proxy: T.Type) {
    func binary_inout(_ x: inout T, _ y: T) {
        x = y
    }
    property("unary_inout(\(String(describing: T.self)))") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink(T.arbitrary) { (y: T) in
        let expected = fill(count: xs.count, with: y)
        var actual = xs
        // NOTE: `parallel_for` required here because of in-place mutation,
        // i.e. modify accessor instead of subscript set
        parallel_for(iterations: actual.count) { i in
            binary_inout(&actual[i], y)
        }.sync()
        return try? #require( expected ~~~ actual )
      }}
}

// MARK: recursive functions

private func prop_factorial_recursive<T: RandomType & Similar & BinaryInteger>(_ proxy: T.Type) {
    func factorial(_ n: T) -> T {
        guard n > 1 else { return 1 }
        return n * factorial(n - 1)
    }
    let gen = Gen<T>.choose((T.zero, 5)) // 5! fits in Int8, 6! does not
    property("factorial_recursive(\(String(describing: T.self)))") <-
      forAllNoShrink(gen.proliferate) { (xs: [T]) in
        let expected = xs.map(factorial)
        let actual = map(xs, factorial)
        return try? #require( expected ~~~ actual )
      }
}

private func prop_factorial_tailcall<T: RandomType & Similar & BinaryInteger>(_ proxy: T.Type) {
    func factorial(_ n: T, _ acc: T = 0) -> T {
        guard n > 1 else { return acc }
        return factorial(n - 1, n * acc)
    }
    let gen = Gen<T>.choose((T.zero, 5)) // 5! fits in Int8, 6! does not
    property("factorial_tailcall(\(String(describing: T.self)))") <-
      forAllNoShrink(gen.proliferate) { (xs: [T]) in
        let expected = xs.map { n in factorial(n) }
        let actual = map(xs) { n in factorial(n) }
        return try? #require( expected ~~~ actual )
      }
}

private func prop_factorial_recursive_noinline<T: RandomType & Similar & BinaryInteger>(_ proxy: T.Type) {
    @inline(never)
    func factorial(_ n: T) -> T {
        guard n > 1 else { return 1 }
        return n * factorial(n - 1)
    }
    let gen = Gen<T>.choose((T.zero, 5)) // 5! fits in Int8, 6! does not
    property("factorial_recursive_noinline(\(String(describing: T.self)))") <-
      forAllNoShrink(gen.proliferate) { (xs: [T]) in
        let expected = xs.map(factorial)
        let actual = map(xs, factorial)
        return try? #require( expected ~~~ actual )
      }
}

private func prop_factorial_tailcall_noinline<T: RandomType & Similar & BinaryInteger>(_ proxy: T.Type) {
    @inline(never)
    func factorial(_ n: T, _ acc: T = 0) -> T {
        guard n > 1 else { return acc }
        return factorial(n - 1, n * acc)
    }
    let gen = Gen<T>.choose((T.zero, 5)) // 5! fits in Int8, 6! does not
    property("factorial_tailcall_noinline(\(String(describing: T.self)))") <-
      forAllNoShrink(gen.proliferate) { (xs: [T]) in
        let expected = xs.map { n in factorial(n) }
        let actual = map(xs) { n in factorial(n) }
        return try? #require( expected ~~~ actual )
      }
}

private func prop_mutually_recursive<T: RandomType & Similar & BinaryInteger>(_ proxy: T.Type) {
    func odd(_ n: T) -> T {
        guard n != 1 else {
            return n
        }
        return n + even(n - 1)
    }
    func even(_ n: T) -> T {
        guard n != 0 else {
            return n
        }
        return n * odd(n - 1)
    }
    func mutually_recursive(_ n: T) -> T {
        guard n > 1 else {
            return n
        }
        return if n % 2 == 0 {
            n * odd(n - 1)
        } else {
            n + even(n - 1)
        }
    }
    let gen = Gen<T>.choose((T.zero, 5))
    property("mutually_recursive(\(String(describing: T.self)))") <-
      forAllNoShrink(gen.proliferate) { (xs: [T]) in
        let expected = xs.map { n in mutually_recursive(n) }
        let actual = map(xs) { n in mutually_recursive(n) }
        return try? #require( expected ~~~ actual )
      }
}

private func prop_mutually_recursive_noinline<T: RandomType & Similar & BinaryInteger>(_ proxy: T.Type) {
    @inline(never)
    func odd(_ n: T) -> T {
        guard n != 1 else {
            return n
        }
        return n + even(n - 1)
    }
    @inline(never)
    func even(_ n: T) -> T {
        guard n != 0 else {
            return n
        }
        return n * odd(n - 1)
    }
    @inline(never)
    func mutually_recursive_noinline(_ n: T) -> T {
        guard n > 1 else {
            return n
        }
        return if n % 2 == 0 {
            n * odd(n - 1)
        } else {
            n + even(n - 1)
        }
    }
    let gen = Gen<T>.choose((T.zero, 5))
    property("mutually_recursive_noinline(\(String(describing: T.self)))") <-
      forAllNoShrink(gen.proliferate) { (xs: [T]) in
        let expected = xs.map { n in mutually_recursive_noinline(n) }
        let actual = map(xs) { n in mutually_recursive_noinline(n) }
        return try? #require( expected ~~~ actual )
      }
}

private func prop_fibonacci_recursive<T: RandomType & Similar & BinaryInteger>(_ proxy: T.Type) {
    func fibonacci(_ n: T) -> T {
        guard n > 1 else { return n }
        return fibonacci(n - 1) + fibonacci(n - 2)
    }
    let gen = Gen<T>.choose((T.zero, 11)) // fibonacci(11) fits in Int8
    property("fibonacci_recursive(\(String(describing: T.self)))") <-
      forAllNoShrink(gen.proliferate) { (xs: [T]) in
        let expected = xs.map(fibonacci)
        let actual = map(xs, fibonacci)
        return try? #require( expected ~~~ actual )
      }
}

private func prop_fibonacci_recursive_noinline<T: RandomType & Similar & BinaryInteger>(_ proxy: T.Type) {
    @inline(never)
    func fibonacci(_ n: T) -> T {
        guard n > 1 else { return n }
        return fibonacci(n - 1) + fibonacci(n - 2)
    }
    let gen = Gen<T>.choose((T.zero, 11)) // fibonacci(11) fits in Int8
    property("fibonacci_recursive_noinline(\(String(describing: T.self)))") <-
      forAllNoShrink(gen.proliferate) { (xs: [T]) in
        let expected = xs.map(fibonacci)
        let actual = map(xs, fibonacci)
        return try? #require( expected ~~~ actual )
      }
}
