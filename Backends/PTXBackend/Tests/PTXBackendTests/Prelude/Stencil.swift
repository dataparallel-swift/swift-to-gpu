// Copyright (c) 2025 PassiveLogic, Inc.

import PTXBackend
import SwiftCheck
import Testing

// swiftformat:disable blankLinesBetweenScopes

@Suite("Stencil") struct Stencil {
    #if arch(arm64)
    @Test("finite_difference.Float16") func test_finite_difference_1() { prop_finite_difference(Float16.self) }
    #endif
    @Test("finite_difference.Float32") func test_finite_difference_2() { prop_finite_difference(Float32.self) }
    @Test("finite_difference.Float64") func test_finite_difference_3() { prop_finite_difference(Float64.self) }
    @Test("finite_difference.Int32") func test_finite_difference_4() { prop_finite_difference(Int32.self) }
    @Test("finite_difference.Int64") func test_finite_difference_5() { prop_finite_difference(Int64.self) }

    #if arch(arm64)
    @Test("adjacent_difference.Float16") func test_adjacent_difference_1() {
        prop_adjacent_difference(Float16.self) }
    #endif
    @Test("adjacent_difference.Float32") func test_adjacent_difference_2() {
        prop_adjacent_difference(Float32.self) }
    @Test("adjacent_difference.Float64") func test_adjacent_difference_3() {
        prop_adjacent_difference(Float64.self) }
    @Test("adjacent_difference.Int32") func test_adjacent_difference_4() {
        prop_adjacent_difference(Int32.self) }
    @Test("adjacent_difference.Int64") func test_adjacent_difference_5() {
        prop_adjacent_difference(Int64.self) }

    #if arch(arm64)
    @Test("laplace1D.Float16") func test_laplace1D_1() { prop_laplace1D(Float16.self) }
    #endif
    @Test("laplace1D.Float32") func test_laplace1D_2() { prop_laplace1D(Float32.self) }
    @Test("laplace1D.Float64") func test_laplace1D_3() { prop_laplace1D(Float64.self) }
    @Test("laplace1D.Int32") func test_laplace1D_4() { prop_laplace1D(Int32.self) }
    @Test("laplace1D.Int64") func test_laplace1D_5() { prop_laplace1D(Int64.self) }
}

extension Array where Element: AdditiveArithmetic {
    @inlinable
    func finite_difference() -> Self {
        zip(self.indices, self).compactMap { i, x in
            guard i != 0 else {
                return nil
            }
            return x - self[i - 1]
        }
    }
}

private func prop_finite_difference<T: Arbitrary & AdditiveArithmetic & Similar>(_: T.Type) {
    // XXX: required because of https://app.clickup.com/t/86b7az9f8
    @inline(never)
    func finite_difference(_ xs: Array<T>) -> Array<T> {
        // TODO: Cannot early exit because of a bug (ClickUp: 86b6vgvy0)
        // guard xs.count > 1 else {
        //     return []
        // }
        let output = generate(count: xs.count - 1) { i in
            xs[i + 1] - xs[i]
        }
        return output
    }
    let gen = [T].arbitrary.suchThat { $0.count > 1 }
    property("adjacent_difference." + String(describing: [T].self)) <-
      forAllNoShrink(gen) { (xs: [T]) in
        let expected = xs.finite_difference()
        let actual = finite_difference(xs)
        return try? #require(expected ~~~ actual)
      }
}

extension Array where Element: AdditiveArithmetic {
    func adjacent_difference() -> Self {
        zip(self.indices, self).map { i, x in
            guard i != 0 else {
                return x
            }
            return x - self[i - 1]
        }
    }
}

private func prop_adjacent_difference<T: AdditiveArithmetic & Arbitrary & Similar>(_: T.Type) {
    // XXX: required because of https://app.clickup.com/t/86b7az9f8
    @inline(never)
    func adjacent_difference(_ xs: Array<T>) -> Array<T> {
        imap(xs) { i, x in
            guard i != 0 else {
                return x
            }
            return x - xs[i - 1]
        }
    }
    property("finite_difference." + String(describing: [T].self)) <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.adjacent_difference()
        let actual = adjacent_difference(xs)
        return try? #require(expected ~~~ actual)
      }
}

extension Array where Element: Numeric {
    @inlinable
    func laplace1D() -> Self {
        var output: Self = []
        for (i, x) in zip(self.indices, self) {
            guard i != self.startIndex, i != self.index(before: self.endIndex) else {
                continue
            }
            output.append(self[i - 1] + self[i + 1] - 2 * x)
        }
        return output
    }
}

private func prop_laplace1D<T: Numeric & Arbitrary & Similar>(_: T.Type) {
    // XXX: required because of https://app.clickup.com/t/86b7az9f8
    @inline(never)
    func laplace1D(_ xs: Array<T>) -> Array<T> {
        // TODO: Cannot early exit because of a bug (ClickUp: 86b6vgvy0)
        // guard xs.count > 2 else {
        //     return []
        // }
        generate(count: xs.count - 2) { i in
            xs[i] + xs[i + 2] - 2 * xs[i + 1]
        }
    }
    let gen = [T].arbitrary.suchThat { $0.count > 2 }
    property("laplace1D." + String(describing: [T].self)) <-
      forAllNoShrink(gen) { (xs: [T]) in
        let expected = xs.laplace1D()
        let actual = laplace1D(xs)
        return try? #require(expected ~~~ actual)
      }
}
