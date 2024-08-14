import CUDA
import Logging

private let logger = Logger(label: "Event")

public final class Event {
    internal var rawEvent : CUevent

    public init(withFlags: [CUevent_flags] = [CU_EVENT_DISABLE_TIMING]) {
        // See note in Stream.init()
        var tmp : CUevent? = nil
        cuda_safe_call{cuEventCreate(&tmp, withFlags.reduce(0, {$0 | $1.rawValue}))}
        self.rawEvent = tmp!    // cuEventCreate will error before this is nil
        logger.trace(".init(withFlags: \(withFlags)) -> \(self.rawEvent)")
    }

    public init(rawEvent: CUevent) {
        self.rawEvent = rawEvent
        logger.trace(".init(rawEvent: \(self.rawEvent))")
    }

    // Wait for this event to be completed. This is a blocking call.
    public func sync() {
        cuda_safe_call{cuEventSynchronize(self.rawEvent)}
    }

    // Returns 'true' if this event is complete
    public func complete() -> Bool {
        let result = cuEventQuery(self.rawEvent)
        switch result {
            case CUDA_SUCCESS: return true
            case CUDA_ERROR_NOT_READY: return false
            default:
                var name : UnsafePointer<CChar>? = nil
                var desc : UnsafePointer<CChar>? = nil
                cuGetErrorName(result, &name)
                cuGetErrorString(result, &desc)
                fatalError("CUDA call failed with error \(String.init(cString: name!)) (\(result.rawValue)): \(String.init(cString: desc!))")
        }
    }

    // The event may be destroyed before it is 'complete'. In this case the call
    // does _not_ block on completion of the event, and any associated resources
    // will automatically be released asynchronously upon completion.
    deinit {
        logger.trace("Destroy event \(self.rawEvent)")
        cuda_safe_call{cuEventDestroy_v2(self.rawEvent)}
    }
}

