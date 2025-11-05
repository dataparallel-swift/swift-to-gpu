// Copyright (c) 2025 PassiveLogic, Inc.

import SwiftCheck

func iota(count: Int, initialValue: Int = 0) -> [Int] {
    (initialValue ..< (initialValue + count)).map(\.self)
}

func generateShuffledIndices<A>(of xs: [A]) -> Gen<[Int]> {
    Gen.fromShufflingElements(of: iota(count: xs.count))
}

func generateShuffledIndices<A>(of xs: [A], size: Int) -> Gen<[Int]> {
    // swiftlint:disable:next no_precondition
    precondition(size <= xs.count)
    return Gen.fromShufflingElements(of: iota(count: xs.count))
        .map { shuffledIndices in
            (0 ..< size).map { shuffledIndices[$0] }
        }
}

func generateShuffledIndices(count: Int) -> Gen<[Int]> {
    generateShuffledIndices(upperBound: count, count: count)
}

func generateShuffledIndices(upperBound: Int, count: Int) -> Gen<[Int]> {
    // swiftlint:disable:next no_precondition
    precondition(count <= upperBound)
    return Gen.fromShufflingElements(of: iota(count: upperBound))
        .map { shuffledIndices in
            (0 ..< count).map { shuffledIndices[$0] }
        }
}
