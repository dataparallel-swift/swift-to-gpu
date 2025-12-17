// Copyright (c) 2025 The swift-to-gpu authors. All rights reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#if PTX
import BackendInterface
import CUDA
import Logging
import PTXBackendC
import Tracy

private let logger = Logger(label: "PTXStream")

// TLM: This should probably be a final class, so that we can deinit it
// correctly.

/// A processing stream. Think of this as a single 'thread' of execution. All
/// operations in a (non-default) stream are synchronous and executed in
/// sequence, but operations in different streams may happen out-of-order or
/// concurrently with one another.
///
/// Use 'Event's to synchronise operations between streams.
///
public struct PTXStream: StreamProtocol {
    internal let rawStream: CUstream

    public static let defaultStream: PTXStream = streamPerThread

    /// Create a new execution stream with the given flags
    /// https://docs.nvidia.com/cuda/archive/12.6.3/cuda-driver-api/group__CUDA__STREAM.html#group__CUDA__STREAM_1ga581f0c5833e21ded8b5a56594e243f4
    public init(withFlags: [CUstream_flags] = []) throws(CUDAError) {
        let zone = #Zone
        defer { zone.end() }

        // NOTE: We do some extra juggling here so that the struct will store a
        // non-optional CUstream value. This just avoids an extra inttoptr
        // instruction every time we wish to use it, making this struct
        // isomorphic to the usual CUstream and simplifying how it is used from
        // the LLVM plugin. We do the same thing with Event.
        var tmp: CUstream? = nil

        // Assumes we have an active context
        try cuda_safe_call { cuStreamCreate(&tmp, withFlags.reduce(0, { $0 | $1.rawValue })) }

        // cuStreamCreate will error before this is nil
        // swiftlint:disable:next force_unwrapping
        self.rawStream = tmp!
        logger.trace(".init(withFlags: \(withFlags)) -> \(self.rawStream))")
    }

    /// Import a raw CUDA 'CUstream'
    public init(rawStream: CUstream) {
        let zone = #Zone
        defer { zone.end() }

        self.rawStream = rawStream
        logger.trace(".init(rawStream: \(self.rawStream))")
    }

    /// Wait until the device has completed all operations in this stream.
    /// https://docs.nvidia.com/cuda/archive/12.6.3/cuda-driver-api/group__CUDA__STREAM.html#group__CUDA__STREAM_1g15e49dd91ec15991eb7c0a741beb7dad
    public func sync() throws(CUDAError) {
        let zone = #Zone
        defer { zone.end() }

        logger.trace(".sync() \(self.rawStream)")
        try cuda_safe_call { cuStreamSynchronize(self.rawStream) }
    }

    /// Capture the contents of the stream at the time of the call. Subsequent
    /// calls to 'Event.complete' and 'Stream.waitOn' will examine or wait for
    /// completion of the work that was captured.
    /// https://docs.nvidia.com/cuda/archive/12.6.3/cuda-driver-api/group__CUDA__EVENT.html#group__CUDA__EVENT_1g95424d3be52c4eb95d83861b70fb89d1
    public func record() throws(CUDAError) -> PTXEvent {
        let zone = #Zone
        defer { zone.end() }

        let event = try PTXEvent()
        logger.trace(".record() in \(self.rawStream) -> \(event.rawEvent)")
        try cuda_safe_call { cuEventRecord(event.rawEvent, self.rawStream) }

        return event
    }

    /// All future work submitted to this stream will wait for this event to
    /// complete before continuing. The synchronisation will be performed
    /// efficiently on the device, where possible.
    /// https://docs.nvidia.com/cuda/archive/12.6.3/cuda-driver-api/group__CUDA__STREAM.html#group__CUDA__STREAM_1g6a898b652dfc6aa1d5c8d97062618b2f
    public func waitOn(event: PTXEvent) throws(CUDAError) {
        let zone = #Zone
        defer { zone.end() }

        logger.trace(".waitOn(event: \(event.rawEvent))")
        try cuda_safe_call { cuStreamWaitEvent(self.rawStream, event.rawEvent, 0) }
    }

    /// The work stream may be destroyed while the device is still doing work in
    /// it. In this case the call does _not_ block on completion of the work, and
    /// the resources associated with this stream will be released asynchronously
    /// once the device completes work in this stream.
    /// https://docs.nvidia.com/cuda/archive/12.6.3/cuda-driver-api/group__CUDA__STREAM.html#group__CUDA__STREAM_1g244c8833de4596bcd31a06cdf21ee758
    public func destroy() throws(CUDAError) {
        let zone = #Zone
        defer { zone.end() }

        logger.trace("destroy() \(self.rawStream)")
        try cuda_safe_call { cuStreamDestroy_v2(self.rawStream) }
    }
}

// https://docs.nvidia.com/cuda/archive/12.6.3/cuda-driver-api/stream-sync-behavior.html#stream-sync-behavior
// See also: driver_types.h

/// The default stream, used by APIs that operate on a stream implicitly, and
/// can be configured to have either legacy or per-thread synchronisation
/// behaviour.
public let streamDefault = unsafeBitCast(0x0, to: PTXStream.self)

/// The legacy default stream is an implicit stream which synchronizes with all
/// other streams in the same 'Context', except for non-blocking streams. When
/// an action is taken in the legacy stream such as a kernel launch or 'waitOn',
/// the legacy stream first waits on all blocking streams, the action is queued
/// in the legacy stream, and then all blocking streams wait on the legacy
/// stream.
public let streamLegacy = unsafeBitCast(0x1, to: PTXStream.self)

/// The per-thread default stream is an implicit stream local to both the thread
/// and the 'Context', and which does not synchronize with other streams (just
/// like explicitly created streams). The per-thread default stream is not a
/// non-blocking stream and will synchronize with the legacy default stream if
/// both are used in a program.
public let streamPerThread = unsafeBitCast(0x2, to: PTXStream.self)
#endif
