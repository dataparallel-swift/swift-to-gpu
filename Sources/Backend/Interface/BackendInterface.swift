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

// TODO: not sure if this is still necessary as we can hide the Stream as an implementation detail per backend (This means Event below also becomes an implementation detail once we move to an async based function for parallel_for)
public protocol StreamProtocol {
    associatedtype Event: EventProtocol
    associatedtype E: Error

    static var defaultStream: Self { get }

    func sync() throws(E)
    func record() throws(E) -> Event
    func waitOn(event: Event) throws(E)
}

public protocol ContextProtocol {
    associatedtype E: Error

    func push() throws(E)
    func pop() throws(E)
    func destroy() throws(E)
}

public protocol EventProtocol {
    associatedtype E: Error

    func sync() throws(E)
    func complete() throws(E) -> Bool
}
