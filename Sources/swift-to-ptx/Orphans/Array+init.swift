// Copyright (c) 2025 PassiveLogic, Inc.

extension Array {
    @usableFromInline
    init(unsafeUninitializedCapacity count: Int) {
        // swiftlint:disable:next no_precondition
        precondition(count >= 0, "arrays must have non-negative sizes")
        self.init(
            unsafeUninitializedCapacity: count,
            initializingWith: { _, initializedCount in
                initializedCount = count
            }
        )
    }

    @usableFromInline
    init(count: Int, generator: @escaping (Int) -> Element) {
        // swiftlint:disable:next no_precondition
        precondition(count >= 0, "arrays must have non-negative sizes")
        self.init(
            unsafeUninitializedCapacity: count,
            initializingWith: { buffer, initializedCount in
                for i in 0 ..< count {
                    buffer.initializeElement(at: i, to: generator(i))
                }
                initializedCount = count
            }
        )
    }
}
