// Copyright (c) 2025 PassiveLogic, Inc.

import SwiftCheck
import SwiftToGPU
import Testing

// Does calling functions inside a kernel work? The codegen is affected by the
// function signature, i.e. the type, layout and position of each argument, and
// `inout`, `borrowing`, `consuming` etc. We would like to vary the function
// signature to explore this space.
//
@Suite("Functions") struct FunctionTests {
    @Suite struct SimpleFunctionCallTests {
        @Suite("Int") struct IntTests {
            @Test func id() { idTest(Int.self) }
            @Test func idNoinline() { idNoinlineTest(Int.self) }

            @Suite("Int") struct IntTests {
                @Test func binary() { binaryTest(Int.self, Int.self) }
                @Test func binaryNoinline() { binaryNoInlineTest(Int.self, Int.self) }
            }

            @Suite("Int8") struct Int8Tests {
                @Test func binary() { binaryTest(Int.self, Int8.self) }
                @Test func binaryNoinline() { binaryNoInlineTest(Int.self, Int8.self) }
            }

            @Suite("Int16") struct Int16Tests {
                @Test func binary() { binaryTest(Int.self, Int16.self) }
                @Test func binaryNoinline() { binaryNoInlineTest(Int.self, Int16.self) }
            }

            @Suite("Int32") struct Int32Tests {
                @Test func binary() { binaryTest(Int.self, Int32.self) }
                @Test func binaryNoinline() { binaryNoInlineTest(Int.self, Int32.self) }
            }

            @Suite("Int64") struct Int64Tests {
                @Test func binary() { binaryTest(Int.self, Int64.self) }
                @Test func binaryNoinline() { binaryNoInlineTest(Int.self, Int64.self) }
            }

            @Suite("UInt") struct UIntTests {
                @Test func binary() { binaryTest(Int.self, UInt.self) }
                @Test func binaryNoinline() { binaryNoInlineTest(Int.self, UInt.self) }
            }

            @Suite("UInt8") struct UInt8Tests {
                @Test func binary() { binaryTest(Int.self, UInt8.self) }
                @Test func binaryNoinline() { binaryNoInlineTest(Int.self, UInt8.self) }
            }

            @Suite("UInt16") struct UInt16Tests {
                @Test func binary() { binaryTest(Int.self, UInt16.self) }
                @Test func binaryNoinline() { binaryNoInlineTest(Int.self, UInt16.self) }
            }

            @Suite("UInt32") struct UInt32Tests {
                @Test func binary() { binaryTest(Int.self, UInt32.self) }
                @Test func binaryNoinline() { binaryNoInlineTest(Int.self, UInt32.self) }
            }

            @Suite("UInt64") struct UInt64Tests {
                @Test func binary() { binaryTest(Int.self, UInt64.self) }
                @Test func binaryNoinline() { binaryNoInlineTest(Int.self, UInt64.self) }
            }
        }

        @Suite("UInt") struct UIntTests {
            @Test func id() { idTest(UInt.self) }
            @Test func idNoinline() { idNoinlineTest(UInt.self) }

            @Suite("Int") struct IntTests {
                @Test func binary() { binaryTest(UInt.self, Int.self) }
                @Test func binaryNoinline() { binaryNoInlineTest(UInt.self, Int.self) }
            }

            @Suite("Int8") struct Int8Tests {
                @Test func binary() { binaryTest(UInt.self, Int8.self) }
                @Test func binaryNoinline() { binaryNoInlineTest(UInt.self, Int8.self) }
            }

            @Suite("Int16") struct Int16Tests {
                @Test func binary() { binaryTest(UInt.self, Int16.self) }
                @Test func binaryNoinline() { binaryNoInlineTest(UInt.self, Int16.self) }
            }

            @Suite("Int32") struct Int32Tests {
                @Test func binary() { binaryTest(UInt.self, Int32.self) }
                @Test func binaryNoinline() { binaryNoInlineTest(UInt.self, Int32.self) }
            }

            @Suite("Int64") struct Int64Tests {
                @Test func binary() { binaryTest(UInt.self, Int64.self) }
                @Test func binaryNoinline() { binaryNoInlineTest(UInt.self, Int64.self) }
            }

            @Suite("UInt") struct UIntTests {
                @Test func binary() { binaryTest(UInt.self, UInt.self) }
                @Test func binaryNoinline() { binaryNoInlineTest(UInt.self, UInt.self) }
            }

            @Suite("UInt8") struct UInt8Tests {
                @Test func binary() { binaryTest(UInt.self, UInt8.self) }
                @Test func binaryNoinline() { binaryNoInlineTest(UInt.self, UInt8.self) }
            }

            @Suite("UInt16") struct UInt16Tests {
                @Test func binary() { binaryTest(UInt.self, UInt16.self) }
                @Test func binaryNoinline() { binaryNoInlineTest(UInt.self, UInt16.self) }
            }

            @Suite("UInt32") struct UInt32Tests {
                @Test func binary() { binaryTest(UInt.self, UInt32.self) }
                @Test func binaryNoinline() { binaryNoInlineTest(UInt.self, UInt32.self) }
            }

            @Suite("UInt64") struct UInt64Tests {
                @Test func binary() { binaryTest(UInt.self, UInt64.self) }
                @Test func binaryNoinline() { binaryNoInlineTest(UInt.self, UInt64.self) }
            }
        }

        @Suite("Float32") struct Float32Tests {
            @Test func id() { idTest(Float32.self) }
            @Test func idNoinline() { idNoinlineTest(Float32.self) }

#if arch(arm64)
            @Suite("Float16") struct Float16Tests {
                @Test func binary() { binaryTest(Float32.self, Float16.self) }
                @Test func binaryNoinline() { binaryNoInlineTest(Float32.self, Float16.self) }
            }
#endif

            @Suite("Float32") struct Float32Tests {
                @Test func binary() { binaryTest(Float32.self, Float32.self) }
                @Test func binaryNoinline() { binaryNoInlineTest(Float32.self, Float32.self) }
            }

            @Suite("Float64") struct Float64Tests {
                @Test func binary() { binaryTest(Float32.self, Float64.self) }
                @Test func binaryNoinline() { binaryNoInlineTest(Float32.self, Float64.self) }
            }
        }
    }

    @Suite struct RecursiveFunctionCallTests {
        @Suite struct FactorialTests {
            @Test func factorialTailcall() { factorialTailcallTest(Int.self) }
            @Test func factorialRecursive() { factorialRecursiveTest(Int.self) }
            @Test func factorialTailcallNoinline() { factorialTailcallNoinlineTest(Int.self) }
            @Test func factorialRecursiveNoinline() { factorialRecursiveNoinlineTest(Int.self) }
        }

        @Suite struct FibonacciTests {
            @Test func fibonacciRecursive() { fibonacciRecursiveTest(Int.self) }
            @Test func fibonacciRecursiveNoinline() { fibonacciRecursiveNoinlineTest(Int.self) }
        }

        @Suite struct MutuallyRecursiveTests {
            @Test func mutuallyRecursive() { mutuallyRecursiveTest(Int.self) }
            @Test func mutuallyRecursiveNoinline() { mutuallyRecursiveNoinlineTest(Int.self) }
        }
    }

    // XXX: inout paratemeters seem completely broken
    @Suite struct InoutParameterTests {
        @Suite("Int") struct IntTests {
            // @Test(.bug(id: "86b6ycdvn")) func inout1() { inoutTest1(Int.self) }
            // @Test(.bug(id: "86b6ycdvn")) func inout2() { inoutTest2(Int.self) }
        }
    }
}

// MARK: simple function calls

private func idTest<T: Arbitrary & Equatable>(_: T.Type) {
    func id(_ x: T) -> T { x }
    property(#function) <-
      forAllNoShrink([T].arbitrary) { xs in
        let expected = xs.map(id)
        let actual = map(xs, id)
        return try? #require(expected == actual)
      }
}

private func binaryTest<A: Arbitrary & FixedWidthInteger, B: Arbitrary & FixedWidthInteger>(_: A.Type, _: B.Type) {
    // function that does not boil down to a primitive
    func binary(_ x1: A, _ x2: B) -> Int {
        (x1.nonzeroBitCount & x2.nonzeroBitCount) >> 1
    }
    property(#function) <-
      forAllNoShrink([A].arbitrary, [B].arbitrary) { xs, ys in
        let expected = zip(xs, ys).map { x, y in binary(x, y) }
        let actual = zipWith(xs, ys, binary)
        return try? #require(expected == actual)
      }
}

private func binaryTest<A: Arbitrary & Similar & BinaryFloatingPoint, B: Arbitrary & Similar & BinaryFloatingPoint>(_: A.Type, _: B.Type) {
    // function that does not boil down to a primitive
    func binary(_ x1: A, _ x2: B) -> Float64 {
        let d1 = Float64(x1), d2 = Float64(x2)
        return d1 + d2 * (d1 * d2)
    }
    property(#function) <-
      forAllNoShrink([A].arbitrary, [B].arbitrary) { xs, ys in
        let expected = zip(xs, ys).map { x, y in binary(x, y) }
        let actual = zipWith(xs, ys, binary)
        return try? #require(expected ~~~ actual)
      }
}

private func idNoinlineTest<T: Arbitrary & Equatable>(_: T.Type) {
    @inline(never)
    func id(_ x: T) -> T { x }
    property(#function) <-
      forAllNoShrink([T].arbitrary) { xs in
        let expected = xs.map(id)
        let actual = map(xs, id)
        return try? #require(expected == actual)
      }
}

private func binaryNoInlineTest<A: Arbitrary & FixedWidthInteger, B: Arbitrary & FixedWidthInteger>(_: A.Type, _: B.Type) {
    @inline(never)
    func binary(_ x1: A, _ x2: B) -> Int {
        (x1.nonzeroBitCount & x2.nonzeroBitCount) >> 1
    }
    property(#function) <-
      forAllNoShrink([A].arbitrary, [B].arbitrary) { xs, ys in
        let expected = zip(xs, ys).map { x, y in binary(x, y) }
        let actual = zipWith(xs, ys, binary)
        return try? #require(expected ~~~ actual)
      }
}

private func binaryNoInlineTest<A: Arbitrary & Similar & BinaryFloatingPoint, B: Arbitrary & Similar & BinaryFloatingPoint>(
    _: A.Type,
    _: B.Type
) {
    @inline(never)
    func binary(_ x1: A, _ x2: B) -> Float64 {
        let d1 = Float64(x1), d2 = Float64(x2)
        return d1 + d2 * (d1 * d2)
    }
    property(#function) <-
      forAllNoShrink([A].arbitrary, [B].arbitrary) { xs, ys in
        let expected = zip(xs, ys).map { x, y in binary(x, y) }
        let actual = zipWith(xs, ys, binary)
        return try? #require(expected ~~~ actual)
      }
}

private func inoutTest1<T: Arbitrary & Similar & ExpressibleByIntegerLiteral>(_: T.Type) {
    func unary_inout(_ x: inout T) {
        x = 0
    }
    property(#function) <-
      forAllNoShrink([T].arbitrary) { xs in
        let expected: [T] = fill(count: xs.count, with: 0)
        var actual = xs
        // NOTE: `parallel_for` required here because of in-place mutation,
        // i.e. modify accessor instead of subscript set
        try parallel_for(iterations: xs.count) { i in
            unary_inout(&actual[i])
        }.sync()
        return try? #require(expected ~~~ actual)
      }
}

private func inoutTest2<T: Arbitrary & Similar & ExpressibleByIntegerLiteral>(_: T.Type) {
    func binary_inout(_ x: inout T, _ y: T) {
        x = y
    }
    property(#function) <-
      forAllNoShrink([T].arbitrary, T.arbitrary) { xs, y in
        let expected = fill(count: xs.count, with: y)
        var actual = xs
        // NOTE: `parallel_for` required here because of in-place mutation,
        // i.e. modify accessor instead of subscript set
        try parallel_for(iterations: actual.count) { i in
            binary_inout(&actual[i], y)
        }.sync()
        return try? #require(expected ~~~ actual)
      }
}

// MARK: recursive functions

private func factorialRecursiveTest<T: RandomType & Similar & BinaryInteger>(_: T.Type) {
    func factorial(_ n: T) -> T {
        guard n > 1 else { return 1 }
        return n * factorial(n - 1)
    }
    let gen = Gen<T>.choose((T.zero, 5)) // 5! fits in Int8, 6! does not
    property(#function) <-
      forAllNoShrink(gen.proliferate) { xs in
        let expected = xs.map(factorial)
        let actual = map(xs, factorial)
        return try? #require(expected ~~~ actual)
      }
}

private func factorialTailcallTest<T: RandomType & Similar & BinaryInteger>(_: T.Type) {
    func factorial(_ n: T, _ acc: T = 0) -> T {
        guard n > 1 else { return acc }
        return factorial(n - 1, n * acc)
    }
    let gen = Gen<T>.choose((T.zero, 5)) // 5! fits in Int8, 6! does not
    property(#function) <-
      forAllNoShrink(gen.proliferate) { xs in
        let expected = xs.map { n in factorial(n) }
        let actual = map(xs) { n in factorial(n) }
        return try? #require(expected ~~~ actual)
      }
}

private func factorialRecursiveNoinlineTest<T: RandomType & Similar & BinaryInteger>(_: T.Type) {
    @inline(never)
    func factorial(_ n: T) -> T {
        guard n > 1 else { return 1 }
        return n * factorial(n - 1)
    }
    let gen = Gen<T>.choose((T.zero, 5)) // 5! fits in Int8, 6! does not
    property(#function) <-
      forAllNoShrink(gen.proliferate) { xs in
        let expected = xs.map(factorial)
        let actual = map(xs, factorial)
        return try? #require(expected ~~~ actual)
      }
}

private func factorialTailcallNoinlineTest<T: RandomType & Similar & BinaryInteger>(_: T.Type) {
    @inline(never)
    func factorial(_ n: T, _ acc: T = 0) -> T {
        guard n > 1 else { return acc }
        return factorial(n - 1, n * acc)
    }
    let gen = Gen<T>.choose((T.zero, 5)) // 5! fits in Int8, 6! does not
    property(#function) <-
      forAllNoShrink(gen.proliferate) { xs in
        let expected = xs.map { n in factorial(n) }
        let actual = map(xs) { n in factorial(n) }
        return try? #require(expected ~~~ actual)
      }
}

private func mutuallyRecursiveTest<T: RandomType & Similar & BinaryInteger>(_: T.Type) {
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
    property(#function) <-
      forAllNoShrink(gen.proliferate) { xs in
        let expected = xs.map { n in mutually_recursive(n) }
        let actual = map(xs) { n in mutually_recursive(n) }
        return try? #require(expected ~~~ actual)
      }
}

private func mutuallyRecursiveNoinlineTest<T: RandomType & Similar & BinaryInteger>(_: T.Type) {
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
    property(#function) <-
      forAllNoShrink(gen.proliferate) { xs in
        let expected = xs.map { n in mutually_recursive_noinline(n) }
        let actual = map(xs) { n in mutually_recursive_noinline(n) }
        return try? #require(expected ~~~ actual)
      }
}

private func fibonacciRecursiveTest<T: RandomType & Similar & BinaryInteger>(_: T.Type) {
    func fibonacci(_ n: T) -> T {
        guard n > 1 else { return n }
        return fibonacci(n - 1) + fibonacci(n - 2)
    }
    let gen = Gen<T>.choose((T.zero, 11)) // fibonacci(11) fits in Int8
    property(#function) <-
      forAllNoShrink(gen.proliferate) { xs in
        let expected = xs.map(fibonacci)
        let actual = map(xs, fibonacci)
        return try? #require(expected ~~~ actual)
      }
}

private func fibonacciRecursiveNoinlineTest<T: RandomType & Similar & BinaryInteger>(_: T.Type) {
    @inline(never)
    func fibonacci(_ n: T) -> T {
        guard n > 1 else { return n }
        return fibonacci(n - 1) + fibonacci(n - 2)
    }
    let gen = Gen<T>.choose((T.zero, 11)) // fibonacci(11) fits in Int8
    property(#function) <-
      forAllNoShrink(gen.proliferate) { xs in
        let expected = xs.map(fibonacci)
        let actual = map(xs, fibonacci)
        return try? #require(expected ~~~ actual)
      }
}
