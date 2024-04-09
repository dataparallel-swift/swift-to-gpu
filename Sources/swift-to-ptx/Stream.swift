import CUDA

// As with Event, this should probably be an interface (protocol?), that we can
// instantiate for either the CPU or GPU with appropriate (associated?) types.

public struct Stream {
    internal var rawStream : CUstream? = nil

    public init(withFlags: [CUstream_flags] = []) {
        cuda_safe_call{cuStreamCreate(&rawStream,  withFlags.reduce(0, {$0 | $1.rawValue}))}
    }

    public init(rawStream: CUstream) {
        self.rawStream = rawStream
    }

    // Wait until the device has completed all operations in this stream.
    public func sync() {
        cuda_safe_call{cuStreamSynchronize(self.rawStream)}
    }

    // Capture the contents of the stream at the time of the call. Subsequent
    // calls to 'Event.complete' and 'Stream.waitOn' will examine or wait for
    // completion of the work that was captured.
    public func record() -> Event {
        let event = Event.init()
        cuda_safe_call{cuEventRecord(event.rawEvent, self.rawStream)}
        return event
    }

    // All future work submitted to this stream will wait for this event to
    // complete before continuing. The synchronisation will be performed
    // efficiently on the device, where possible.
    public func waitOn(event: Event) {
        cuda_safe_call{cuStreamWaitEvent(self.rawStream, event.rawEvent, 0)}
    }

    // The work stream may be destroyed while the device is still doing work in
    // it. In this case the call does _not_ block on completion of the work, and
    // the resources associated with this stream will be released asynchronously
    // once the device completes work in this stream.
    public func destroy() {
        cuda_safe_call{cuStreamDestroy_v2(self.rawStream)}
    }
}

// https://docs.nvidia.com/cuda/archive/11.4.4/cuda-driver-api/stream-sync-behavior.html#stream-sync-behavior
public let streamDefault   = Stream.init(rawStream: OpaquePointer(bitPattern: 0)!)
public let streamLegacy    = Stream.init(rawStream: OpaquePointer(bitPattern: 0x1)!)
public let streamPerThread = Stream.init(rawStream: OpaquePointer(bitPattern: 0x2)!)

