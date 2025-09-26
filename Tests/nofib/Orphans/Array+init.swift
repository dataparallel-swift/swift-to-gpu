extension Array {
    init(unsafeUninitializedCapacity count: Int) {
        precondition(count >= 0, "arrays must have non-negative sizes")
        self.init(
            unsafeUninitializedCapacity: count,
            initializingWith: { _, initializedCount in
                initializedCount = count
            })
    }
}
