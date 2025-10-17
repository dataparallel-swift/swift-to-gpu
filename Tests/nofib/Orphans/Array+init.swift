// Copyright (c) 2025 PassiveLogic, Inc.

// swiftformat:disable trailingCommas
extension Array {
    init(unsafeUninitializedCapacity count: Int) {
        // swiftlint:disable:next no_precondition
        precondition(count >= 0, "arrays must have non-negative sizes")
        self.init(
            unsafeUninitializedCapacity: count,
            initializingWith: { _, initializedCount in
                initializedCount = count
            },
        )
    }
}
