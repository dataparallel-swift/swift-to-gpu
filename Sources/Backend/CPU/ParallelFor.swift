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
