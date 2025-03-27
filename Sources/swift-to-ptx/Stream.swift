import CUDA
import Tracy
import Logging
import SwiftToPTX_cbits

private let logger = Logger(label: "Stream")

// As with Event, this should probably be an interface (protocol?), that we can
// instantiate for either the CPU or GPU with appropriate (associated?) types.

// TLM: This should probably be a final class, so that we can deinit it correctly.
public struct Stream {
    internal var rawStream : CUstream

    public init(withFlags: [CUstream_flags] = []) {
        let __zone = #Zone
        defer { __zone.end() }

        // NOTE: We do some extra juggling here so that the struct will store a
        // non-optional CUstream value. This just avoids an extra inttoptr
        // instruction every time we wish to use it, making this struct
        // isomorphic to the usual CUstream and simplifying how it is used from
        // the LLVM plugin. We do the same thing with Event.
        var tmp : CUstream? = nil

        cuda_safe_call{cuCtxPushCurrent_v2(default_context)}
        cuda_safe_call{cuStreamCreate(&tmp, withFlags.reduce(0, {$0 | $1.rawValue}))}
        cuda_safe_call{cuCtxPopCurrent_v2(nil)}

        self.rawStream = tmp!   // cuStreamCreate will error before this is nil
        logger.trace(".init(withFlags: \(withFlags)) -> \(self.rawStream))")
    }

    public init(rawStream: CUstream) {
        let __zone = #Zone
        defer { __zone.end() }

        self.rawStream = rawStream
        logger.trace(".init(rawStream: \(self.rawStream))")
    }

    // Wait until the device has completed all operations in this stream.
    public func sync() {
        let __zone = #Zone
        defer { __zone.end() }

        logger.trace(".sync() \(self.rawStream)")

        cuda_safe_call{cuCtxPushCurrent_v2(default_context)}
        cuda_safe_call{cuStreamSynchronize(self.rawStream)}
        cuda_safe_call{cuCtxPopCurrent_v2(nil)}
    }

    // Capture the contents of the stream at the time of the call. Subsequent
    // calls to 'Event.complete' and 'Stream.waitOn' will examine or wait for
    // completion of the work that was captured.
    public func record() -> Event {
        let __zone = #Zone
        defer { __zone.end() }

        let event = Event.init()
        logger.trace(".record() in \(self.rawStream) -> \(event.rawEvent)")

        cuda_safe_call{cuCtxPushCurrent_v2(default_context)}
        cuda_safe_call{cuEventRecord(event.rawEvent, self.rawStream)}
        cuda_safe_call{cuCtxPopCurrent_v2(nil)}

        return event
    }

    // All future work submitted to this stream will wait for this event to
    // complete before continuing. The synchronisation will be performed
    // efficiently on the device, where possible.
    public func waitOn(event: Event) {
        let __zone = #Zone
        defer { __zone.end() }

        logger.trace(".waitOn(event: \(event.rawEvent))")

        cuda_safe_call{cuCtxPushCurrent_v2(default_context)}
        cuda_safe_call{cuStreamWaitEvent(self.rawStream, event.rawEvent, 0)}
        cuda_safe_call{cuCtxPopCurrent_v2(nil)}
    }

    // The work stream may be destroyed while the device is still doing work in
    // it. In this case the call does _not_ block on completion of the work, and
    // the resources associated with this stream will be released asynchronously
    // once the device completes work in this stream.
    public func destroy() {
        let __zone = #Zone
        defer { __zone.end() }

        logger.trace("destroy() \(self.rawStream)")

        cuda_safe_call{cuCtxPushCurrent_v2(default_context)}
        cuda_safe_call{cuStreamDestroy_v2(self.rawStream)}
        cuda_safe_call{cuCtxPopCurrent_v2(nil)}
    }
}

// https://docs.nvidia.com/cuda/archive/11.4.4/cuda-driver-api/stream-sync-behavior.html#stream-sync-behavior
// See also: driver_types.h
public let streamDefault   = unsafeBitCast(0x0, to: Stream.self)
public let streamLegacy    = unsafeBitCast(0x1, to: Stream.self)
public let streamPerThread = unsafeBitCast(0x2, to: Stream.self)

