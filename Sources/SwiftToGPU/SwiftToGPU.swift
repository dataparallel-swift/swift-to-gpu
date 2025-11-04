// Copyright (c) 2025 PassiveLogic, Inc.

import BackendInterface

#if CPU
import CPUBackend

public func parallel_for<E: Error>(
    iterations: Int,
    _ body: (Int) throws(E) -> Void
) throws(E) -> CPUEvent {
    try CPUBackend.parallel_for(iterations: iterations, body)
}
#endif

#if PTX
import PTXBackend

public func parallel_for<E: Error>(
    iterations: Int,
    _ body: (Int) throws(E) -> Void
) throws(E) -> PTXEvent {
    try PTXBackend.parallel_for(iterations: iterations, body)
}
#endif
