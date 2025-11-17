// Copyright (c) 2025 PassiveLogic, Inc.

import SwiftCheck
import SwiftToPTX
import Testing

// TODO: something seems to be wrong with my local setup. I followed the instructions on
// https://gitlab.com/PassiveLogic/tooling/homebrew-tap/-/blob/main/README.md?ref_type=heads#getting-started
// ensured that `swiftformat --version` matches with that on CI, but the behavior seems different
// between my machine and CI  --- CK 2025-11-05
// swiftformat:disable trailingCommas
// swiftlint:disable identifier_name

@Suite("Permute") struct Permute {
    // bijective index mappings
    @Test func test_permute_copy() { prop_permute_copy(Int32.self) }
    @Test func test_permute_circular_shift() { prop_permute_circular_shift(Int32.self) }
    @Test func test_permute_shuffle() { prop_permute_shuffle(Int32.self) }
    @Test func test_permute_matrix_transpose() { prop_permute_matrix_transpose(Int32.self) }

    // injective index mappings
    @Test func test_permute_strided_write() { prop_permute_strided_write(Int32.self) }
    @Test func test_permute_shuffle_injective() { prop_permute_shuffle_injective(Int32.self) }
    @Test func test_permute_shuffle_generalized() { prop_permute_shuffle_generalized(Int32.self) }

    // element-wise combinations (bijective index mapping)
    // @Test(.bug(id: "86b7dzf83")) func test_permute_elementwise_sum() { prop_permute_elementwise_sum(Int32.self) }
    // @Test(.bug(id: "86b7dzf83")) func test_permute_elementwise_min() { prop_permute_elementwise_min(Int32.self) }

    // non-injective index mappings
    // @Test(.bug(id: "86b7dzf83")) func test_permute_group_reduce() { prop_permute_group_reduce(Int32.self) }
    // @Test(.bug(id: "86b7dzf83")) func test_permute_histogram() { prop_permute_histogram(Int32.self) }
    // @Test(.bug(id: "86b7dzf83")) func test_permute_generalized() { prop_permute_generalized(Int32.self) }
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
private func prop_permute_copy<T: Arbitrary & ExpressibleByIntegerLiteral & Equatable>(_: T.Type) {
    property("permute_copy.\(T.self)") <-
      forAllNoShrink([T].arbitrary) { (source: [T]) in
        let expected = source
        var actual: [T] = fill(count: source.count, with: 0)
        permute(from: source, into: &actual) { $0 }
        return try? #require(expected == actual)
      }
}

/// parallel array write with circular shift (i -> (i + shift) % count)
private func prop_permute_circular_shift<T: Arbitrary & ExpressibleByIntegerLiteral & Equatable>(_: T.Type) {
    property("permute_circular_shift.\(T.self)") <-
      forAllNoShrink([T].arbitrary, Int.arbitrary.suchThat { $0 >= 0 }) { (source: [T], shift: Int) in
        var expected: [T] = fill(count: source.count, with: 0)
        var actual: [T] = fill(count: source.count, with: 0)
        source.permute(into: &expected) { ($0 + shift) % source.count }
        permute(from: source, into: &actual) { ($0 + shift) % source.count }
        return try? #require(expected == actual)
      }
}

/// parallel shuffle (i -> p(i) where p: xs.indices -> xs.indices is bijective, i.e. a permutation
private func prop_permute_shuffle<T: Arbitrary & ExpressibleByIntegerLiteral & Equatable>(_: T.Type) {
    property("permute_shuffle.\(T.self)") <-
      forAllNoShrink([T].arbitrary) { (source: [T]) in
      forAllNoShrink(source.generateShuffledIndices()) { (shuffledIndices: [Int]) in
        var expected: [T] = fill(count: source.count, with: 0)
        var actual: [T] = fill(count: source.count, with: 0)
        source.permute(into: &expected) { shuffledIndices[$0] }
        permute(from: source, into: &actual) { shuffledIndices[$0] }
        return try? #require(expected == actual)
      }}
}

/// row-major matrix transpose
private func prop_permute_matrix_transpose<T: Arbitrary & Equatable & ExpressibleByIntegerLiteral>(_: T.Type) {
    let maxDimension = 256
    func transposeRowMajor(_ i: Int, rowCount: Int, colCount: Int) -> Int {
        let rowIndex = i / colCount
        let colIndex = i % colCount
        let transposedRowIndex = colIndex
        let transposedColIndex = rowIndex
        let transposedColCount = rowCount
        return transposedRowIndex * transposedColCount + transposedColIndex
    }
    property("permute_matrix_transpose.\(T.self)") <-
      forAllNoShrink(Gen<Int>.choose((1, maxDimension)), Gen<Int>.choose((1, maxDimension))) { (m: Int, n: Int) in
      forAllNoShrink(T.arbitrary.proliferate(withSize: m * n)) { (matrix: [T]) in
        var expected: [T] = fill(count: matrix.count, with: 0)
        var actual: [T] = fill(count: matrix.count, with: 0)
        matrix.permute(into: &expected) { transposeRowMajor($0, rowCount: m, colCount: n) }
        permute(from: matrix, into: &actual) { transposeRowMajor($0, rowCount: m, colCount: n) }
        return try? #require(expected == actual)
      }}
}

/// parallel strided array write (i -> i * n)
private func prop_permute_strided_write<T: Arbitrary & ExpressibleByIntegerLiteral & Equatable>(_: T.Type) {
    property("permute_strided_write.\(T.self)") <-
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
private func prop_permute_shuffle_injective<T: Arbitrary & ExpressibleByIntegerLiteral & Equatable>(_: T.Type) {
    let maxMultiplier = 3, maxOvershoot = 7
    property("permute_shuffle_generalized") <-
      forAllNoShrink(
        [T].arbitrary,
        Gen<Int>.choose((1, maxMultiplier)),
        Gen<Int>.choose((0, maxOvershoot)),
      ) { (source: [T], multiplier: Int, overshoot: Int) in
        // into.count >= source.count
        let intoCount = source.count * multiplier + overshoot
        return forAllNoShrink(
            Array<T>.generateShuffledIndices(upTo: intoCount, count: source.count)
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
private func prop_permute_shuffle_generalized<T: Arbitrary & ExpressibleByIntegerLiteral & Equatable>(_: T.Type) {
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
    property("permute_shuffle_generalized") <-
      forAllNoShrink([T].arbitrary, gen, gen) { (source: [T], n: Int, overShoot: Int) in
        // destination array is n times larger than source array
        let intoCount = source.count * n
        // permute indices can shoot past destination array bounds
        let upperBound = intoCount * overShoot
        return forAllNoShrink(
            Array<T>.generateShuffledIndices(upTo: upperBound, count: source.count)
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
private func prop_permute_elementwise_sum<T: Arbitrary & AdditiveArithmetic & Similar>(_: T.Type) {
    let maxSize = 256
    property("permute_elementwise_sum.\(T.self)") <-
      forAllNoShrink(Gen<Int>.choose((1, maxSize))) { (count: Int) in
        let gen = T.arbitrary.proliferate(withSize: count)
        return forAllNoShrink(gen, gen) { (xs: [T], ys: [T]) in
          var expected = ys
          var actual = ys
          xs.permute(into: &expected, combining: +) { $0 }
          permute(from: xs, into: &actual, combining: +) { $0 }
          return try? #require(expected == actual)
      }}
}

/// element-wise min(x, y) using permute
private func prop_permute_elementwise_min<T: Arbitrary & Comparable & ExpressibleByIntegerLiteral>(_: T.Type) {
    let maxSize = 256
    property("permute_elementwise_min.\(T.self)") <-
      forAllNoShrink(Gen<Int>.choose((1, maxSize))) { (count: Int) in
        let gen = T.arbitrary.proliferate(withSize: count)
        return forAllNoShrink(gen, gen) { (xs: [T], ys: [T]) in
          var expected = ys
          var actual = ys
          xs.permute(into: &expected, combining: min) { $0 }
          permute(from: xs, into: &actual, combining: min) { $0 }
          return try? #require(expected == actual)
      }}
}

/// y[i] += x[p[i]]
private func prop_permute_group_reduce<T: Arbitrary & AdditiveArithmetic & Similar>(_: T.Type) {
    property("permute_group_reduce.\(T.self)") <-
      forAllNoShrink([T].arbitrary, [T].arbitrary) { (from: [T], into: [T]) in
      forAllNoShrink(into.generateShuffledIndices(count: from.count)) { (indices: [Int]) in
        var expected = into
        var actual = into
        from.permute(into: &expected, combining: +) { indices[$0] }
        permute(from: from, into: &actual, combining: +) { indices[$0] }
        return try? #require(expected ~~~ actual)
      }}
}

private func prop_permute_histogram<T: Arbitrary & BinaryInteger>(_: T.Type) {
    let binsCount = 10
    property("permute_histogram") <-
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
private func prop_permute_generalized<T: Arbitrary & AdditiveArithmetic & Similar>(_: T.Type) {
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
    property("permute_generalized.\(T.self)") <-
      forAllNoShrink(
        [T].arbitrary,
        [T].arbitrary,
        Gen<Int>.choose((1, maxMultiplier)),
        Gen<Int>.choose((0, maxOvershoot)),
      ) { (from: [T], into: [T], multiplier: Int, overshoot: Int) in
      forAllNoShrink(
        Array<T>.generateShuffledIndices(upTo: into.count * multiplier + overshoot, count: from.count)
      ) { (indices: [Int]) in
        var expected = into
        var actual = into
        from.permute(into: &expected, combining: +) { p($0, indices, into.count) }
        permute(from: from, into: &actual, combining: +) { p($0, indices, into.count) }
        return try? #require(expected ~~~ actual)
      }}
}
