// Copyright (c) 2025 PassiveLogic, Inc.

import SwiftCheck

extension Array {
    func generateShuffledIndices() -> Gen<[Index]> {
        Gen.fromShufflingElements(of: self.indices.map(\.self))
    }

    func generateShuffledIndices(count: Int) -> Gen<[Index]> {
        return Gen.fromShufflingElements(of: self.indices.map(\.self))
            .map(take(count))
    }

    static func generateShuffledIndices(count: Int) -> Gen<[Index]> {
        generateShuffledIndices(upTo: Index(count), count: count)
    }

    static func generateShuffledIndices(upTo: Index, count: Int) -> Gen<[Index]> {
        return Gen.fromShufflingElements(of: (0 ..< upTo).map(\.self))
            .map(take(count))
    }
}

private func take<T>(_ count: Int) -> (([T]) -> [T]) {
    return { array in
        // swiftlint:disable:next no_precondition
        precondition(count <= array.count)
        return (0 ..< count).map { array[$0] }
    }
}
