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

@Suite("Backpermute")
struct Backpermute {
    // MARK: - Unit Tests (hardcoded examples)

    // /// Reverse permutation: (n - 1 - i) -> i
    // @Test(.bug(id: "86b8jkjek"), arguments: zip(
    //     [[1, 2, 3, 4, 5], [], [1], [1, 2], [1, 2, 3]],
    //     [[5, 4, 3, 2, 1], [], [1], [2, 1], [3, 2, 1]]
    // ))
    // func reversePermutation(sourceLiteral: [Int], expected: [Int]) {
    //     // SEE: [Array literals on the GPU]
    //     let source = copy(sourceLiteral)
    //     let actual = backpermute(from: source, count: source.count) { source.count - 1 - $0 }
    //     #expect(actual == expected)
    // }
    //
    // /// Swap first and second halves.
    // @Test(.bug(id: "86b8jkjek"), arguments: zip(
    //     [[1, 2, 3, 4, 5, 6], [1, 2], [1], [], [1, 2, 3, 4, 5]],
    //     [[4, 5, 6, 1, 2, 3], [2, 1], [1], [], [3, 4, 5, 1, 2]]
    // ))
    // func swapHalves(sourceLiteral: [Int], expected: [Int]) {
    //     // SEE: [Array literals on the GPU]
    //     let source = copy(sourceLiteral)
    //     let split = source.count / 2
    //     let secondHalfCount = source.count - split
    //     let actual = backpermute(from: source, count: source.count) { i in
    //         if i < secondHalfCount {
    //             return i + split
    //         }
    //         return i - secondHalfCount
    //     }
    //     #expect(actual == expected)
    // }
    //
    // /// Circular shift by +2: ((i + 2) % n) -> i
    // @Test(.bug(id: "86b8jkjek"), arguments: zip(
    //     [[1, 2, 3, 4, 5], [], [1], [1, 2], [1, 2, 3]],
    //     [[3, 4, 5, 1, 2], [], [1], [1, 2], [3, 1, 2]]
    // ))
    // func circularShift(sourceLiteral: [Int], expected: [Int]) {
    //     // SEE: [Array literals on the GPU]
    //     let source = copy(sourceLiteral)
    //     let actual = backpermute(from: source, count: source.count) { ($0 + 2) % source.count }
    //     #expect(actual == expected)
    // }
    //
    // /// 2x3 row-major matrix transpose: [[1,2,3],[4,5,6]] -> [[1,4],[2,5],[3,6]]
    // @Test(.bug(id: "86b8jkjek"))
    // func matrixTranspose2x3() {
    //     // 2x3 matrix stored in row-major order
    //     // swiftformat:disable:next wrap wrapArguments
    //     let matrixLiteral = [1, 2, 3,
    //                          4, 5, 6]
    //     // Transposed 3x2 matrix in row-major order
    //     // swiftformat:disable:next wrap wrapArguments
    //     let expected = [1, 4,
    //                     2, 5,
    //                     3, 6]
    //     // SEE: [Array literals on the GPU]
    //     let matrix = copy(matrixLiteral)
    //     let rowCount = 2
    //     let colCount = 3
    //     let transposedColCount = rowCount
    //     let actual = backpermute(from: matrix, count: matrix.count) { i in
    //         let transposedRowIndex = i / transposedColCount
    //         let transposedColIndex = i % transposedColCount
    //         let sourceRowIndex = transposedColIndex
    //         let sourceColIndex = transposedRowIndex
    //         return sourceRowIndex * colCount + sourceColIndex
    //     }
    //     #expect(actual == expected)
    // }
    //
    // /// Extract diagonal from row-major square matrix.
    // @Test(.bug(id: "86b8jkjek"), arguments: zip(
    //     [([1, 2, 3, 4], 2), ([1], 1), ([], 0), ([1, 2, 3, 4, 5, 6, 7, 8, 9], 3)],
    //     [[1, 4], [1], [], [1, 5, 9]]
    // ))
    // func diagonalFromMatrix(sourceAndDimension: ([Int], Int), expected: [Int]) {
    //     let (matrixLiteral, dimension) = sourceAndDimension
    //     // SEE: [Array literals on the GPU]
    //     let matrix = copy(matrixLiteral)
    //     let actual = backpermute(from: matrix, count: dimension) { i in
    //         i * dimension + i
    //     }
    //     #expect(actual == expected)
    // }
    //
    // /// Reorder by writing even indices first, then odd indices.
    // @Test(.bug(id: "86b8jkjek"), arguments: zip(
    //     [[1, 2, 3, 4, 5, 6], [1, 2, 3, 4, 5], [1], []],
    //     [[1, 3, 5, 2, 4, 6], [1, 3, 5, 2, 4], [1], []]
    // ))
    // func evenThenOddIndices(sourceLiteral: [Int], expected: [Int]) {
    //     // SEE: [Array literals on the GPU]
    //     let source = copy(sourceLiteral)
    //     let evenCount = (source.count + 1) / 2
    //     let actual = backpermute(from: source, count: source.count) { i in
    //         if i < evenCount {
    //             return i * 2
    //         }
    //         return (i - evenCount) * 2 + 1
    //     }
    //     #expect(actual == expected)
    // }
    //
    // @Test(.bug(id: "86b8jkjek"))
    // func backpermuteWithDefault() {
    //     //                    0  1  2  3  4
    //     let sourceLiteral =  [1, 2, 3, 4, 5]
    //     let indicesLiteral = [0, -1, 3, 2, 10, 4]
    //     let defaultValue = 99
    //     // SEE: [Array literals on the GPU]
    //     let source = copy(sourceLiteral)
    //     let indices = copy(indicesLiteral)
    //     let expected = [1, defaultValue, 4, 3, defaultValue, 5]
    //     let actual = backpermute(from: source, count: indices.count) { i in
    //         let index = indices[i]
    //         guard index >= 0, index < source.count else {
    //             return Either.right(defaultValue)
    //         }
    //         return Either.left(index)
    //     }
    //     #expect(actual == expected)
    // }

    @Suite("Int")
    struct IntTests {
        typealias T = Int
        @Test func backpermuteCopy() { backpermuteCopyTest(T.self) }
        @Test func backpermuteReverse() { backpermuteReverseTest(T.self) }
        @Test func backpermuteCircularShift() { backpermuteCircularShiftTest(T.self) }
        @Test func backpermuteShuffle() { backpermuteShuffleTest(T.self) }
        @Test func backpermuteStridedRead() { backpermuteStridedReadTest(T.self) }
        @Test func backpermuteMatrixDiagonal() { backpermuteMatrixDiagonalTest(T.self) }
        @Test func backpermuteSwapHalves() { backpermuteSwapHalvesTest(T.self) }
        @Test func backpermuteEvenThenOddIndices() { backpermuteEvenThenOddIndicesTest(T.self) }
        @Test func backpermuteMatrixTranspose() { backpermuteMatrixTransposeTest(T.self) }
        @Test func backpermuteWithDefault() { backpermuteWithDefaultTest(T.self) }
    }

    @Suite("Int32")
    struct Int32Tests {
        typealias T = Int32
        @Test func backpermuteCopy() { backpermuteCopyTest(T.self) }
        @Test func backpermuteReverse() { backpermuteReverseTest(T.self) }
        @Test func backpermuteCircularShift() { backpermuteCircularShiftTest(T.self) }
        @Test func backpermuteShuffle() { backpermuteShuffleTest(T.self) }
        @Test func backpermuteStridedRead() { backpermuteStridedReadTest(T.self) }
        @Test func backpermuteMatrixDiagonal() { backpermuteMatrixDiagonalTest(T.self) }
        @Test func backpermuteSwapHalves() { backpermuteSwapHalvesTest(T.self) }
        @Test func backpermuteEvenThenOddIndices() { backpermuteEvenThenOddIndicesTest(T.self) }
        @Test func backpermuteMatrixTranspose() { backpermuteMatrixTransposeTest(T.self) }
        @Test func backpermuteWithDefault() { backpermuteWithDefaultTest(T.self) }
    }

    @Suite("Int64")
    struct Int64Tests {
        typealias T = Int64
        @Test func backpermuteCopy() { backpermuteCopyTest(T.self) }
        @Test func backpermuteReverse() { backpermuteReverseTest(T.self) }
        @Test func backpermuteCircularShift() { backpermuteCircularShiftTest(T.self) }
        @Test func backpermuteShuffle() { backpermuteShuffleTest(T.self) }
        @Test func backpermuteStridedRead() { backpermuteStridedReadTest(T.self) }
        @Test func backpermuteMatrixDiagonal() { backpermuteMatrixDiagonalTest(T.self) }
        @Test func backpermuteSwapHalves() { backpermuteSwapHalvesTest(T.self) }
        @Test func backpermuteEvenThenOddIndices() { backpermuteEvenThenOddIndicesTest(T.self) }
        @Test func backpermuteMatrixTranspose() { backpermuteMatrixTransposeTest(T.self) }
        @Test func backpermuteWithDefault() { backpermuteWithDefaultTest(T.self) }
    }

    @Suite("Float32")
    struct Float32Tests {
        typealias T = Float32
        @Test func backpermuteCopy() { backpermuteCopyTest(T.self) }
        @Test func backpermuteReverse() { backpermuteReverseTest(T.self) }
        @Test func backpermuteCircularShift() { backpermuteCircularShiftTest(T.self) }
        @Test func backpermuteShuffle() { backpermuteShuffleTest(T.self) }
        @Test func backpermuteStridedRead() { backpermuteStridedReadTest(T.self) }
        @Test func backpermuteMatrixDiagonal() { backpermuteMatrixDiagonalTest(T.self) }
        @Test func backpermuteSwapHalves() { backpermuteSwapHalvesTest(T.self) }
        @Test func backpermuteEvenThenOddIndices() { backpermuteEvenThenOddIndicesTest(T.self) }
        @Test func backpermuteMatrixTranspose() { backpermuteMatrixTransposeTest(T.self) }
        @Test func backpermuteWithDefault() { backpermuteWithDefaultTest(T.self) }
    }

    @Suite("Float64")
    struct Float64Tests {
        typealias T = Float64
        @Test func backpermuteCopy() { backpermuteCopyTest(T.self) }
        @Test func backpermuteReverse() { backpermuteReverseTest(T.self) }
        @Test func backpermuteCircularShift() { backpermuteCircularShiftTest(T.self) }
        @Test func backpermuteShuffle() { backpermuteShuffleTest(T.self) }
        @Test func backpermuteStridedRead() { backpermuteStridedReadTest(T.self) }
        @Test func backpermuteMatrixDiagonal() { backpermuteMatrixDiagonalTest(T.self) }
        @Test func backpermuteSwapHalves() { backpermuteSwapHalvesTest(T.self) }
        @Test func backpermuteEvenThenOddIndices() { backpermuteEvenThenOddIndicesTest(T.self) }
        @Test func backpermuteMatrixTranspose() { backpermuteMatrixTransposeTest(T.self) }
        @Test func backpermuteWithDefault() { backpermuteWithDefaultTest(T.self) }
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

/// parallel array write with circular shift ((i + shift) % count -> i)
private func backpermuteCircularShiftTest<T: Arbitrary & ExpressibleByIntegerLiteral & Equatable>(_: T.Type) {
    property(#function) <-
        forAllNoShrink([T].arbitrary, Int.arbitrary.suchThat { $0 >= 0 }) { (source: [T], shift: Int) in
            let expected = source.indices.map { source[($0 + shift) % source.count] }
            let actual = backpermute(from: source, count: source.count) { ($0 + shift) % source.count }
            return try? #require(expected == actual)
        }
}

/// parallel shuffle (p(i) -> i where p: xs.indices -> xs.indices is bijective, i.e. a permutation)
private func backpermuteShuffleTest<T: Arbitrary & ExpressibleByIntegerLiteral & Equatable>(_: T.Type) {
    property(#function) <-
        forAllNoShrink([T].arbitrary) { (source: [T]) in
            forAllNoShrink(Gen.fromShufflingElements(of: Array(source.indices))) { (shuffledIndices: [Int]) in
                let expected = shuffledIndices.map { source[$0] }
                let actual = backpermute(from: source, count: source.count) { shuffledIndices[$0] }
                return try? #require(expected == actual)
            }
        }
}

/// parallel strided array write (i -> i * n)
private func backpermuteStridedReadTest<T: Arbitrary & ExpressibleByIntegerLiteral & Equatable>(_: T.Type) {
    let maxSize = 256
    let intoCountGen = Gen<Int>.choose((0, maxSize))
    let strideGen = Gen<Int>.choose((1, 5))
    property(#function) <-
        forAllNoShrink(intoCountGen, strideGen) { (intoCount: Int, strideValue: Int) in
            forAllNoShrink(T.arbitrary.proliferate(withSize: intoCount * strideValue)) { (source: [T]) in
                let expected = stride(from: 0, to: source.count, by: strideValue).map { source[$0] }
                let actual = backpermute(from: source, count: intoCount) { $0 * strideValue }
                return try? #require(expected == actual)
            }
        }
}

/// extract diagonal from row-major square matrix
private func backpermuteMatrixDiagonalTest<T: Arbitrary & Equatable>(_: T.Type) {
    let maxDimension = 32
    property(#function) <-
        forAllNoShrink(Gen<Int>.choose((0, maxDimension))) { (dimension: Int) in
            forAllNoShrink(T.arbitrary.proliferate(withSize: dimension * dimension)) { (matrix: [T]) in
                let expected = (0 ..< dimension).map { i in
                    matrix[i * dimension + i]
                }
                let actual = backpermute(from: matrix, count: dimension) { i in
                    i * dimension + i
                }
                return try? #require(expected == actual)
            }
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

/// reorder indices as [0, 2, 4, ..., 1, 3, 5, ...]
private func backpermuteEvenThenOddIndicesTest<T: Arbitrary & Equatable>(_: T.Type) {
    property(#function) <-
        forAllNoShrink([T].arbitrary) { (source: [T]) in
            let expected = stride(from: 0, to: source.count, by: 2).map { source[$0] }
                + stride(from: 1, to: source.count, by: 2).map { source[$0] }
            let evenCount = (source.count + 1) / 2
            let actual = backpermute(from: source, count: source.count) { i in
                if i < evenCount {
                    return i * 2
                }
                return (i - evenCount) * 2 + 1
            }
            return try? #require(expected == actual)
        }
}

/// m x n row-major matrix transpose
private func backpermuteMatrixTransposeTest<T: Arbitrary & Equatable & ExpressibleByIntegerLiteral>(_: T.Type) {
    let maxDimension = 32
    func transposeRowMajor(_ i: Int, colCountT: Int, colCount: Int) -> Int {
        let rowT = i / colCountT
        let colT = i % colCountT
        return colT * colCount + rowT
    }
    property(#function) <-
        forAllNoShrink(Gen<Int>.choose((0, maxDimension)), Gen<Int>.choose((0, maxDimension))) { (rowCount: Int, colCount: Int) in
            forAllNoShrink(T.arbitrary.proliferate(withSize: rowCount * colCount)) { (matrix: [T]) in
                var expected: [T] = []
                for col in 0 ..< colCount {
                    for row in 0 ..< rowCount {
                        let element = matrix[row * colCount + col]
                        expected.append(element)
                    }
                }
                let actual = backpermute(from: matrix, count: matrix.count) {
                    transposeRowMajor($0, colCountT: rowCount, colCount: colCount)
                }
                return try? #require(expected == actual)
            }
        }
}

/// parallel array write with default value for out-of-bounds indices
private func backpermuteWithDefaultTest<T: Arbitrary & ExpressibleByIntegerLiteral & Equatable>(_: T.Type) {
    let maxSize = 32
    let intoCountGen = Gen<Int>.choose((0, maxSize))
    let defaultValue: T = 99
    property(#function) <-
        // TODO: (ClickUp: 86b8k3pg0) crash on from.count == 0 on the PTX backend, but not on the CPU backend
        forAllNoShrink([T].arbitrary.suchThat { $0.count > 0 }, intoCountGen) { (from: [T], intoCount: Int) in
            forAllNoShrink(Gen<Int>.choose((-from.count, from.count - 1)).proliferate(withSize: intoCount)) { (indices: [Int]) in
                let expected = indices.map { index in
                    if !from.isEmpty, index >= from.startIndex, index < from.endIndex {
                        from[index]
                    }
                    else {
                        defaultValue
                    }
                }

                let actual = backpermute(from: from, count: intoCount) { i in
                    let index = indices[i]
                    guard !from.isEmpty, index >= from.startIndex, index < from.endIndex else {
                        return Either.right(defaultValue)
                    }
                    return Either.left(index)
                }
                return try? #require(expected == actual)
            }
        }
}
