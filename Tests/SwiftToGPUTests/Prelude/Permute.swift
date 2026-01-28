// Copyright (c) 2026 The swift-to-gpu authors. All rights reserved.
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
    // MARK: - Unit Tests (hardcoded examples)

    @inline(never)
    func copy<T>(_ xs: [T]) -> [T] {
        // NOTE: [Array literals on the GPU]
        // There is an optimization pass/a combination of passes that lifts array literals
        // into one of the constant data section. On Linux, they end up in the .data section, which
        // is inaccessible to the GPU runtime. We rely on the compiler being unable to const-fold
        // `map` to work around this and create a new heap-allocated array from a static array.
        xs.map(\.self)
    }

    /// Reverse permutation: i -> (n-1-i)
    @Test(arguments: zip(
        [[1, 2, 3, 4, 5], [1], [], [1, 2]],
        [[5, 4, 3, 2, 1], [1], [], [2, 1]]
    ))
    func reversePermutation(sourceLiteral: [Int], expected: [Int]) {
        // SEE: [Array literals on the GPU]
        let source = copy(sourceLiteral)
        var actual: [Int] = fill(count: source.count, with: 0)
        permute(from: source, into: &actual) { source.count - 1 - $0 }
        #expect(expected == actual)
    }

    /// Circular shift: i -> (i+2) % n
    @Test(arguments: zip(
        [[1, 2, 3, 4, 5], [], [1], [1, 2], [1, 2, 3]],
        [[4, 5, 1, 2, 3], [], [1], [1, 2], [2, 3, 1]]
    ))
    func circularShift(sourceLiteral: [Int], expected: [Int]) {
        // SEE: [Array literals on the GPU]
        let source = copy(sourceLiteral)
        var result: [Int] = fill(count: source.count, with: 0)
        permute(from: source, into: &result) { ($0 + 2) % source.count }
        #expect(result == expected)
    }

    /// Strided write: i -> 2*i (scatter into larger array)
    @Test(arguments: zip(
        [[10, 20, 30]],
        [[10, 0, 20, 0, 30, 0]]
    ))
    func stridedWrite(sourceLiteral: [Int], expected: [Int]) {
        // SEE: [Array literals on the GPU]
        let source = copy(sourceLiteral)
        var actual: [Int] = fill(count: 2 * source.count, with: 0)
        permute(from: source, into: &actual) { $0 * 2 }
        #expect(actual == expected)
    }

    /// Partial permutation with nil: only some elements are written
    @Test(arguments: zip(
        [[100, 200, 300, 400, 500]],
        [[100, -1, 300, -1, 500]]
    ))
    func partialPermutationWithNil(sourceLiteral: [Int], expected: [Int]) {
        // SEE: [Array literals on the GPU]
        let source = copy(sourceLiteral)
        var actual: [Int] = fill(count: source.count, with: -1)
        permute(from: source, into: &actual) { i in
            // Only write even-indexed elements
            i % 2 == 0 ? i : nil
        }
        #expect(actual == expected)
    }

    /// 2x3 row-major matrix transpose: .e.g. [[1,2,3],[4,5,6]] -> [[1,4],[2,5],[3,6]]
    @Test func matrixTranspose2x3() {
        // 2x3 matrix stored in row-major order
        // swiftformat:disable:next wrap wrapArguments
        let matrixLiteral = [1, 2, 3,
                             4, 5, 6]
        // SEE: [Array literals on the GPU]
        let matrix = copy(matrixLiteral)
        let rowCount = 2, colCount = 3

        var transposed: [Int] = fill(count: matrix.count, with: 0)

        permute(from: matrix, into: &transposed) { i in
            let rowIndex = i / colCount
            let colIndex = i % colCount
            let transposedRowIndex = colIndex
            let transposedColIndex = rowIndex
            let transposedColCount = rowCount
            return transposedRowIndex * transposedColCount + transposedColIndex
        }

        // Transposed 3x2 matrix: [[1,4],[2,5],[3,6]] ≡ [1,4,2,5,3,6]
        // swiftformat:disable:next wrap wrapArguments
        #expect(transposed == [1, 4,
                               2, 5,
                               3, 6])
    }

    /// Shuffle with known permutation
    @Test func shuffle() {
        let sourceLiteral = [10, 20, 30, 40, 50]
        // SEE: [Array literals on the GPU]
        let source = copy(sourceLiteral)
        let indices = [3, 0, 4, 1, 2] // where each element goes
        var result: [Int] = fill(count: source.count, with: 0)
        permute(from: source, into: &result) { indices[$0] }
        // source[0]=10 -> result[3], source[1]=20 -> result[0], source[2]=30 -> result[4],
        // source[3]=40 -> result[1], source[4]=50 -> result[2]
        #expect(result == [20, 40, 50, 10, 30])
    }

    /// Scatter into sparse locations
    @Test func sparseScatter() {
        let sourceLiteral = [100, 200, 300]
        // SEE: [Array literals on the GPU]
        let source = copy(sourceLiteral)
        let targetIndices = [7, 2, 5] // where each element goes
        var result: [Int] = fill(count: 10, with: 0)
        permute(from: source, into: &result) { targetIndices[$0] }
        #expect(result == [0, 0, 200, 0, 0, 300, 0, 100, 0, 0])
    }

    // MARK: - Unit Tests (with combining function)

    // /// Element-wise sum: result[i] = xs[i] + ys[i]
    // @Test(.bug(id: "86b7dzf83")) func elementwiseSum() {
    //     let xs = [1, 2, 3, 4, 5]
    //     var ys = [10, 20, 30, 40, 50]
    //     permute(from: xs, into: &ys, combining: +) { $0 }
    //     #expect(ys == [11, 22, 33, 44, 55])
    // }

    // /// Element-wise min: result[i] = min(xs[i], ys[i])
    // @Test(.bug(id: "86b7dzf83")) func elementwiseMin() {
    //     let xs = [5, 2, 8, 1, 9]
    //     var ys = [3, 7, 4, 6, 2]
    //     permute(from: xs, into: &ys, combining: min) { $0 }
    //     #expect(ys == [3, 2, 4, 1, 2])
    // }

    // /// Group reduce: multiple source elements contribute to the same destination
    // @Test(.bug(id: "86b7dzf83")) func groupReduce() {
    //     // Values to accumulate
    //     let values = [10, 20, 30, 40, 50]
    //     // Group assignments: values[0,2,4] go to group 0, values[1,3] go to group 1
    //     let groups = [0, 1, 0, 1, 0]
    //     var sums: [Int] = fill(count: 2, with: 0)
    //     permute(from: values, into: &sums, combining: +) { groups[$0] }
    //     // group 0: 10 + 30 + 50 = 90
    //     // group 1: 20 + 40 = 60
    //     #expect(sums == [90, 60])
    // }

    // /// Histogram: count occurrences of values in bins
    // @Test(.bug(id: "86b7dzf83")) func histogram() {
    //     // Data values in range [0, 4]
    //     let data = [0, 1, 2, 2, 3, 3, 3, 4, 4, 4, 4]
    //     let ones: [Int] = fill(count: data.count, with: 1)
    //     var bins: [Int] = fill(count: 5, with: 0)
    //     permute(from: ones, into: &bins, combining: +) { data[$0] }
    //     // bin 0: 1 occurrence, bin 1: 1, bin 2: 2, bin 3: 3, bin 4: 4
    //     #expect(bins == [1, 1, 2, 3, 4])
    // }

    // /// Partial group reduce with nil: only some elements contribute
    // @Test(.bug(id: "86b7dzf83")) func partialGroupReduce() {
    //     let values = [100, 200, 300, 400, 500]
    //     var result: [Int] = fill(count: 3, with: 0)
    //     permute(from: values, into: &result, combining: +) { i in
    //         // Only include odd-indexed elements
    //         // values[1]=200 -> result[0], values[3]=400 -> result[1]
    //         switch i {
    //         case 1: 0
    //         case 3: 1
    //         default: nil
    //         }
    //     }
    //     #expect(result == [200, 400, 0])
    // }

    /// Scatter-add: add values at specific sparse locations
    // @Test(.bug(id: "86b7dzf83")) func scatterAdd() {
    //     let values = [5, 10, 15]
    //     let indices = [1, 3, 1] // Note: indices 0 and 2 both map to position 1
    //     var result: [Int] = fill(count: 5, with: 0)
    //     permute(from: values, into: &result, combining: +) { indices[$0] }
    //     // result[1] = values[0] + values[2] = 5 + 15 = 20
    //     // result[3] = values[1] = 10
    //     #expect(result == [0, 20, 0, 10, 0])
    // }

    // MARK: - Property-Based Tests

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
            let indexGen = Gen.fromShufflingElements(of: Array(source.indices))
            return forAllNoShrink(indexGen) { (shuffledIndices: [Int]) in
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
            let indexGen = Gen.fromShufflingElements(of: Array(0 ..< intoCount)).map(take(source.count))
            return forAllNoShrink(indexGen) { (shuffledIndices: [Int]) in
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
            let indexGen = Gen.fromShufflingElements(of: Array(0 ..< upperBound)).map(take(source.count))
            return forAllNoShrink(indexGen) { (shuffledIndices: [Int]) in
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
            let indexGen = Gen.fromShufflingElements(of: Array(into.indices)).map(take(from.count))
            return forAllNoShrink(indexGen) { (indices: [Int]) in
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
            let upperBound = into.count * multiplier + overshoot
            let indexGen = Gen.fromShufflingElements(of: Array(0 ..< upperBound)).map(take(from.count))
            return forAllNoShrink(indexGen) { (indices: [Int]) in
                var expected = into
                var actual = into
                from.permute(into: &expected, combining: +) { p($0, indices, into.count) }
                permute(from: from, into: &actual, combining: +) { p($0, indices, into.count) }
                return try? #require(expected ~~~ actual)
            }
        }
}

private func take<T>(_ count: Int) -> (([T]) -> [T]) {
    { array in
        // swiftlint:disable:next no_precondition
        precondition(count <= array.count)
        return (0 ..< count).map { array[$0] }
    }
}
