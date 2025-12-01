// Copyright (c) 2025 The swift-to-gpu authors. All rights reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import SwiftCheck
import SwiftToGPU
import Testing

// swiftformat:disable trailingCommas
// swiftlint:disable identifier_name

@Suite("Permute")
struct Permute {
    @Suite("Int")
    struct IntTests {
        typealias T = Int

        // bijective index mappings
        @Test func copy() { copyTest(T.self) }
        @Test func circularShift() { circularShiftTest(T.self) }
        @Test func shuffle() { shuffleTest(T.self) }
        @Test func matrixTranspose() { matrixTransposeTest(T.self) }

        // injective index mappings
        @Test func stridedWrite() { stridedWriteTest(T.self) }
        @Test func shufleInjective() { shufleInjectiveTest(T.self) }
        @Test func shuffleGeneralized() { shuffleGeneralizedTest(T.self) }

        // element-wise combinations (bijective index mapping)
        // @Test(.bug(id: "86b7dzf83")) func elementwiseSum() { elementwiseSumTest(T.self) }
        // @Test(.bug(id: "86b7dzf83")) func elementwiseMin() { elementwiseMinTest(T.self) }

        // non-injective index mappings
        // @Test(.bug(id: "86b7dzf83")) func groupReduce() { groupReduceTest(T.self) }
        // @Test(.bug(id: "86b7dzf83")) func histogram() { histogramTest(T.self) }
        // @Test(.bug(id: "86b7dzf83")) func generalized() { generalizedTest(T.self) }
    }

    @Suite("Int32")
    struct Int32Tests {
        typealias T = Int32

        // bijective index mappings
        @Test func copy() { copyTest(T.self) }
        @Test func circularShift() { circularShiftTest(T.self) }
        @Test func shuffle() { shuffleTest(T.self) }
        @Test func matrixTranspose() { matrixTransposeTest(T.self) }

        // injective index mappings
        @Test func stridedWrite() { stridedWriteTest(T.self) }
        @Test func shufleInjective() { shufleInjectiveTest(T.self) }
        @Test func shuffleGeneralized() { shuffleGeneralizedTest(T.self) }

        // element-wise combinations (bijective index mapping)
        // @Test(.bug(id: "86b7dzf83")) func elementwiseSum() { elementwiseSumTest(T.self) }
        // @Test(.bug(id: "86b7dzf83")) func elementwiseMin() { elementwiseMinTest(T.self) }

        // non-injective index mappings
        // @Test(.bug(id: "86b7dzf83")) func groupReduce() { groupReduceTest(T.self) }
        // @Test(.bug(id: "86b7dzf83")) func histogram() { histogramTest(T.self) }
        // @Test(.bug(id: "86b7dzf83")) func generalized() { generalizedTest(T.self) }
    }

    @Suite("Float32")
    struct Float32Tests {
        typealias T = Float32

        // bijective index mappings
        @Test func copy() { copyTest(T.self) }
        @Test func circularShift() { circularShiftTest(T.self) }
        @Test func shuffle() { shuffleTest(T.self) }
        @Test func matrixTranspose() { matrixTransposeTest(T.self) }

        // injective index mappings
        @Test func stridedWrite() { stridedWriteTest(T.self) }
        @Test func shufleInjective() { shufleInjectiveTest(T.self) }
        @Test func shuffleGeneralized() { shuffleGeneralizedTest(T.self) }

        // element-wise combinations (bijective index mapping)
        // @Test(.bug(id: "86b7dzf83")) func elementwiseSum() { elementwiseSumTest(T.self) }
        // @Test(.bug(id: "86b7dzf83")) func elementwiseMin() { elementwiseMinTest(T.self) }

        // non-injective index mappings
        // @Test(.bug(id: "86b7dzf83")) func groupReduce() { groupReduceTest(T.self) }
        // @Test(.bug(id: "86b7dzf83")) func histogram() { histogramTest(T.self) }
        // @Test(.bug(id: "86b7dzf83")) func generalized() { generalizedTest(T.self) }
    }

    @Suite("Float64")
    struct Float64Tests {
        typealias T = Float64

        // bijective index mappings
        @Test func copy() { copyTest(T.self) }
        @Test func circularShift() { circularShiftTest(T.self) }
        @Test func shuffle() { shuffleTest(T.self) }
        @Test func matrixTranspose() { matrixTransposeTest(T.self) }

        // injective index mappings
        @Test func stridedWrite() { stridedWriteTest(T.self) }
        @Test func shufleInjective() { shufleInjectiveTest(T.self) }
        @Test func shuffleGeneralized() { shuffleGeneralizedTest(T.self) }

        // element-wise combinations (bijective index mapping)
        // @Test(.bug(id: "86b7dzf83")) func elementwiseSum() { elementwiseSumTest(T.self) }
        // @Test(.bug(id: "86b7dzf83")) func elementwiseMin() { elementwiseMinTest(T.self) }

        // non-injective index mappings
        // @Test(.bug(id: "86b7dzf83")) func groupReduce() { groupReduceTest(T.self) }
        // @Test(.bug(id: "86b7dzf83")) func histogram() { histogramTest(T.self) }
        // @Test(.bug(id: "86b7dzf83")) func generalized() { generalizedTest(T.self) }
    }
}

extension Array {
    /// Reference implementation for testing `permute(from:into:combining:_)`
    func permute<Err: Error>(
        into: inout Self,
        combining f: (Element, Element) throws(Err) -> Element,
        _ p: (Int) throws(Err) -> Int?,
    ) throws(Err) {
        for i in self.indices {
            if let j = try p(i) {
                into[j] = try f(self[i], into[j])
            }
        }
    }

    /// Reference implementation for testing `permute(from:into:_)`
    func permute<Err: Error>(into: inout Self, _ p: (Int) throws(Err) -> Int?) throws(Err) {
        for i in self.indices {
            if let j = try p(i) {
                into[j] = self[i]
            }
        }
    }
}

/// parallel array write (i -> i)
private func copyTest<T: Arbitrary & ExpressibleByIntegerLiteral & Equatable>(_: T.Type) {
    property(#function) <-
        forAllNoShrink([T].arbitrary) { (source: [T]) in
            let expected = source
            var actual: [T] = fill(count: source.count, with: 0)
            permute(from: source, into: &actual) { $0 }
            return try? #require(expected == actual)
        }
}

/// parallel array write with circular shift (i -> (i + shift) % count)
private func circularShiftTest<T: Arbitrary & ExpressibleByIntegerLiteral & Equatable>(_: T.Type) {
    property(#function) <-
        forAllNoShrink([T].arbitrary, Int.arbitrary.suchThat { $0 >= 0 }) { (source: [T], shift: Int) in
            var expected: [T] = fill(count: source.count, with: 0)
            var actual: [T] = fill(count: source.count, with: 0)
            source.permute(into: &expected) { ($0 + shift) % source.count }
            permute(from: source, into: &actual) { ($0 + shift) % source.count }
            return try? #require(expected == actual)
        }
}

/// parallel shuffle (i -> p(i) where p: xs.indices -> xs.indices is bijective, i.e. a permutation
private func shuffleTest<T: Arbitrary & ExpressibleByIntegerLiteral & Equatable>(_: T.Type) {
    property(#function) <-
        forAllNoShrink([T].arbitrary) { (source: [T]) in
            forAllNoShrink(source.generateShuffledIndices()) { (shuffledIndices: [Int]) in
                var expected: [T] = fill(count: source.count, with: 0)
                var actual: [T] = fill(count: source.count, with: 0)
                source.permute(into: &expected) { shuffledIndices[$0] }
                permute(from: source, into: &actual) { shuffledIndices[$0] }
                return try? #require(expected == actual)
            }
        }
}

/// row-major matrix transpose
private func matrixTransposeTest<T: Arbitrary & Equatable & ExpressibleByIntegerLiteral>(_: T.Type) {
    let maxDimension = 256
    func transposeRowMajor(_ i: Int, rowCount: Int, colCount: Int) -> Int {
        let rowIndex = i / colCount
        let colIndex = i % colCount
        let transposedRowIndex = colIndex
        let transposedColIndex = rowIndex
        let transposedColCount = rowCount
        return transposedRowIndex * transposedColCount + transposedColIndex
    }
    property(#function) <-
        forAllNoShrink(Gen<Int>.choose((1, maxDimension)), Gen<Int>.choose((1, maxDimension))) { (m: Int, n: Int) in
            forAllNoShrink(T.arbitrary.proliferate(withSize: m * n)) { (matrix: [T]) in
                var expected: [T] = fill(count: matrix.count, with: 0)
                var actual: [T] = fill(count: matrix.count, with: 0)
                matrix.permute(into: &expected) { transposeRowMajor($0, rowCount: m, colCount: n) }
                permute(from: matrix, into: &actual) { transposeRowMajor($0, rowCount: m, colCount: n) }
                return try? #require(expected == actual)
            }
        }
}

/// parallel strided array write (i -> i * n)
private func stridedWriteTest<T: Arbitrary & ExpressibleByIntegerLiteral & Equatable>(_: T.Type) {
    property(#function) <-
        forAllNoShrink([T].arbitrary, Gen<Int>.choose((1, 5))) { (source: [T], n) in
            var expected: [T] = fill(count: source.count * n, with: 0)
            var actual: [T] = fill(count: source.count * n, with: 0)
            source.permute(into: &expected) { $0 * n }
            permute(from: source, into: &actual) { $0 * n }
            return try? #require(expected == actual)
        }
}

/// parallel shuffled write (i -> p(i) where p: from.indices -> into.indices is injective.
/// Generalization of parallel shuffle. Note that from.indices ⊆ into.indices.)
private func shufleInjectiveTest<T: Arbitrary & ExpressibleByIntegerLiteral & Equatable>(_: T.Type) {
    let maxMultiplier = 3, maxOvershoot = 7
    property(#function) <-
        forAllNoShrink(
            [T].arbitrary,
            Gen<Int>.choose((1, maxMultiplier)),
            Gen<Int>.choose((0, maxOvershoot)),
        ) { (source: [T], multiplier: Int, overshoot: Int) in
            // into.count >= source.count
            let intoCount = source.count * multiplier + overshoot
            return forAllNoShrink(
                [T].generateShuffledIndices(upTo: intoCount, count: source.count)
            ) { (shuffledIndices: [Int]) in
                var expected: [T] = fill(count: intoCount, with: 0)
                var actual: [T] = fill(count: intoCount, with: 0)
                source.permute(into: &expected) { shuffledIndices[$0] }
                permute(from: source, into: &actual) { shuffledIndices[$0] }
                return try? #require(expected == actual)
            }
        }
}

/// parallel generalized array write (i -> p(i) where p: from.indices -> Optional<into.indices> is injective
/// for non-nil values in the codomain
private func shuffleGeneralizedTest<T: Arbitrary & ExpressibleByIntegerLiteral & Equatable>(_: T.Type) {
    // `intoCount` is assumed to be the size of an output array.
    // Returns nil if `indices[i]` is out-of-bounds for that array.
    // Otherwise returns `indices[i]`.
    func p(_ i: Int, _ indices: [Int], _ intoCount: Int) -> Int? {
        let index = indices[i]
        if index >= 0, index < intoCount {
            return index
        }
        return nil
    }
    let gen = Gen<Int>.choose((1, 3))
    property(#function) <-
        forAllNoShrink([T].arbitrary, gen, gen) { (source: [T], n: Int, overShoot: Int) in
            // destination array is n times larger than source array
            let intoCount = source.count * n
            // permute indices can shoot past destination array bounds
            let upperBound = intoCount * overShoot
            return forAllNoShrink(
                [T].generateShuffledIndices(upTo: upperBound, count: source.count)
            ) { (shuffledIndices: [Int]) in
                var expected: [T] = fill(count: intoCount, with: 0)
                var actual: [T] = fill(count: intoCount, with: 0)
                source.permute(into: &expected) { p($0, shuffledIndices, intoCount) }
                permute(from: source, into: &actual) { p($0, shuffledIndices, intoCount) }
                return try? #require(expected == actual)
            }
        }
}

/// element-wise x + y using permute
private func elementwiseSumTest<T: Arbitrary & AdditiveArithmetic & Similar>(_: T.Type) {
    let maxSize = 256
    property(#function) <-
        forAllNoShrink(Gen<Int>.choose((1, maxSize))) { (count: Int) in
            let gen = T.arbitrary.proliferate(withSize: count)
            return forAllNoShrink(gen, gen) { (xs: [T], ys: [T]) in
                var expected = ys
                var actual = ys
                xs.permute(into: &expected, combining: +) { $0 }
                permute(from: xs, into: &actual, combining: +) { $0 }
                return try? #require(expected == actual)
            }
        }
}

/// element-wise min(x, y) using permute
private func elementwiseMinTest<T: Arbitrary & Comparable & ExpressibleByIntegerLiteral>(_: T.Type) {
    let maxSize = 256
    property(#function) <-
        forAllNoShrink(Gen<Int>.choose((1, maxSize))) { (count: Int) in
            let gen = T.arbitrary.proliferate(withSize: count)
            return forAllNoShrink(gen, gen) { (xs: [T], ys: [T]) in
                var expected = ys
                var actual = ys
                xs.permute(into: &expected, combining: min) { $0 }
                permute(from: xs, into: &actual, combining: min) { $0 }
                return try? #require(expected == actual)
            }
        }
}

/// y[i] += x[p[i]]
private func groupReduceTest<T: Arbitrary & AdditiveArithmetic & Similar>(_: T.Type) {
    property(#function) <-
        forAllNoShrink([T].arbitrary, [T].arbitrary) { (from: [T], into: [T]) in
            forAllNoShrink(into.generateShuffledIndices(count: from.count)) { (indices: [Int]) in
                var expected = into
                var actual = into
                from.permute(into: &expected, combining: +) { indices[$0] }
                permute(from: from, into: &actual, combining: +) { indices[$0] }
                return try? #require(expected ~~~ actual)
            }
        }
}

private func histogramTest<T: Arbitrary & BinaryInteger>(_: T.Type) {
    let binsCount = 10
    property(#function) <-
        forAllNoShrink([Int].arbitrary) { (source: [Int]) in
            var expected: [Int] = fill(count: binsCount, with: 0)
            var actual: [Int] = fill(count: binsCount, with: 0)
            source.permute(into: &expected) { source[$0] % binsCount }
            permute(from: source, into: &actual) { source[$0] % binsCount }
            return try? #require(expected == actual)
        }
}

/// ys[i] += |
///     xs[p[i]] when p is non-nil
///     0       otherwise
private func generalizedTest<T: Arbitrary & AdditiveArithmetic & Similar>(_: T.Type) {
    // `intoCount` is assumed to be the size of an output array.
    // Returns nil if `indices[i]` is out-of-bounds for that array.
    // Otherwise returns `indices[i]`.
    func p(_ i: Int, _ indices: [Int], _ intoCount: Int) -> Int? {
        let index = indices[i]
        if index < intoCount {
            return index
        }
        return nil
    }

    let maxMultiplier = 3
    let maxOvershoot = 7
    property(#function) <-
        forAllNoShrink(
            [T].arbitrary,
            [T].arbitrary,
            Gen<Int>.choose((1, maxMultiplier)),
            Gen<Int>.choose((0, maxOvershoot)),
        ) { (from: [T], into: [T], multiplier: Int, overshoot: Int) in
            forAllNoShrink(
                [T].generateShuffledIndices(upTo: into.count * multiplier + overshoot, count: from.count)
            ) { (indices: [Int]) in
                var expected = into
                var actual = into
                from.permute(into: &expected, combining: +) { p($0, indices, into.count) }
                permute(from: from, into: &actual, combining: +) { p($0, indices, into.count) }
                return try? #require(expected ~~~ actual)
            }
        }
}
