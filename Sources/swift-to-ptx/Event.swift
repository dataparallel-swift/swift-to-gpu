import CUDA
import Tracy
import Logging
import SwiftToPTX_cbits

private let logger = Logger(label: "Event")

public final class Event {
    internal var rawEvent : CUevent
    // TODO: we should probably keep track of which context this event is
    // associated with; there doesn't seem a way to query this via the CUDA API.

    public init(withFlags: [CUevent_flags] = [CU_EVENT_DISABLE_TIMING]) {
        let __zone = #Zone
        defer { __zone.end() }

        // See note in Stream.init()
        var tmp : CUevent? = nil

        // Assumes we have an active context
        cuda_safe_call{cuEventCreate(&tmp, withFlags.reduce(0, {$0 | $1.rawValue}))}

        self.rawEvent = tmp!    // cuEventCreate will error before this is nil
        logger.trace(".init(withFlags: \(withFlags)) -> \(self.rawEvent)")
    }

    public init(rawEvent: CUevent) {
        let __zone = #Zone
        defer { __zone.end() }

        self.rawEvent = rawEvent
        logger.trace(".init(rawEvent: \(self.rawEvent))")
    }

    // Wait for this event to be completed. This is a blocking call.
    public func sync() {
        let __zone = #Zone
        defer { __zone.end() }

        cuda_safe_call{cuEventSynchronize(self.rawEvent)}
    }

    // Returns 'true' if this event is complete
    public func complete() -> Bool {
        let __zone = #Zone
        defer { __zone.end() }

        let status = cuEventQuery(self.rawEvent)
        let result = switch status {
            case CUDA_SUCCESS: true
            case CUDA_ERROR_NOT_READY: false
            default: { () -> Bool in
                var name : UnsafePointer<CChar>? = nil
                var desc : UnsafePointer<CChar>? = nil
                cuGetErrorName(status, &name)
                cuGetErrorString(status, &desc)
                fatalError("CUDA call failed with error \(String.init(cString: name!)) (\(status.rawValue)): \(String.init(cString: desc!))")
            }()
        }
        return result
    }

    // The event may be destroyed before it is 'complete'. In this case the call
    // does _not_ block on completion of the event, and any associated resources
    // will automatically be released asynchronously upon completion.
    deinit {
        logger.trace("Destroy event \(self.rawEvent)")
        cuda_safe_call{cuEventDestroy_v2(self.rawEvent)}
    }
}

