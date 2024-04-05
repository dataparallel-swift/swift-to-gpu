import CUDA

public class Event {
    var rawEvent : CUevent? = nil

    public init(withFlags: [CUevent_flags] = [CU_EVENT_DISABLE_TIMING]) {
        cuda_safe_call{cuEventCreate(&self.rawEvent, withFlags.reduce(0, {$0 | $1.rawValue}))}
    }

    public init(rawEvent: CUevent) {
        self.rawEvent = rawEvent
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

    deinit {
        cuda_safe_call{cuEventDestroy_v2(self.rawEvent)}
    }
}

