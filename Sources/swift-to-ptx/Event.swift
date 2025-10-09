// Copyright (c) 2025 PassiveLogic, Inc.

import CUDA
import Logging
import SwiftToPTX_cbits
import Tracy

private let logger = Logger(label: "Event")

/// An event in the current CUDA Context, used to signal when something like a
/// kernel launch completes or takes place
public final class Event {
    internal var rawEvent: CUevent
    // TODO: we should probably keep track of which context this event is
    // associated with; there doesn't seem a way to query this via the CUDA API.

    /// Create a new event with the given flags
    /// https://docs.nvidia.com/cuda/archive/12.6.3/cuda-driver-api/group__CUDA__EVENT.html#group__CUDA__EVENT_1g450687e75f3ff992fe01662a43d9d3db
    public init(withFlags: [CUevent_flags] = [CU_EVENT_DISABLE_TIMING]) {
        let __zone = #Zone
        defer { __zone.end() }

        // See note in Stream.init()
        var tmp: CUevent? = nil

        // Assumes we have an active context
        cuda_safe_call { cuEventCreate(&tmp, withFlags.reduce(0, { $0 | $1.rawValue })) }

        // cuEventCreate will error before this is nil
        // swiftlint:disable:next force_unwrapping
        self.rawEvent = tmp!
        logger.trace(".init(withFlags: \(withFlags)) -> \(self.rawEvent)")
    }

    /// Import a raw CUDA 'CUevent'
    public init(rawEvent: CUevent) {
        let __zone = #Zone
        defer { __zone.end() }

        self.rawEvent = rawEvent
        logger.trace(".init(rawEvent: \(self.rawEvent))")
    }

    /// Wait for this event to be completed. This is a blocking call.
    /// https://docs.nvidia.com/cuda/archive/12.6.3/cuda-driver-api/group__CUDA__EVENT.html#group__CUDA__EVENT_1g9e520d34e51af7f5375610bca4add99c
    public func sync() {
        let __zone = #Zone
        defer { __zone.end() }

        cuda_safe_call { cuEventSynchronize(self.rawEvent) }
    }

    /// Returns 'true' if this event is complete
    /// https://docs.nvidia.com/cuda/archive/12.6.3/cuda-driver-api/group__CUDA__EVENT.html#group__CUDA__EVENT_1g6f0704d755066b0ee705749ae911deef
    public func complete() -> Bool {
        let __zone = #Zone
        defer { __zone.end() }

        let status = cuEventQuery(self.rawEvent)
        let result = switch status {
            case CUDA_SUCCESS: true
            case CUDA_ERROR_NOT_READY: false
            default: { () -> Bool in
                    var name: UnsafePointer<CChar>? = nil
                    var desc: UnsafePointer<CChar>? = nil
                    cuGetErrorName(status, &name)
                    cuGetErrorString(status, &desc)
                    // swiftlint:disable:next no_fatalerror force_unwrapping
                    fatalError("CUDA call failed with error \(String(cString: name!)) (\(status.rawValue)): \(String(cString: desc!))")
                }()
        }
        return result
    }

    // The event may be destroyed before it is 'complete'. In this case the call
    // does _not_ block on completion of the event, and any associated resources
    // will automatically be released asynchronously upon completion.
    deinit {
        logger.trace("Destroy event \(self.rawEvent)")
        cuda_safe_call { cuEventDestroy_v2(self.rawEvent) }
    }
}
