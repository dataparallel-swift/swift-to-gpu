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

private let logger = Logger(label: "PTXEvent")

/// An event is a marker that can be inserted into the current execution stream
/// and later queried. For example, it is can be used to signal when a kernel
/// launch completes or takes place.
///
public final class PTXEvent: EventProtocol {
    internal let rawEvent: CUevent
    // TODO: we should probably keep track of which context this event is
    // associated with; there doesn't seem a way to query this via the CUDA API.

    /// Create a new event with the given flags
    /// https://docs.nvidia.com/cuda/archive/12.6.3/cuda-driver-api/group__CUDA__EVENT.html#group__CUDA__EVENT_1g450687e75f3ff992fe01662a43d9d3db
    public init(withFlags: [CUevent_flags] = [CU_EVENT_BLOCKING_SYNC]) throws(CUDAError) {
        let zone = #Zone
        defer { zone.end() }

        // See note in PTXStream.init()
        var tmp: CUevent? = nil

        // Assumes we have an active context
        try cuda_safe_call { cuEventCreate(&tmp, withFlags.reduce(0, { $0 | $1.rawValue })) }

        // cuEventCreate will error before this is nil
        // swiftlint:disable:next force_unwrapping
        self.rawEvent = tmp!
        logger.trace(".init(withFlags: \(withFlags)) -> \(self.rawEvent)")
    }

    /// Import a raw CUDA 'CUevent'
    public init(rawEvent: CUevent) {
        let zone = #Zone
        defer { zone.end() }

        self.rawEvent = rawEvent
        logger.trace(".init(rawEvent: \(self.rawEvent))")
    }

    /// Wait for this event to be completed. This is a blocking call.
    /// https://docs.nvidia.com/cuda/archive/12.6.3/cuda-driver-api/group__CUDA__EVENT.html#group__CUDA__EVENT_1g9e520d34e51af7f5375610bca4add99c
    public func sync() throws(CUDAError) {
        let zone = #Zone
        defer { zone.end() }

        try cuda_safe_call { cuEventSynchronize(self.rawEvent) }
    }

    /// Returns 'true' if this event is complete
    /// https://docs.nvidia.com/cuda/archive/12.6.3/cuda-driver-api/group__CUDA__EVENT.html#group__CUDA__EVENT_1g6f0704d755066b0ee705749ae911deef
    public func complete() throws(CUDAError) -> Bool {
        let zone = #Zone
        defer { zone.end() }

        return try cuda_safe_async_call { cuEventQuery(self.rawEvent) }
    }

    // The event may be destroyed before it is 'complete'. In this case the call
    // does _not_ block on completion of the event, and any associated resources
    // will automatically be released asynchronously upon completion.
    deinit {
        logger.trace("Destroy event \(self.rawEvent)")
        try! cuda_safe_call { cuEventDestroy_v2(self.rawEvent) } // swiftlint:disable:this force_try
    }
}
#endif
