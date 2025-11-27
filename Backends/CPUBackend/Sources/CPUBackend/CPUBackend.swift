// Copyright (c) 2025 PassiveLogic, Inc.

import BackendInterface

public func parallel_for<E: Error>(
    iterations: Int,
    _ body: (Int) throws(E) -> Void
) throws(E) -> CPUEvent {
    for i in 0 ..< iterations {
        try body(i)
    }
    return CPUEvent()
}

public enum CPUError: Error {}

public struct CPUEvent: EventProtocol {
    public func sync() throws(CPUError) {}

    public func complete() throws(CPUError) -> Bool {
        true
    }
}
