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

@Suite("Backpermute")
struct Backpermute {
    // MARK: - Unit Tests (hardcoded examples)

    // Reverse permutation: (n - 1 - i) -> i
    @Test(arguments: zip(
        [[1, 2, 3, 4, 5], [], [1], [1, 2], [1, 2, 3]],
        [[5, 4, 3, 2, 1], [], [1], [2, 1], [3, 2, 1]]
    ))
    func reversePermutation(sourceLiteral: [Int], expected: [Int]) {
        // SEE: [Array literals on the GPU]
        let source = copy(sourceLiteral)
        let actual = backpermute(from: source, count: source.count) { source.count - 1 - $0 }
        #expect(actual == expected)
    }

    /// Swap first and second halves.
    @Test(arguments: zip(
        [[1, 2, 3, 4, 5, 6], [1,2], [1], [], [1, 2, 3, 4, 5]],
        [[4, 5, 6, 1, 2, 3], [2,1], [1], [], [3, 4, 5, 1, 2]]
    ))
    func swapHalves(sourceLiteral: [Int], expected: [Int]) {
        // SEE: [Array literals on the GPU]
        let source = copy(sourceLiteral)
        let split = source.count / 2
        let secondHalfCount = source.count - split
        let actual = backpermute(from: source, count: source.count) { i in
            if i < secondHalfCount {
                return i + split
            }
            return i - secondHalfCount
        }
        #expect(actual == expected)
    }

    /// Circular shift by +2: ((i + 2) % n) -> i
    @Test(arguments: zip(
        [[1, 2, 3, 4, 5], [], [1], [1, 2], [1, 2, 3]],
        [[3, 4, 5, 1, 2], [], [1], [1, 2], [3, 1, 2]]
    ))
    func circularShift(sourceLiteral: [Int], expected: [Int]) {
        // SEE: [Array literals on the GPU]
        let source = copy(sourceLiteral)
        let actual = backpermute(from: source, count: source.count) { ($0 + 2) % source.count }
        #expect(actual == expected)
    }

    /// 2x3 row-major matrix transpose: [[1,2,3],[4,5,6]] -> [[1,4],[2,5],[3,6]]
    @Test
    func matrixTranspose2x3() {
        // 2x3 matrix stored in row-major order
        // swiftformat:disable:next wrap wrapArguments
        let matrixLiteral = [1, 2, 3,
                             4, 5, 6]
        // Transposed 3x2 matrix in row-major order
        // swiftformat:disable:next wrap wrapArguments
        let expected = [1, 4,
                        2, 5,
                        3, 6]
        // SEE: [Array literals on the GPU]
        let matrix = copy(matrixLiteral)
        let rowCount = 2
        let colCount = 3
        let transposedColCount = rowCount
        let actual = backpermute(from: matrix, count: matrix.count) { i in
            let transposedRowIndex = i / transposedColCount
            let transposedColIndex = i % transposedColCount
            let sourceRowIndex = transposedColIndex
            let sourceColIndex = transposedRowIndex
            return sourceRowIndex * colCount + sourceColIndex
        }
        #expect(actual == expected)
    }

    @Suite("Int")
    struct IntTests {
        typealias T = Int
        @Test func backpermuteCopy() { backpermuteCopyTest(T.self) }
        @Test func backpermuteReverse() { backpermuteReverseTest(T.self) }
        @Test func backpermuteSwapHalves() { backpermuteSwapHalvesTest(T.self) }
        @Test func backpermuteCircularShift() { backpermuteCircularShiftTest(T.self) }
        @Test func backpermuteShuffle() { backpermuteShuffleTest(T.self) }
        @Test func backpermuteMatrixTranspose() { backpermuteMatrixTransposeTest(T.self) }
        @Test func backpermuteStridedRead() { backpermuteStridedReadTest(T.self) }
        @Test func backpermuteWithDefault() { backpermuteWithDefaultTest(T.self) }
        @Test func backpermuteGeneralized() { backpermuteGeneralizedTest(T.self) }
    }

    @Suite("Int32")
    struct Int32Tests {
        typealias T = Int32
        @Test func backpermuteCopy() { backpermuteCopyTest(T.self) }
        @Test func backpermuteReverse() { backpermuteReverseTest(T.self) }
        @Test func backpermuteSwapHalves() { backpermuteSwapHalvesTest(T.self) }
        @Test func backpermuteCircularShift() { backpermuteCircularShiftTest(T.self) }
        @Test func backpermuteShuffle() { backpermuteShuffleTest(T.self) }
        @Test func backpermuteMatrixTranspose() { backpermuteMatrixTransposeTest(T.self) }
        @Test func backpermuteStridedRead() { backpermuteStridedReadTest(T.self) }
        @Test func backpermuteWithDefault() { backpermuteWithDefaultTest(T.self) }
        @Test func backpermuteGeneralized() { backpermuteGeneralizedTest(T.self) }
    }

    @Suite("Int64")
    struct Int64Tests {
        typealias T = Int64
        @Test func backpermuteCopy() { backpermuteCopyTest(T.self) }
        @Test func backpermuteReverse() { backpermuteReverseTest(T.self) }
        @Test func backpermuteSwapHalves() { backpermuteSwapHalvesTest(T.self) }
        @Test func backpermuteCircularShift() { backpermuteCircularShiftTest(T.self) }
        @Test func backpermuteShuffle() { backpermuteShuffleTest(T.self) }
        @Test func backpermuteMatrixTranspose() { backpermuteMatrixTransposeTest(T.self) }
        @Test func backpermuteStridedRead() { backpermuteStridedReadTest(T.self) }
        @Test func backpermuteWithDefault() { backpermuteWithDefaultTest(T.self) }
        @Test func backpermuteGeneralized() { backpermuteGeneralizedTest(T.self) }
    }

    @Suite("Float32")
    struct Float32Tests {
        typealias T = Float32
        @Test func backpermuteCopy() { backpermuteCopyTest(T.self) }
        @Test func backpermuteReverse() { backpermuteReverseTest(T.self) }
        @Test func backpermuteSwapHalves() { backpermuteSwapHalvesTest(T.self) }
        @Test func backpermuteCircularShift() { backpermuteCircularShiftTest(T.self) }
        @Test func backpermuteShuffle() { backpermuteShuffleTest(T.self) }
        @Test func backpermuteMatrixTranspose() { backpermuteMatrixTransposeTest(T.self) }
        @Test func backpermuteStridedRead() { backpermuteStridedReadTest(T.self) }
        @Test func backpermuteWithDefault() { backpermuteWithDefaultTest(T.self) }
        @Test func backpermuteGeneralized() { backpermuteGeneralizedTest(T.self) }
    }

    @Suite("Float64")
    struct Float64Tests {
        typealias T = Float64
        @Test func backpermuteCopy() { backpermuteCopyTest(T.self) }
        @Test func backpermuteReverse() { backpermuteReverseTest(T.self) }
        @Test func backpermuteSwapHalves() { backpermuteSwapHalvesTest(T.self) }
        @Test func backpermuteCircularShift() { backpermuteCircularShiftTest(T.self) }
        @Test func backpermuteShuffle() { backpermuteShuffleTest(T.self) }
        @Test func backpermuteMatrixTranspose() { backpermuteMatrixTransposeTest(T.self) }
        @Test func backpermuteStridedRead() { backpermuteStridedReadTest(T.self) }
        @Test func backpermuteWithDefault() { backpermuteWithDefaultTest(T.self) }
        @Test func backpermuteGeneralized() { backpermuteGeneralizedTest(T.self) }
    }
}

private extension Array {
    func backpermute<Err: Error>(into: inout Self, _ p: (Index) throws(Err) -> Index) throws(Err) {
        for i in into.indices {
            into[i] = self[try p(i)]
        }
    }

    func backpermute<Err: Error>(count: Int, _ p: (Index) throws(Err) -> Index) throws(Err) -> Self {
        // SEE: [Array initialiser with typed throws]
        var into = Self(unsafeUninitializedCapacity: count)
        try self.backpermute(into: &into, p)
        return into
    }

    func backpermute<Err: Error>(into: inout Self, _ p: (Int) throws(Err) -> Either<Index, Element>) throws(Err) {
        for i in into.indices {
            let v = switch try p(i) {
                case let .left(j): self[j]
                case let .right(v): v
            }
            into[i] = v
        }
    }

    func backpermute<Err: Error>(count: Int, _ p: (Int) throws(Err) -> Either<Index, Element>) throws(Err) -> Self {
        // SEE: [Array initialiser with typed throws]
        var into = Self(unsafeUninitializedCapacity: count)
        try self.backpermute(into: &into, p)
        return into
    }
}

/// parallel array write (i -> i)
private func backpermuteCopyTest<T: Arbitrary & ExpressibleByIntegerLiteral & Equatable>(_: T.Type) {
    property(#function) <-
        forAllNoShrink([T].arbitrary) { (source: [T]) in
            let expected = source
            let actual = backpermute(from: source, count: source.count) { $0 }
            return try? #require(expected == actual)
        }
}

/// reverse array (n - 1 - i -> i)
private func backpermuteReverseTest<T: Arbitrary & Equatable>(_: T.Type) {
    property(#function) <-
        forAllNoShrink([T].arbitrary) { (source: [T]) in
            let expected = Array(source.reversed())
            let actual = backpermute(from: source, count: source.count) { source.count - 1 - $0 }
            return try? #require(expected == actual)
        }
}

/// swap first and second halves (for odd counts, second half contains the middle element)
private func backpermuteSwapHalvesTest<T: Arbitrary & Equatable>(_: T.Type) {
    property(#function) <-
        forAllNoShrink([T].arbitrary) { (source: [T]) in
            let split = source.count / 2
            let secondHalfCount = source.count - split
            let expected = Array(source[split ..< source.count]) + Array(source[0 ..< split])
            let actual = backpermute(from: source, count: source.count) { i in
                if i < secondHalfCount {
                    return i + split
                }
                return i - secondHalfCount
            }
            return try? #require(expected == actual)
        }
}

/// parallel array write with circular shift ((i + shift) % count -> i)
private func backpermuteCircularShiftTest<T: Arbitrary & ExpressibleByIntegerLiteral & Equatable>(_: T.Type) {
    property(#function) <-
        forAllNoShrink([T].arbitrary, Int.arbitrary.suchThat { $0 >= 0 }) { (source: [T], shift: Int) in
            let expected = source.backpermute(count: source.count) { ($0 + shift) % source.count }
            let actual = backpermute(from: source, count: source.count) { ($0 + shift) % source.count }
            return try? #require(expected == actual)
        }
}

/// parallel shuffle (p(i) -> i where p: xs.indices -> xs.indices is bijective, i.e. a permutation)
private func backpermuteShuffleTest<T: Arbitrary & ExpressibleByIntegerLiteral & Equatable>(_: T.Type) {
    property(#function) <-
        forAllNoShrink([T].arbitrary) { (source: [T]) in
            forAllNoShrink(Gen.fromShufflingElements(of: Array(source.indices))) { (shuffledIndices: [Int]) in
                let expected = source.backpermute(count: source.count) { shuffledIndices[$0] }
                let actual = backpermute(from: source, count: source.count) { shuffledIndices[$0] }
                return try? #require(expected == actual)
            }
        }
}

/// row-major matrix transpose
private func backpermuteMatrixTransposeTest<T: Arbitrary & Equatable & ExpressibleByIntegerLiteral>(_: T.Type) {
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
                let expected = matrix.backpermute(count: matrix.count) { transposeRowMajor($0, rowCount: m, colCount: n) }
                let actual = backpermute(from: matrix, count: matrix.count) { transposeRowMajor($0, rowCount: m, colCount: n) }
                return try? #require(expected == actual)
            }
        }
}

/// parallel strided array write (i -> i * n)
private func backpermuteStridedReadTest<T: Arbitrary & ExpressibleByIntegerLiteral & Equatable>(_: T.Type) {
    let maxSize = 32
    let sizeGen = Gen<Int>.choose((0, maxSize))
    let strideGen = Gen<Int>.choose((1, 5))
    property(#function) <-
        forAllNoShrink(sizeGen, strideGen) { (intoCount: Int, stride: Int) in
            forAllNoShrink(T.arbitrary.proliferate(withSize: intoCount * stride)) { (source: [T]) in
                let expected = source.backpermute(count: intoCount) { $0 * stride }
                let actual = backpermute(from: source, count: intoCount) { $0 * stride }
                return try? #require(expected == actual)
            }
        }
}

/// parallel array write with default value for out-of-bounds indices
private func backpermuteWithDefaultTest<T: Arbitrary & ExpressibleByIntegerLiteral & Equatable>(_: T.Type) {
    let maxSize = 256
    let sizeGen = Gen<Int>.choose((0, maxSize))
    let defaultValue: T = 0
    property(#function) <-
        forAllNoShrink([T].arbitrary, sizeGen) { (from: [T], intoCount: Int) in
            forAllNoShrink(Gen<Int>.choose((-from.count, from.count - 1)).proliferate(withSize: intoCount)) { (indices: [Int]) in
                // swiftlint:disable:next logger_over_print
                print(from, indices)
                func p(_ i: Int) -> Either<Int, T> {
                    let index = indices[i]
                    guard index >= 0, index < from.count else {
                        return Either.right(defaultValue)
                    }
                    return Either.left(index)
                }
                let expected = from.backpermute(count: intoCount, p)
                let actual = backpermute(from: from, count: intoCount, p)
                return try? #require(expected == actual)
            }
        }
}

private extension Either {
    /// randomly choose between `genLeft` and `genRight` with equal weight
    static func gen(_ genLeft: Gen<A>, _ genRight: Gen<B>) -> Gen<Self> {
        Bool.arbitrary.flatMap {
            if $0 {
                genLeft.map { Self.left($0) }
            }
            else {
                genRight.map { Self.right($0) }
            }
        }
    }
}

private extension Array where Element: Arbitrary {
    var indexOrValueGen: Gen<Either<Index, Element>> {
        guard !self.isEmpty else {
            return Element.arbitrary.map { Either<Index, Element>.right($0) }
        }
        return Either<Index, Element>.gen(
            self.inboundsIndexGen,
            Element.arbitrary
        )
    }
}

private extension Array {
    var inboundsIndexGen: Gen<Index> {
        Gen<Index>.choose((self.startIndex, self.endIndex - 1))
    }
}

private func backpermuteGeneralizedTest<T: Arbitrary & ExpressibleByIntegerLiteral & Equatable>(_: T.Type) {
    let maxSize = 256
    let sizeGen = Gen<Int>.choose((0, maxSize))
    property(#function) <-
        forAllNoShrink([T].arbitrary, sizeGen) { (from: [T], intoCount: Int) in
            forAllNoShrink(from.indexOrValueGen.proliferate(withSize: intoCount)) { (indices: [Either<Int, T>]) in
                let expected = from.backpermute(count: intoCount) { indices[$0] }
                let actual = backpermute(from: from, count: intoCount) { indices[$0] }
                return try? #require(expected == actual)
            }
        }
}
