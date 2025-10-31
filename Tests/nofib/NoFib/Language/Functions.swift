// Copyright (c) 2025 PassiveLogic, Inc.

import SwiftCheck
import SwiftToPTX
import Testing

// swiftlint:disable file_length type_body_length
// swiftformat:disable wrap wrapArguments wrapSingleLineComments trailingCommas

@Suite("function calls") struct FunctionCallsSuite {
    // Does calling functions inside a kernel work? The codegen is affected by the function signature,
    // i.e. the type, layout and position of each argument, and `inout`, `borrowing`, `consuming` etc.
    // We would like to vary the function signature to explore this space.
    @Suite struct SimpleFunctionCallTests {
        // unary functions
        @Test("unary.Int") func test_unary_1() { prop_unary(Int.self) }
        @Test("unary.Int16") func test_unary_2() { prop_unary(Int16.self) }
        @Test("unary.Int32") func test_unary_3() { prop_unary(Int32.self) }
        @Test("unary.Int64") func test_unary_4() { prop_unary(Int64.self) }
        @Test("unary.UInt") func test_unary_5() { prop_unary(UInt.self) }
        @Test("unary.UInt16") func test_unary_6() { prop_unary(UInt16.self) }
        @Test("unary.UInt32") func test_unary_7() { prop_unary(UInt32.self) }
        @Test("unary.UInt64") func test_unary_8() { prop_unary(UInt64.self) }
        @Test("unary.UInt64") func test_unary_9() { prop_unary(Float32.self) }
        @Test("unary.UInt64") func test_unary_10() { prop_unary(Float64.self) }

        @Test("unary_noinline.Int") func test_unary_noinline_1() { prop_unary_noinline(Int.self) }
        @Test("unary_noinline.Int16") func test_unary_noinline_2() { prop_unary_noinline(Int16.self) }
        @Test("unary_noinline.Int32") func test_unary_noinline_3() { prop_unary_noinline(Int32.self) }
        @Test("unary_noinline.Int64") func test_unary_noinline_4() { prop_unary_noinline(Int64.self) }
        @Test("unary_noinline.UInt") func test_unary_noinline_5() { prop_unary_noinline(UInt.self) }
        @Test("unary_noinline.UInt16") func test_unary_noinline_6() { prop_unary_noinline(UInt16.self) }
        @Test("unary_noinline.UInt32") func test_unary_noinline_7() { prop_unary_noinline(UInt32.self) }
        @Test("unary_noinline.UInt64") func test_unary_noinline_8() { prop_unary_noinline(UInt64.self) }

        // binary functions
        // T1 = Int
        @Test("binary.Int,Int") func test_binary_i_1() { prop_binary(Int.self, Int.self) }
        @Test("binary.Int,Int8") func test_binary_i_2() { prop_binary(Int.self, Int8.self) }
        @Test("binary.Int,Int16") func test_binary_i_3() { prop_binary(Int.self, Int16.self) }
        @Test("binary.Int,Int32") func test_binary_i_4() { prop_binary(Int.self, Int32.self) }
        @Test("binary.Int,Int64") func test_binary_i_5() { prop_binary(Int.self, Int64.self) }
        @Test("binary.Int,UInt") func test_binary_i_6() { prop_binary(Int.self, UInt.self) }
        @Test("binary.Int,UInt8") func test_binary_i_7() { prop_binary(Int.self, UInt8.self) }
        @Test("binary.Int,UInt16") func test_binary_i_8() { prop_binary(Int.self, UInt16.self) }
        @Test("binary.Int,UInt32") func test_binary_i_9() { prop_binary(Int.self, UInt32.self) }
        @Test("binary.Int,UInt64") func test_binary_i_10() { prop_binary(Int.self, UInt64.self) }

        // T1 = UInt
        @Test("binary.UInt,Int") func test_binary_u_1() { prop_binary(UInt.self, Int.self) }
        @Test("binary.UInt,Int8") func test_binary_u_2() { prop_binary(UInt.self, Int8.self) }
        @Test("binary.UInt,Int16") func test_binary_u_3() { prop_binary(UInt.self, Int16.self) }
        @Test("binary.UInt,Int32") func test_binary_u_4() { prop_binary(UInt.self, Int32.self) }
        @Test("binary.UInt,Int64") func test_binary_u_5() { prop_binary(UInt.self, Int64.self) }
        @Test("binary.UInt,UInt") func test_binary_u_6() { prop_binary(UInt.self, UInt.self) }
        @Test("binary.UInt,UInt8") func test_binary_u_7() { prop_binary(UInt.self, UInt8.self) }
        @Test("binary.UInt,UInt16") func test_binary_u_8() { prop_binary(UInt.self, UInt16.self) }
        @Test("binary.UInt,UInt32") func test_binary_u_9() { prop_binary(UInt.self, UInt32.self) }
        @Test("binary.UInt,UInt64") func test_binary_u_10() { prop_binary(UInt.self, UInt64.self) }

        // T1 = Float64
        @Test("binary.Float64,Float32") func test_binary_f64_1() { prop_binary(Float64.self, Float32.self) }
        @Test("binary.Float64,Float64") func test_binary_f64_2() { prop_binary(Float64.self, Float32.self) }

        // T1 = Int
        @Test("binary_noinline.Int,Int") func test_binary_noinline_i_1() { prop_binary_noinline(Int.self, Int.self) }
        @Test("binary_noinline.Int,Int8") func test_binary_noinline_i_2() { prop_binary_noinline(Int.self, Int8.self) }
        @Test("binary_noinline.Int,Int16") func test_binary_noinline_i_3() { prop_binary_noinline(Int.self, Int16.self) }
        @Test("binary_noinline.Int,Int32") func test_binary_noinline_i_4() { prop_binary_noinline(Int.self, Int32.self) }
        @Test("binary_noinline.Int,Int64") func test_binary_noinline_i_5() { prop_binary_noinline(Int.self, Int64.self) }
        @Test("binary_noinline.Int,UInt") func test_binary_noinline_i_6() { prop_binary_noinline(Int.self, UInt.self) }
        @Test("binary_noinline.Int,UInt8") func test_binary_noinline_i_7() { prop_binary_noinline(Int.self, UInt8.self) }
        @Test("binary_noinline.Int,UInt16") func test_binary_noinline_i_8() { prop_binary_noinline(Int.self, UInt16.self) }
        @Test("binary_noinline.Int,UInt32") func test_binary_noinline_i_9() { prop_binary_noinline(Int.self, UInt32.self) }
        @Test("binary_noinline.Int,UInt64") func test_binary_noinline_i_10() { prop_binary_noinline(Int.self, UInt64.self) }

        // T1 = UInt
        @Test("binary_noinline.UInt,Int") func test_binary_noinline_u_1() { prop_binary_noinline(UInt.self, Int.self) }
        @Test("binary_noinline.UInt,Int8") func test_binary_noinline_u_2() { prop_binary_noinline(UInt.self, Int8.self) }
        @Test("binary_noinline.UInt,Int16") func test_binary_noinline_u_3() { prop_binary_noinline(UInt.self, Int16.self) }
        @Test("binary_noinline.UInt,Int32") func test_binary_noinline_u_4() { prop_binary_noinline(UInt.self, Int32.self) }
        @Test("binary_noinline.UInt,Int64") func test_binary_noinline_u_5() { prop_binary_noinline(UInt.self, Int64.self) }
        @Test("binary_noinline.UInt,UInt") func test_binary_noinline_u_6() { prop_binary_noinline(UInt.self, UInt.self) }
        @Test("binary_noinline.UInt,UInt8") func test_binary_noinline_u_7() { prop_binary_noinline(UInt.self, UInt8.self) }
        @Test("binary_noinline.UInt,UInt16") func test_binary_noinline_u_8() { prop_binary_noinline(UInt.self, UInt16.self) }
        @Test("binary_noinline.UInt,UInt32") func test_binary_noinline_u_9() { prop_binary_noinline(UInt.self, UInt32.self) }
        @Test("binary_noinline.UInt,UInt64") func test_binary_noinline_u_10() { prop_binary_noinline(UInt.self, UInt64.self) }
    }

    @Suite struct RecursiveFunctionCallTests {
        @Test("factorial_recursive.Int") func test_factorial_recursive() { prop_factorial_recursive(Int.self) }
        @Test("factorial_recursive_noinline.Int") func test_factorial_recursive_noinline() { prop_factorial_recursive_noinline(Int.self) }
        @Test("factorial_tailcall.Int") func test_factorial_tailcall() { prop_factorial_tailcall(Int.self) }
        @Test("factorial_tailcall_noinline.Int") func test_factorial_tailcall_noinline() { prop_factorial_tailcall_noinline(Int.self) }

        @Test("fibonacci_recursive.Int") func test_fibonacci_recursive() { prop_fibonacci_recursive(Int.self) }
        @Test("fibonacci_recursive_noinline.Int") func test_fibonacci_recursive_noinline() { prop_fibonacci_recursive_noinline(Int.self) }

        @Test("mutually_recursive.Int") func test_mutually_recursive() { prop_mutually_recursive(Int.self) }
        @Test("mutually_recursive_noinline.Int") func test_mutually_recursive_noinline() { prop_mutually_recursive_noinline(Int.self) }
    }

    // XXX: inout paratemeters seem completely broken
    @Suite struct InoutParameterTests {
        // @Test("unary_inout.Int", .bug(id: "86b6ycdvn")) func test_unary_inout() { prop_unary_inout(Int.self) }
        // @Test("binary_inout.Int", .bug(id: "86b6ycdvn")) func test_binary_inout() { prop_binary_inout(Int.self) }
        // @Test("unary_inout.Int8", .bug(id: "86b6ycdvn")) func test_unary_inout() { prop_unary_inout(Int8.self) }
        // @Test("binary_inout.Int8", .bug(id: "86b6ycdvn")) func test_binary_inout() { prop_binary_inout(Int8.self) }
        // @Test("unary_inout.Int32", .bug(id: "86b6ycdvn")) func test_unary_inout() { prop_unary_inout(Int32.self) }
        // @Test("binary_inout.Int32", .bug(id: "86b6ycdvn")) func test_binary_inout() { prop_binary_inout(Int32.self) }
    }
}

// MARK: simple function calls

private func prop_unary<T: Arbitrary & Similar>(_: T.Type) {
    func unary(_ x: T) -> T { x }
    property("unary." + String(describing: T.self)) <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map(unary)
        let actual = map(xs, unary)
        return try? #require(expected ~~~ actual)
      }
}

private func prop_binary<T1: Arbitrary & FixedWidthInteger, T2: Arbitrary & FixedWidthInteger>(_: T1.Type, _: T2.Type) {
    // function that does not boil down to a primitive
    func binary(_ x1: T1, _ x2: T2) -> Int {
        (x1.nonzeroBitCount & x2.nonzeroBitCount) >> 1
    }
    property("binary." + String(describing: (T1, T2).self)) <-
      forAllNoShrink([T1].arbitrary, [T2].arbitrary) { (xs: [T1], ys: [T2]) in
        let expected = zip(xs, ys).map { x, y in binary(x, y) }
        let actual = zipWith(xs, ys, binary)
        return try? #require(expected == actual)
      }
}

private func prop_binary<T1: Arbitrary & Similar & BinaryFloatingPoint, T2: Arbitrary & Similar & BinaryFloatingPoint>(_: T1.Type, _: T2.Type) {
    // function that does not boil down to a primitive
    func binary(_ x1: T1, _ x2: T2) -> Float64 {
        let d1 = Float64(x1), d2 = Float64(x2)
        return d1 + d2 * (d1 * d2)
    }
    property("binary." + String(describing: (T1, T2).self)) <-
      forAllNoShrink([T1].arbitrary, [T2].arbitrary) { (xs: [T1], ys: [T2]) in
        let expected = zip(xs, ys).map { x, y in binary(x, y) }
        let actual = zipWith(xs, ys, binary)
        return try? #require(expected ~~~ actual)
      }
}

// TODO: tests for multi-arity functions with heterogeneous types, i.e.
// (T1, T2, T3) -> T, where T1 != T2 != T3 != T1 in general

private func prop_ternary<T: Arbitrary & Similar & Comparable>(_: T.Type) {
    func ternary(_ x1: T, _ x2: T, _ x3: T) -> T { min(max(x1, x2), x3) }

    property("ternary." + String(describing: T.self)) <-
      forAllNoShrink([T].arbitrary, [T].arbitrary, [T].arbitrary) { (xs: [T], ys: [T], zs: [T]) in
        let size = min(min(xs.count, ys.count), zs.count)
        let expected = (0 ..< size).map { i in ternary(xs[i], ys[i], zs[i]) }
        let actual = generate(count: size) { i in ternary(xs[i], ys[i], zs[i]) }
        return try? #require(expected ~~~ actual)
      }
}

private func prop_unary_noinline<T: Arbitrary & Similar & Numeric>(_: T.Type) {
    @inline(never)
    func unary(_ x: T) -> T { x }
    property("unary_noinline." + String(describing: T.self)) <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map(unary)
        let actual = map(xs, unary)
        return try? #require(expected ~~~ actual)
      }
}

private func prop_binary_noinline<T1: Arbitrary & FixedWidthInteger, T2: Arbitrary & FixedWidthInteger>(_: T1.Type, _: T2.Type) {
    @inline(never)
    func binary(_ x1: T1, _ x2: T2) -> Int {
        (x1.nonzeroBitCount & x2.nonzeroBitCount) >> 1
    }
    property("binary." + String(describing: (T1, T2).self)) <-
      forAllNoShrink([T1].arbitrary, [T2].arbitrary) { (xs: [T1], ys: [T2]) in
        let expected = zip(xs, ys).map { x, y in binary(x, y) }
        let actual = zipWith(xs, ys, binary)
        return try? #require(expected ~~~ actual)
      }
}

private func prop_binary_noinline<T1: Arbitrary & Similar & BinaryFloatingPoint, T2: Arbitrary & Similar & BinaryFloatingPoint>(_: T1.Type, _: T2.Type) {
    @inline(never)
    func binary(_ x1: T1, _ x2: T2) -> Float64 {
        let d1 = Float64(x1), d2 = Float64(x2)
        return d1 + d2 * (d1 * d2)
    }
    property("binary." + String(describing: (T1, T2).self)) <-
      forAllNoShrink([T1].arbitrary, [T2].arbitrary) { (xs: [T1], ys: [T2]) in
        let expected = zip(xs, ys).map { x, y in binary(x, y) }
        let actual = zipWith(xs, ys, binary)
        return try? #require(expected ~~~ actual)
      }
}

private func prop_ternary_noinline<T: Arbitrary & Similar & Comparable>(_: T.Type) {
    @inline(never)
    func ternary(_ x1: T, _ x2: T, _ x3: T) -> T { min(max(x1, x2), x3) }
    property("ternary_noinline." + String(describing: T.self)) <-
      forAllNoShrink([T].arbitrary, [T].arbitrary, [T].arbitrary) { (xs: [T], ys: [T], zs: [T]) in
        let size = min(min(xs.count, ys.count), zs.count)
        let expected = (0 ..< size).map { i in ternary(xs[i], ys[i], zs[i]) }
        let actual = generate(count: size) { i in ternary(xs[i], ys[i], zs[i]) }
        return try? #require(expected ~~~ actual)
      }
}

private func prop_unary_inout<T: Arbitrary & Similar & ExpressibleByIntegerLiteral>(_: T.Type) {
    func unary_inout(_ x: inout T) {
        x = 0
    }
    property("unary_inout." + String(describing: T.self)) <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected: [T] = fill(count: xs.count, with: 0)
        var actual = xs
        // NOTE: `parallel_for` required here because of in-place mutation,
        // i.e. modify accessor instead of subscript set
        parallel_for(iterations: xs.count) { i in
            unary_inout(&actual[i])
        }.sync()
        return try? #require(expected ~~~ actual)
      }
}

private func prop_binary_inout<T: Arbitrary & Similar & ExpressibleByIntegerLiteral>(_: T.Type) {
    func binary_inout(_ x: inout T, _ y: T) {
        x = y
    }
    property("binary_inout." + String(describing: T.self)) <-
      forAllNoShrink([T].arbitrary, T.arbitrary) { (xs: [T], y: T) in
        let expected = fill(count: xs.count, with: y)
        var actual = xs
        // NOTE: `parallel_for` required here because of in-place mutation,
        // i.e. modify accessor instead of subscript set
        parallel_for(iterations: actual.count) { i in
            binary_inout(&actual[i], y)
        }.sync()
        return try? #require(expected ~~~ actual)
      }
}

// MARK: recursive functions

private func prop_factorial_recursive<T: RandomType & Similar & BinaryInteger>(_: T.Type) {
    func factorial(_ n: T) -> T {
        guard n > 1 else { return 1 }
        return n * factorial(n - 1)
    }
    let gen = Gen<T>.choose((T.zero, 5)) // 5! fits in Int8, 6! does not
    property("factorial_recursive." + String(describing: T.self)) <-
      forAllNoShrink(gen.proliferate) { (xs: [T]) in
        let expected = xs.map(factorial)
        let actual = map(xs, factorial)
        return try? #require(expected ~~~ actual)
      }
}

private func prop_factorial_tailcall<T: RandomType & Similar & BinaryInteger>(_: T.Type) {
    func factorial(_ n: T, _ acc: T = 0) -> T {
        guard n > 1 else { return acc }
        return factorial(n - 1, n * acc)
    }
    let gen = Gen<T>.choose((T.zero, 5)) // 5! fits in Int8, 6! does not
    property("factorial_tailcall." + String(describing: T.self)) <-
      forAllNoShrink(gen.proliferate) { (xs: [T]) in
        let expected = xs.map { n in factorial(n) }
        let actual = map(xs) { n in factorial(n) }
        return try? #require(expected ~~~ actual)
      }
}

private func prop_factorial_recursive_noinline<T: RandomType & Similar & BinaryInteger>(_: T.Type) {
    @inline(never)
    func factorial(_ n: T) -> T {
        guard n > 1 else { return 1 }
        return n * factorial(n - 1)
    }
    let gen = Gen<T>.choose((T.zero, 5)) // 5! fits in Int8, 6! does not
    property("factorial_recursive_noinline." + String(describing: T.self)) <-
      forAllNoShrink(gen.proliferate) { (xs: [T]) in
        let expected = xs.map(factorial)
        let actual = map(xs, factorial)
        return try? #require(expected ~~~ actual)
      }
}

private func prop_factorial_tailcall_noinline<T: RandomType & Similar & BinaryInteger>(_: T.Type) {
    @inline(never)
    func factorial(_ n: T, _ acc: T = 0) -> T {
        guard n > 1 else { return acc }
        return factorial(n - 1, n * acc)
    }
    let gen = Gen<T>.choose((T.zero, 5)) // 5! fits in Int8, 6! does not
    property("factorial_tailcall_noinline." + String(describing: T.self)) <-
      forAllNoShrink(gen.proliferate) { (xs: [T]) in
        let expected = xs.map { n in factorial(n) }
        let actual = map(xs) { n in factorial(n) }
        return try? #require(expected ~~~ actual)
      }
}

private func prop_mutually_recursive<T: RandomType & Similar & BinaryInteger>(_: T.Type) {
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
        }
        else {
            n + even(n - 1)
        }
    }
    let gen = Gen<T>.choose((T.zero, 5))
    property("mutually_recursive." + String(describing: T.self)) <-
      forAllNoShrink(gen.proliferate) { (xs: [T]) in
        let expected = xs.map { n in mutually_recursive(n) }
        let actual = map(xs) { n in mutually_recursive(n) }
        return try? #require(expected ~~~ actual)
      }
}

private func prop_mutually_recursive_noinline<T: RandomType & Similar & BinaryInteger>(_: T.Type) {
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
        }
        else {
            n + even(n - 1)
        }
    }
    let gen = Gen<T>.choose((T.zero, 5))
    property("mutually_recursive_noinline." + String(describing: T.self)) <-
      forAllNoShrink(gen.proliferate) { (xs: [T]) in
        let expected = xs.map { n in mutually_recursive_noinline(n) }
        let actual = map(xs) { n in mutually_recursive_noinline(n) }
        return try? #require(expected ~~~ actual)
      }
}

private func prop_fibonacci_recursive<T: RandomType & Similar & BinaryInteger>(_: T.Type) {
    func fibonacci(_ n: T) -> T {
        guard n > 1 else { return n }
        return fibonacci(n - 1) + fibonacci(n - 2)
    }
    let gen = Gen<T>.choose((T.zero, 11)) // fibonacci(11) fits in Int8
    property("fibonacci_recursive." + String(describing: T.self)) <-
      forAllNoShrink(gen.proliferate) { (xs: [T]) in
        let expected = xs.map(fibonacci)
        let actual = map(xs, fibonacci)
        return try? #require(expected ~~~ actual)
      }
}

private func prop_fibonacci_recursive_noinline<T: RandomType & Similar & BinaryInteger>(_: T.Type) {
    @inline(never)
    func fibonacci(_ n: T) -> T {
        guard n > 1 else { return n }
        return fibonacci(n - 1) + fibonacci(n - 2)
    }
    let gen = Gen<T>.choose((T.zero, 11)) // fibonacci(11) fits in Int8
    property("fibonacci_recursive_noinline." + String(describing: T.self)) <-
      forAllNoShrink(gen.proliferate) { (xs: [T]) in
        let expected = xs.map(fibonacci)
        let actual = map(xs, fibonacci)
        return try? #require(expected ~~~ actual)
      }
}
