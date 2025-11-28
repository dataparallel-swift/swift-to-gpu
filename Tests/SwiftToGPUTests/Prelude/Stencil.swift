// Copyright (c) 2025 PassiveLogic, Inc.

import SwiftCheck
import SwiftToGPU
import Testing

@Suite("Stencil")
struct StencilTests {
    @Suite("Int32")
    struct Int32Tests {
        @Test func finiteDifference() { finiteDifferenceTest(Int32.self) }
        @Test func adjacentDifference() { adjacentDifferenceTest(Int32.self) }
        @Test func laplace1D() { laplace1DTest(Int32.self) }
    }

    @Suite("Int64")
    struct Int64Tests {
        @Test func finiteDifference() { finiteDifferenceTest(Int64.self) }
        @Test func adjacentDifference() { adjacentDifferenceTest(Int64.self) }
        @Test func laplace1D() { laplace1DTest(Int64.self) }
    }

    #if arch(arm64)
    @Suite("Float16")
    struct Float16Tests {
        @Test func finiteDifference() { finiteDifferenceTest(Float16.self) }
        @Test func adjacentDifference() { adjacentDifferenceTest(Float16.self) }
        @Test func laplace1D() { laplace1DTest(Float16.self) }
    }
    #endif

    @Suite("Float32")
    struct Float32Tests {
        @Test func finiteDifference() { finiteDifferenceTest(Float32.self) }
        @Test func adjacentDifference() { adjacentDifferenceTest(Float32.self) }
        @Test func laplace1D() { laplace1DTest(Float32.self) }
    }

    @Suite("Float64")
    struct Float64Tests {
        @Test func finiteDifference() { finiteDifferenceTest(Float64.self) }
        @Test func adjacentDifference() { adjacentDifferenceTest(Float64.self) }
        @Test func laplace1D() { laplace1DTest(Float64.self) }
    }
}

extension Array where Element: AdditiveArithmetic {
    @inlinable
    func finiteDifference() -> Self {
        zip(self.indices, self).compactMap { i, x in
            guard i != 0 else {
                return nil
            }
            return x - self[i - 1]
        }
    }
}

private func finiteDifferenceTest<T: Arbitrary & AdditiveArithmetic & Similar>(_: T.Type) {
    // XXX: required because of https://app.clickup.com/t/86b7az9f8
    @inline(never)
    func finiteDifference(_ xs: Array<T>) -> Array<T> {
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
    property(#function) <-
        forAllNoShrink(gen) { (xs: [T]) in
            let expected = xs.finiteDifference()
            let actual = finiteDifference(xs)
            return try? #require(expected ~~~ actual)
        }
}

extension Array where Element: AdditiveArithmetic {
    func adjacentDifference() -> Self {
        zip(self.indices, self).map { i, x in
            guard i != 0 else {
                return x
            }
            return x - self[i - 1]
        }
    }
}

private func adjacentDifferenceTest<T: AdditiveArithmetic & Arbitrary & Similar>(_: T.Type) {
    // XXX: required because of https://app.clickup.com/t/86b7az9f8
    @inline(never)
    func adjacentDifference(_ xs: Array<T>) -> Array<T> {
        imap(xs) { i, x in
            guard i != 0 else {
                return x
            }
            return x - xs[i - 1]
        }
    }
    property(#function) <-
        forAllNoShrink([T].arbitrary) { (xs: [T]) in
            let expected = xs.adjacentDifference()
            let actual = adjacentDifference(xs)
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

private func laplace1DTest<T: Numeric & Arbitrary & Similar>(_: T.Type) {
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
    property(#function) <-
        forAllNoShrink(gen) { (xs: [T]) in
            let expected = xs.laplace1D()
            let actual = laplace1D(xs)
            return try? #require(expected ~~~ actual)
        }
}
