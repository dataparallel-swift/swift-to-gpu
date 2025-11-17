// Copyright (c) 2025 PassiveLogic, Inc.

import SwiftCheck

extension Array {
    func generateShuffledIndices() -> Gen<[Index]> {
        Gen.fromShufflingElements(of: self.indices.map(\.self))
    }

    func generateShuffledIndices(count: Int) -> Gen<[Index]> {
        // swiftlint:disable:next no_precondition
        precondition(count <= self.count)
        return Gen.fromShufflingElements(of: self.indices.map(\.self))
            .map { shuffledIndices in
                (0 ..< count).map { shuffledIndices[$0] }
            }
    }

    static func generateShuffledIndices(count: Int) -> Gen<[Index]> {
        generateShuffledIndices(upTo: Index(count), count: count)
    }

    static func generateShuffledIndices(upTo: Index, count: Int) -> Gen<[Index]> {
        // swiftlint:disable:next no_precondition
        precondition(count <= upTo)
        return Gen.fromShufflingElements(of: (0 ..< upTo).map(\.self))
            .map { shuffledIndices in
                (0 ..< count).map { shuffledIndices[$0] }
            }
    }
}
