// Copyright (c) 2025 PassiveLogic, Inc.

import SwiftCheck
import SwiftToGPU
import Testing

@Suite("Optionals")
struct OptionalTests {
    @Suite("Int")
    struct IntTests {
        @Test func ifLet() { ifLetTest(Int.self) }
        @Test func guardLet() { guardLetTest(Int.self) }
        @Test func nilCoalescing() { nilCoalescingTest(Int.self) }
        @Test func optionalReturn() { optionalReturnTest(Int.self) }
        @Test func forceUnwrapNonnil() { forceUnwrapNonnilTest(Int.self) }
    }

    @Suite("Int8")
    struct Int8Tests {
        @Test func ifLet() { ifLetTest(Int8.self) }
        @Test func guardLet() { guardLetTest(Int8.self) }
        @Test func nilCoalescing() { nilCoalescingTest(Int8.self) }
        @Test func optionalReturn() { optionalReturnTest(Int8.self) }
        @Test func forceUnwrapNonnil() { forceUnwrapNonnilTest(Int8.self) }
    }

    @Suite("Int16")
    struct Int16Tests {
        @Test func ifLet() { ifLetTest(Int16.self) }
        @Test func guardLet() { guardLetTest(Int16.self) }
        @Test func nilCoalescing() { nilCoalescingTest(Int16.self) }
        @Test func optionalReturn() { optionalReturnTest(Int16.self) }
        @Test func forceUnwrapNonnil() { forceUnwrapNonnilTest(Int16.self) }
    }

    @Suite("Int32")
    struct Int32Tests {
        @Test func ifLet() { ifLetTest(Int32.self) }
        @Test func guardLet() { guardLetTest(Int32.self) }
        @Test func nilCoalescing() { nilCoalescingTest(Int32.self) }
        @Test func optionalReturn() { optionalReturnTest(Int32.self) }
        @Test func forceUnwrapNonnil() { forceUnwrapNonnilTest(Int32.self) }
    }

    @Suite("Int64")
    struct Int64Tests {
        @Test func ifLet() { ifLetTest(Int64.self) }
        @Test func guardLet() { guardLetTest(Int64.self) }
        @Test func nilCoalescing() { nilCoalescingTest(Int64.self) }
        @Test func optionalReturn() { optionalReturnTest(Int64.self) }
        @Test func forceUnwrapNonnil() { forceUnwrapNonnilTest(Int64.self) }
    }

    @Suite("UInt")
    struct UIntTests {
        @Test func ifLet() { ifLetTest(UInt.self) }
        @Test func guardLet() { guardLetTest(UInt.self) }
        @Test func nilCoalescing() { nilCoalescingTest(UInt.self) }
        @Test func optionalReturn() { optionalReturnTest(UInt.self) }
        @Test func forceUnwrapNonnil() { forceUnwrapNonnilTest(UInt.self) }
    }

    @Suite("UInt8")
    struct UInt8Tests {
        @Test func ifLet() { ifLetTest(UInt8.self) }
        @Test func guardLet() { guardLetTest(UInt8.self) }
        @Test func nilCoalescing() { nilCoalescingTest(UInt8.self) }
        @Test func optionalReturn() { optionalReturnTest(UInt8.self) }
        @Test func forceUnwrapNonnil() { forceUnwrapNonnilTest(UInt8.self) }
    }

    @Suite("UInt16")
    struct UInt16Tests {
        @Test func ifLet() { ifLetTest(UInt16.self) }
        @Test func guardLet() { guardLetTest(UInt16.self) }
        @Test func nilCoalescing() { nilCoalescingTest(UInt16.self) }
        @Test func optionalReturn() { optionalReturnTest(UInt16.self) }
        @Test func forceUnwrapNonnil() { forceUnwrapNonnilTest(UInt16.self) }
    }

    @Suite("UInt32")
    struct UInt32Tests {
        @Test func ifLet() { ifLetTest(UInt32.self) }
        @Test func guardLet() { guardLetTest(UInt32.self) }
        @Test func nilCoalescing() { nilCoalescingTest(UInt32.self) }
        @Test func optionalReturn() { optionalReturnTest(UInt32.self) }
        @Test func forceUnwrapNonnil() { forceUnwrapNonnilTest(UInt32.self) }
    }

    @Suite("UInt64")
    struct UInt64Tests {
        @Test func ifLet() { ifLetTest(UInt64.self) }
        @Test func guardLet() { guardLetTest(UInt64.self) }
        @Test func nilCoalescing() { nilCoalescingTest(UInt64.self) }
        @Test func optionalReturn() { optionalReturnTest(UInt64.self) }
        @Test func forceUnwrapNonnil() { forceUnwrapNonnilTest(UInt64.self) }
    }

    #if arch(arm64)
    @Suite("Float16")
    struct Float16Tests {
        @Test func ifLet() { ifLetTest(Float16.self) }
        @Test func guardLet() { guardLetTest(Float16.self) }
        @Test func nilCoalescing() { nilCoalescingTest(Float16.self) }
        @Test func optionalReturn() { optionalReturnTest(Float16.self) }
        @Test func forceUnwrapNonnil() { forceUnwrapNonnilTest(Float16.self) }
    }
    #endif

    @Suite("Float32")
    struct Float32Tests {
        @Test func ifLet() { ifLetTest(Float32.self) }
        @Test func guardLet() { guardLetTest(Float32.self) }
        @Test func nilCoalescing() { nilCoalescingTest(Float32.self) }
        @Test func optionalReturn() { optionalReturnTest(Float32.self) }
        @Test func forceUnwrapNonnil() { forceUnwrapNonnilTest(Float32.self) }
    }

    @Suite("Float64")
    struct Float64Tests {
        @Test func ifLet() { ifLetTest(Float64.self) }
        @Test func guardLet() { guardLetTest(Float64.self) }
        @Test func nilCoalescing() { nilCoalescingTest(Float64.self) }
        @Test func optionalReturn() { optionalReturnTest(Float64.self) }
        @Test func forceUnwrapNonnil() { forceUnwrapNonnilTest(Float64.self) }
    }
}

private func ifLetTest<T: Arbitrary & Equatable & ExpressibleByIntegerLiteral>(_: T.Type) {
    func ifLet(_ x: T?) -> T {
        if let unwrapped = x {
            return unwrapped
        }
        return 0
    }
    property(#function) <-
        forAllNoShrink([T?].arbitrary) { (xs: [T?]) in
            let expected = xs.map(ifLet)
            let actual = map(xs, ifLet)
            return try? #require(expected == actual)
        }
}

private func guardLetTest<T: Arbitrary & Equatable & ExpressibleByIntegerLiteral>(_: T.Type) {
    func guardLet(_ x: T?) -> T {
        guard let unwrapped = x else {
            return 0
        }
        return unwrapped
    }
    property(#function) <-
        forAllNoShrink([T?].arbitrary) { (xs: [T?]) in
            let expected = xs.map(guardLet)
            let actual = map(xs, guardLet)
            return try? #require(expected == actual)
        }
}

private func nilCoalescingTest<T: Arbitrary & Equatable & ExpressibleByIntegerLiteral>(_: T.Type) {
    func nilCoalescing(_ x: T?) -> T {
        x ?? 0
    }
    property(#function) <-
        forAllNoShrink([T?].arbitrary) { (xs: [T?]) in
            let expected = xs.map(nilCoalescing)
            let actual = map(xs, nilCoalescing)
            return try? #require(expected == actual)
        }
}

private func optionalReturnTest<T: Arbitrary & Comparable & FloatingPoint>(_: T.Type) {
    func optionalReturn(_ x: T) -> T? {
        // equal probability of hitting both cases
        if x < 0 {
            return nil
        }
        return .some(x)
    }
    property(#function) <-
        forAllNoShrink([T].arbitrary) { (xs: [T]) in
            let expected = xs.map(optionalReturn)
            let actual = map(xs, optionalReturn)
            return try? #require(expected == actual)
        }
}

private func optionalReturnTest<T: Arbitrary & Comparable & FixedWidthInteger>(_: T.Type) {
    func optionalReturn(_ x: T) -> T? {
        // equal probability of hitting both cases
        // for signed and unsigned integers
        if x % 2 == 0 {
            return nil
        }
        return .some(x)
    }
    property(#function) <-
        forAllNoShrink([T].arbitrary) { (xs: [T]) in
            let expected = xs.map(optionalReturn)
            let actual = map(xs, optionalReturn)
            return try? #require(expected == actual)
        }
}

private func forceUnwrapNonnilTest<T: Arbitrary & Equatable>(_: T.Type) {
    // `x` assumed to be non-nil. force-unwrapping a nil is a non-recoverable error
    // and needs to be tested in e.g. a lit+FileCheck driven test.
    func forceUnwrapNonnil(_ x: T?) -> T {
        // swiftlint:disable:next force_unwrapping
        x!
    }
    property(#function) <-
        forAllNoShrink([T].arbitrary) { (xs: [T]) in
            let ys = xs.map { Optional($0) }
            let expected = ys.map(forceUnwrapNonnil)
            let actual = map(ys, forceUnwrapNonnil)
            return try? #require(expected == actual)
        }
}
