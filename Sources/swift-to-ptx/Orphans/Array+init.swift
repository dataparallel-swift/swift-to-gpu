
extension Array {
    @usableFromInline
    init(unsafeUninitializedCapacity count: Int) {
        precondition(count >= 0, "arrays must have non-negative sizes")
        self.init(
            unsafeUninitializedCapacity: count,
            initializingWith: { _, initializedCount in
                initializedCount = count
            })
    }

    @usableFromInline
    init(count: Int, generator: @escaping (Int) -> Element) {
        precondition(count >= 0, "arrays must have non-negative sizes")
        self.init()
        self.reserveCapacity(count)
        for i in 0..<count {
            self.append(generator(i))
        }

        // In principle this code should also work, but we are getting SIGSEGV in
        // swift_release(), atomic.c:265 for counts > 5. No idea why this is.
        // self.init(
        //     unsafeUninitializedCapacity: count,
        //     initializingWith: { buffer, initializedCount in
        //         for i in 0..<count {
        //             buffer[i] = generator(i)
        //         }
        //         initializedCount = count
        //     })
    }
}

