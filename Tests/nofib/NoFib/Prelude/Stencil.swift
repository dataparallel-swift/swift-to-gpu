// Copyright (c) 2025 PassiveLogic, Inc.

import SwiftCheck
import SwiftToPTX
import Testing

@Suite("Stencil") struct Stencil {
    @Suite("Float16") struct Float16Tests {
        // @Test("finite_difference<Float16>", .bug(id: "86b6vgvy0")) func test_finite_difference() { prop_finite_difference(Float16.self) }
        // @Test("adjacent_difference<Float16>", .bug(id: "86b6vhbg7")) func test_adjacent_difference() {
        // prop_adjacent_difference(Float16.self) }
        // @Test("laplace1D<Float16>", .bug(id: "86b6vhbg7")) func test_laplace1D() { prop_laplace1D(Float16.self) }
    }

    @Suite("Float32") struct Float32Tests {
        // @Test("finite_difference<Float32>", .bug(id: "86b6vgvy0")) func test_finite_difference() { prop_finite_difference(Float32.self) }
        // @Test("adjacent_difference<Float32>", .bug(id: "86b6vhbg7")) func test_adjacent_difference() {
        // prop_adjacent_difference(Float32.self) }
        // @Test("laplace1D<Float32>", .bug(id: "86b6vhbg7")) func test_laplace1D() { prop_laplace1D(Float32.self) }
    }

    @Suite("Float64") struct Float64Tests {
        // @Test("finite_difference<Float64>", .bug(id: "86b6vgvy0")) func test_finite_difference() { prop_finite_difference(Float64.self) }
        // @Test("adjacent_difference<Float64>", .bug(id: "86b6vhbg7")) func test_adjacent_difference() {
        // prop_adjacent_difference(Float64.self) }
        // @Test("laplace1D<Float64>", .bug(id: "86b6vhbg7")) func test_laplace1D() { prop_laplace1D(Float64.self) }
    }
}

extension Array where Element: AdditiveArithmetic {
    @inlinable
    func finite_difference() -> Self {
        self.enumerated().compactMap { i, x in
            guard i != 0 else {
                return nil
            }
            return x - self[i - 1]
        }
    }
}

private func prop_finite_difference<T: Arbitrary & AdditiveArithmetic & Similar>(_: T.Type) {
    @inline(never)
    func finite_difference(_ xs: Array<T>) -> Array<T> {
        guard xs.count > 1 else {
            return []
        }
        let output = generate(count: xs.count - 1) { i in
            xs[i + 1] - xs[i]
        }
        return output
    }
    property(String(describing: [T].self) + ".adjacent_difference") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      let expected = xs.finite_difference()
      let actual = finite_difference(xs)
      return try? #require(expected ~~~ actual)
    }
}

extension Array where Element: AdditiveArithmetic {
    func adjacent_difference() -> Self {
        self.enumerated().map { i, x in
            guard i != 0 else {
                return x
            }
            return x - self[i - 1]
        }
    }
}

private func prop_adjacent_difference<T: AdditiveArithmetic & Arbitrary & Similar>(_: T.Type) {
    func adjacent_difference(_ xs: Array<T>) -> Array<T> {
        imap(xs) { i, x in
            guard i != 0 else {
                return x
            }
            return x - xs[i - 1]
        }
    }
    property(String(describing: [T].self) + ".finite_difference") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.adjacent_difference()
        let actual = adjacent_difference(xs)
        return try? #require(expected ~~~ actual)
      }
}

extension Array where Element: Numeric {
    @inlinable
    func laplace1D() -> Self {
        zip(self.indices, self).compactMap { i, x in
            guard i != self.startIndex else {
                return nil
            }
            guard i != self.index(before: self.endIndex) else {
                return nil
            }
            return self[i - 1] + self[i] - 2 * x
        }
    }
}

private func prop_laplace1D<T: Numeric & Arbitrary & Similar>(_: T.Type) {
    func laplace1D(_ xs: Array<T>) -> Array<T> {
        guard xs.count > 2 else {
            return []
        }
        var output = Array<T>(unsafeUninitializedCapacity: xs.count - 2)
        parallel_for(iterations: output.count) { i in
            output[i] = xs[i] + xs[i + 2] - 2 * xs[i + 1]
        }
        return output
    }
    property(String(describing: [T].self) + ".laplace1D") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.laplace1D()
        let actual = laplace1D(xs)
        return try? #require(expected ~~~ actual)
      }
}
