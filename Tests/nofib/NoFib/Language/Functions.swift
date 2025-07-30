import SwiftToPTX
import Testing
import Randy
import SwiftCheck

@Suite("function calls") struct FunctionCallsSuite {
    @Suite("Int") struct IntTests {
        @Test func test_unary() { prop_unary(Int.self) }
        @Test func test_binary() { prop_binary(Int.self) }
        @Test func test_ternary() { prop_ternary(Int.self) }
        @Test func test_unary_noinline() { prop_unary_noinline(Int.self) }
        @Test func test_binary_noinline() { prop_binary_noinline(Int.self) }
        @Test func test_ternary_noinline() { prop_ternary_noinline(Int.self) }
        @Test func test_factorial_recursive() { prop_factorial_recursive(Int.self) }
        @Test func test_factorial_tailcall() { prop_factorial_tailcall(Int.self) }
        @Test func test_factorial_recursive_noinline() { prop_factorial_recursive_noinline(Int.self) }
        @Test func test_factorial_tailcall_noinline() { prop_factorial_tailcall_noinline(Int.self) }
        @Test func test_mutually_recursive() { prop_mutually_recursive(Int.self) }
        @Test func test_mutually_recursive_noinline() { prop_mutually_recursive_noinline(Int.self) }
        @Test func test_fibonacci_recursive() { prop_fibonacci_recursive(Int.self) }
        @Test func test_fibonacci_recursive_noinline() { prop_fibonacci_recursive_noinline(Int.self) }
    }
    @Suite("Int8") struct Int8Tests {
        @Test func test_unary() { prop_unary(Int8.self) }
        @Test func test_binary() { prop_binary(Int8.self) }
        @Test func test_ternary() { prop_ternary(Int8.self) }
        @Test func test_unary_noinline() { prop_unary_noinline(Int8.self) }
        @Test func test_binary_noinline() { prop_binary_noinline(Int8.self) }
        @Test func test_ternary_noinline() { prop_ternary_noinline(Int8.self) }
        @Test func test_factorial_recursive() { prop_factorial_recursive(Int8.self) }
        @Test func test_factorial_tailcall() { prop_factorial_tailcall(Int8.self) }
        @Test func test_factorial_recursive_noinline() { prop_factorial_recursive_noinline(Int8.self) }
        @Test func test_factorial_tailcall_noinline() { prop_factorial_tailcall_noinline(Int8.self) }
        @Test func test_mutually_recursive() { prop_mutually_recursive(Int8.self) }
        @Test func test_mutually_recursive_noinline() { prop_mutually_recursive_noinline(Int8.self) }
        @Test func test_fibonacci_recursive() { prop_fibonacci_recursive(Int8.self) }
        @Test func test_fibonacci_recursive_noinline() { prop_fibonacci_recursive_noinline(Int8.self) }
    }
    @Suite("Int16") struct Int16Tests {
        @Test func test_unary() { prop_unary(Int16.self) }
        @Test func test_binary() { prop_binary(Int16.self) }
        @Test func test_ternary() { prop_ternary(Int16.self) }
        @Test func test_unary_noinline() { prop_unary_noinline(Int16.self) }
        @Test func test_binary_noinline() { prop_binary_noinline(Int16.self) }
        @Test func test_ternary_noinline() { prop_ternary_noinline(Int16.self) }
        @Test func test_factorial_recursive() { prop_factorial_recursive(Int16.self) }
        @Test func test_factorial_tailcall() { prop_factorial_tailcall(Int16.self) }
        @Test func test_factorial_recursive_noinline() { prop_factorial_recursive_noinline(Int16.self) }
        @Test func test_factorial_tailcall_noinline() { prop_factorial_tailcall_noinline(Int16.self) }
        @Test func test_mutually_recursive() { prop_mutually_recursive(Int16.self) }
        @Test func test_mutually_recursive_noinline() { prop_mutually_recursive_noinline(Int16.self) }
        @Test func test_fibonacci_recursive() { prop_fibonacci_recursive(Int16.self) }
        @Test func test_fibonacci_recursive_noinline() { prop_fibonacci_recursive_noinline(Int16.self) }
    }
    @Suite("Int32") struct Int32Tests {
        @Test func test_unary() { prop_unary(Int32.self) }
        @Test func test_binary() { prop_binary(Int32.self) }
        @Test func test_ternary() { prop_ternary(Int32.self) }
        @Test func test_unary_noinline() { prop_unary_noinline(Int32.self) }
        @Test func test_binary_noinline() { prop_binary_noinline(Int32.self) }
        @Test func test_ternary_noinline() { prop_ternary_noinline(Int32.self) }
        @Test func test_factorial_recursive() { prop_factorial_recursive(Int32.self) }
        @Test func test_factorial_tailcall() { prop_factorial_tailcall(Int32.self) }
        @Test func test_factorial_recursive_noinline() { prop_factorial_recursive_noinline(Int32.self) }
        @Test func test_factorial_tailcall_noinline() { prop_factorial_tailcall_noinline(Int32.self) }
        @Test func test_mutually_recursive() { prop_mutually_recursive(Int32.self) }
        @Test func test_mutually_recursive_noinline() { prop_mutually_recursive_noinline(Int32.self) }
        @Test func test_fibonacci_recursive() { prop_fibonacci_recursive(Int32.self) }
        @Test func test_fibonacci_recursive_noinline() { prop_fibonacci_recursive_noinline(Int32.self) }
    }
    @Suite("Int64") struct Int64Tests {
        @Test func test_unary() { prop_unary(Int64.self) }
        @Test func test_binary() { prop_binary(Int64.self) }
        @Test func test_ternary() { prop_ternary(Int64.self) }
        @Test func test_unary_noinline() { prop_unary_noinline(Int64.self) }
        @Test func test_binary_noinline() { prop_binary_noinline(Int64.self) }
        @Test func test_ternary_noinline() { prop_ternary_noinline(Int64.self) }
        @Test func test_factorial_recursive() { prop_factorial_recursive(Int64.self) }
        @Test func test_factorial_tailcall() { prop_factorial_tailcall(Int64.self) }
        @Test func test_factorial_recursive_noinline() { prop_factorial_recursive_noinline(Int64.self) }
        @Test func test_factorial_tailcall_noinline() { prop_factorial_tailcall_noinline(Int64.self) }
        @Test func test_mutually_recursive() { prop_mutually_recursive(Int64.self) }
        @Test func test_mutually_recursive_noinline() { prop_mutually_recursive_noinline(Int64.self) }
        @Test func test_fibonacci_recursive() { prop_fibonacci_recursive(Int64.self) }
        @Test func test_fibonacci_recursive_noinline() { prop_fibonacci_recursive_noinline(Int64.self) }
    }
    @Suite("UInt8") struct UInt8Tests {
        @Test func test_unary() { prop_unary(UInt8.self) }
        @Test func test_binary() { prop_binary(UInt8.self) }
        @Test func test_ternary() { prop_ternary(UInt8.self) }
        @Test func test_unary_noinline() { prop_unary_noinline(UInt8.self) }
        @Test func test_binary_noinline() { prop_binary_noinline(UInt8.self) }
        @Test func test_ternary_noinline() { prop_ternary_noinline(UInt8.self) }
        @Test func test_factorial_recursive() { prop_factorial_recursive(UInt8.self) }
        @Test func test_factorial_tailcall() { prop_factorial_tailcall(UInt8.self) }
        @Test func test_factorial_recursive_noinline() { prop_factorial_recursive_noinline(UInt8.self) }
        @Test func test_factorial_tailcall_noinline() { prop_factorial_tailcall_noinline(UInt8.self) }
        @Test func test_mutually_recursive() { prop_mutually_recursive(UInt8.self) }
        @Test func test_mutually_recursive_noinline() { prop_mutually_recursive_noinline(UInt8.self) }
        @Test func test_fibonacci_recursive() { prop_fibonacci_recursive(UInt8.self) }
        @Test func test_fibonacci_recursive_noinline() { prop_fibonacci_recursive_noinline(UInt8.self) }
    }
    @Suite("UInt16") struct UInt16Tests {
        @Test func test_unary() { prop_unary(UInt16.self) }
        @Test func test_binary() { prop_binary(UInt16.self) }
        @Test func test_ternary() { prop_ternary(UInt16.self) }
        @Test func test_unary_noinline() { prop_unary_noinline(UInt16.self) }
        @Test func test_binary_noinline() { prop_binary_noinline(UInt16.self) }
        @Test func test_ternary_noinline() { prop_ternary_noinline(UInt16.self) }
        @Test func test_factorial_recursive() { prop_factorial_recursive(UInt16.self) }
        @Test func test_factorial_tailcall() { prop_factorial_tailcall(UInt16.self) }
        @Test func test_factorial_recursive_noinline() { prop_factorial_recursive_noinline(UInt16.self) }
        @Test func test_factorial_tailcall_noinline() { prop_factorial_tailcall_noinline(UInt16.self) }
        @Test func test_mutually_recursive() { prop_mutually_recursive(UInt16.self) }
        @Test func test_mutually_recursive_noinline() { prop_mutually_recursive_noinline(UInt16.self) }
        @Test func test_fibonacci_recursive() { prop_fibonacci_recursive(UInt16.self) }
        @Test func test_fibonacci_recursive_noinline() { prop_fibonacci_recursive_noinline(UInt16.self) }
    }
    @Suite("UInt32") struct UInt32Tests {
        @Test func test_unary() { prop_unary(UInt32.self) }
        @Test func test_binary() { prop_binary(UInt32.self) }
        @Test func test_ternary() { prop_ternary(UInt32.self) }
        @Test func test_unary_noinline() { prop_unary_noinline(UInt32.self) }
        @Test func test_binary_noinline() { prop_binary_noinline(UInt32.self) }
        @Test func test_ternary_noinline() { prop_ternary_noinline(UInt32.self) }
        @Test func test_factorial_recursive() { prop_factorial_recursive(UInt32.self) }
        @Test func test_factorial_tailcall() { prop_factorial_tailcall(UInt32.self) }
        @Test func test_factorial_recursive_noinline() { prop_factorial_recursive_noinline(UInt32.self) }
        @Test func test_factorial_tailcall_noinline() { prop_factorial_tailcall_noinline(UInt32.self) }
        @Test func test_mutually_recursive() { prop_mutually_recursive(UInt32.self) }
        @Test func test_mutually_recursive_noinline() { prop_mutually_recursive_noinline(UInt32.self) }
        @Test func test_fibonacci_recursive() { prop_fibonacci_recursive(UInt32.self) }
        @Test func test_fibonacci_recursive_noinline() { prop_fibonacci_recursive_noinline(UInt32.self) }
    }
    @Suite("UInt64") struct UInt64Tests {
        @Test func test_unary() { prop_unary(UInt64.self) }
        @Test func test_binary() { prop_binary(UInt64.self) }
        @Test func test_ternary() { prop_ternary(UInt64.self) }
        @Test func test_unary_noinline() { prop_unary_noinline(UInt64.self) }
        @Test func test_binary_noinline() { prop_binary_noinline(UInt64.self) }
        @Test func test_ternary_noinline() { prop_ternary_noinline(UInt64.self) }
        @Test func test_factorial_recursive() { prop_factorial_recursive(UInt64.self) }
        @Test func test_factorial_tailcall() { prop_factorial_tailcall(UInt64.self) }
        @Test func test_factorial_recursive_noinline() { prop_factorial_recursive_noinline(UInt64.self) }
        @Test func test_factorial_tailcall_noinline() { prop_factorial_tailcall_noinline(UInt64.self) }
        @Test func test_mutually_recursive() { prop_mutually_recursive(UInt64.self) }
        @Test func test_mutually_recursive_noinline() { prop_mutually_recursive_noinline(UInt64.self) }
        @Test func test_fibonacci_recursive() { prop_fibonacci_recursive(UInt64.self) }
        @Test func test_fibonacci_recursive_noinline() { prop_fibonacci_recursive_noinline(UInt64.self) }
    }
}

// MARK: simple function calls
private func prop_unary<T: Arbitrary & Similar>(_ proxy: T.Type) {
    func unary(_ x: T) -> T { x }
    property(String(describing: T.self)+"unary") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map(unary)
        let actual = map(xs, unary)
        return try? #require( expected ~~~ actual )
      }
}

private func prop_binary<T: Arbitrary & Similar & Comparable>(_ proxy: T.Type) {
    func binary(_ x1: T, _ x2: T) -> T { return max(x1, x2) }
    property(String(describing: T.self)+"binary") <-
    forAllNoShrink([T].arbitrary) { (xs: [T]) in
    forAllNoShrink([T].arbitrary) { (ys: [T]) in
        let expected = zip(xs, ys).map{ (x, y) in binary(x,y) }
        let actual   = zipWith(xs, ys, binary)
        return try? #require( actual ~~~ expected )
      }}
}

private func prop_ternary<T: Arbitrary & Similar & Comparable>(_ proxy: T.Type) {
    func ternary(_ x1: T, _ x2: T, _ x3: T) -> T { return min(max(x1, x2), x3) }
    property(String(describing: T.self)+"ternary") <-
    forAllNoShrink([T].arbitrary) { (xs: [T]) in
    forAllNoShrink([T].arbitrary) { (ys: [T]) in
    forAllNoShrink([T].arbitrary) { (zs: [T]) in
        let size = min(min(xs.count, ys.count), zs.count)
        let expected = (0..<size).map { i in ternary(xs[i], ys[i], zs[i]) }
        let actual   = generate(count: size) { i in ternary(xs[i], ys[i], zs[i]) }
        return try? #require( actual ~~~ expected )
      }}}
}

private func prop_unary_noinline<T: Arbitrary & Similar>(_ proxy: T.Type) {
    @inline(never)
    func unary(_ x: T) -> T { x }
    property(String(describing: T.self)+"unary") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map(unary)
        let actual = map(xs, unary)
        return try? #require( expected ~~~ actual )
      }
}

private func prop_binary_noinline<T: Arbitrary & Similar & Comparable>(_ proxy: T.Type) {
    @inline(never)
    func binary(_ x1: T, _ x2: T) -> T { return max(x1, x2) }
    property(String(describing: T.self)+"binary") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink([T].arbitrary) { (ys: [T]) in
        let expected = zip(xs, ys).map{ (x, y) in binary(x,y) }
        let actual   = zipWith(xs, ys, binary)
        return try? #require( actual ~~~ expected )
      }}
}

private func prop_ternary_noinline<T: Arbitrary & Similar & Comparable>(_ proxy: T.Type) {
    @inline(never)
    func ternary(_ x1: T, _ x2: T, _ x3: T) -> T { return min(max(x1, x2), x3) }
    property(String(describing: T.self)+"ternary") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink([T].arbitrary) { (ys: [T]) in
      forAllNoShrink([T].arbitrary) { (zs: [T]) in
        let size = min(min(xs.count, ys.count), zs.count)
        let expected = (0..<size).map { i in ternary(xs[i], ys[i], zs[i]) }
        let actual   = generate(count: size) { i in ternary(xs[i], ys[i], zs[i]) }
        return try? #require( actual ~~~ expected )
      }}}
}


// MARK: recursive functions
private func prop_factorial_recursive<T: RandomType & Similar & BinaryInteger>(_ proxy: T.Type) {
    func factorial(_ n: T) -> T {
        guard n > 1 else { return 1 }
        return n * factorial(n - 1)
    }
    let gen = Gen<T>.choose((T.zero, 5))  // 5! fits in Int8, 6! does not
    property(String(describing: T.self)+"factorial_recursive") <-
      forAllNoShrink(gen.proliferate) { (xs: [T]) in
        let expected = xs.map(factorial)
        let actual = map(xs, factorial)
        return try? #require( actual ~~~ expected )
      }
}

private func prop_factorial_tailcall<T: RandomType & Similar & BinaryInteger>(_ proxy: T.Type) {
    func factorial(_ n: T, _ acc: T = 0) -> T {
        guard n > 1 else { return acc }
        return factorial(n - 1, n * acc)
    }
    let gen = Gen<T>.choose((T.zero, 5))  // 5! fits in Int8, 6! does not
    property(String(describing: T.self)+"factorial_tailcall") <-
      forAllNoShrink(gen.proliferate) { (xs: [T]) in
        let expected = xs.map { n in factorial(n) }
        let actual = map(xs) { n in factorial(n) }
        return try? #require( actual ~~~ expected )
      }
}

private func prop_factorial_recursive_noinline<T: RandomType & Similar & BinaryInteger>(_ proxy: T.Type) {
    @inline(never)
    func factorial(_ n: T) -> T {
        guard n > 1 else { return 1 }
        return n * factorial(n - 1)
    }
    let gen = Gen<T>.choose((T.zero, 5))  // 5! fits in Int8, 6! does not
    property(String(describing: T.self)+"factorial_recursive_noinline") <-
      forAllNoShrink(gen.proliferate) { (xs: [T]) in
        let expected = xs.map(factorial)
        let actual = map(xs, factorial)
        return try? #require( actual ~~~ expected )
      }
}

private func prop_factorial_tailcall_noinline<T: RandomType & Similar & BinaryInteger>(_ proxy: T.Type) {
    @inline(never)
    func factorial(_ n: T, _ acc: T = 0) -> T {
        guard n > 1 else { return acc }
        return factorial(n - 1, n * acc)
    }
    let gen = Gen<T>.choose((T.zero, 5))  // 5! fits in Int8, 6! does not
    property(String(describing: T.self)+"factorial_tailcall_noinline") <-
      forAllNoShrink(gen.proliferate) { (xs: [T]) in
        let expected = xs.map { n in factorial(n) }
        let actual = map(xs) { n in factorial(n) }
        return try? #require( actual ~~~ expected )
      }
}



private func prop_mutually_recursive<T: RandomType & Similar & BinaryInteger>(_ proxy: T.Type) {
    func fnOdd(_ n: T) -> T {
        guard n != 1 else {
            return n
        }
        return n + fnEven(n-1)
    }
    func fnEven(_ n: T) -> T {
        guard n != 0 else {
            return n
        }
        return n * fnOdd(n-1)
    }
    func fn(_ n: T) -> T {
        guard n > 1 else {
            return n
        }
        return if n%2 == 0 {
            n * fnOdd(n-1)
        } else {
            n + fnEven(n-1)
        }
    }
    let gen = Gen<T>.choose((T.zero, 5))
    property(String(describing: T.self)+"mutually_recursive") <-
      forAllNoShrink(gen.proliferate) { (xs: [T]) in
        let expected = xs.map { n in fn(n) }
        let actual = map(xs) { n in fn(n) }
        return try? #require( actual ~~~ expected )
      }
}

private func prop_mutually_recursive_noinline<T: RandomType & Similar & BinaryInteger>(_ proxy: T.Type) {
    @inline(never)
    func fnOdd(_ n: T) -> T {
        guard n != 1 else {
            return n
        }
        return n + fnEven(n-1)
    }
    @inline(never)
    func fnEven(_ n: T) -> T {
        guard n != 0 else {
            return n
        }
        return n * fnOdd(n-1)
    }
    @inline(never)
    func fn(_ n: T) -> T {
        guard n > 1 else {
            return n
        }
        return if n%2 == 0 {
            n * fnOdd(n-1)
        } else {
            n + fnEven(n-1)
        }
    }
    let gen = Gen<T>.choose((T.zero, 5))
    property(String(describing: T.self)+"mutually_recursive") <-
      forAllNoShrink(gen.proliferate) { (xs: [T]) in
        let expected = xs.map { n in fn(n) }
        let actual = map(xs) { n in fn(n) }
        return try? #require( actual ~~~ expected )
      }
}

private func prop_fibonacci_recursive<T: RandomType & Similar & BinaryInteger>(_ proxy: T.Type) {
    func fibonacci(_ n: T) -> T {
        guard n > 1 else { return n }
        return fibonacci(n-1) + fibonacci(n-2)
    }
    let gen = Gen<T>.choose((T.zero, 11)) // fibonacci(11) fits in Int8
    property(String(describing: T.self)+"fibonacci_recursive") <-
      forAllNoShrink(gen.proliferate) { (xs: [T]) in
        let expected = xs.map(fibonacci)
        let actual = map(xs, fibonacci)
        return try? #require( actual ~~~ expected )
      }
}

private func prop_fibonacci_recursive_noinline<T: RandomType & Similar & BinaryInteger>(_ proxy: T.Type) {
    @inline(never)
    func fibonacci(_ n: T) -> T {
        guard n > 1 else { return n }
        return fibonacci(n-1) + fibonacci(n-2)
    }
    let gen = Gen<T>.choose((T.zero, 11)) // fibonacci(11) fits in Int8
    property(String(describing: T.self)+"fibonacci_recursive_noinline") <-
      forAllNoShrink(gen.proliferate) { (xs: [T]) in
        let expected = xs.map(fibonacci)
        let actual = map(xs, fibonacci)
        return try? #require( actual ~~~ expected )
      }
}
