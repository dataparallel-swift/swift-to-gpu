// Copyright (c) 2025 PassiveLogic, Inc.

extension Array {
    // NOTE: [Array initialiser with typed throws]
    //
    // This is unsafe, but is currently necessary because parallel_for requires
    // typed throws, which is incompatible with this method. Technically this
    // returns an array with invalid memory, but this works for our use case of
    // "allocating" an array and then immediately filling it in with the
    // parallel_for call. Once the typed-throws version of this method lands in
    // a release, we can delete this.
    //
    // https://github.com/swiftlang/swift/pull/83160
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
