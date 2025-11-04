// Copyright (c) 2025 PassiveLogic, Inc.

// swiftformat:disable trailingCommas
extension Array {
    // TODO: We can call `parallel_for` inside the initialization closure
    // in Swift 6.3. (https://github.com/swiftlang/swift/pull/83160).
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
