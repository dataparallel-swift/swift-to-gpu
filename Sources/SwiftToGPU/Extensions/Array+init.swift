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

extension Array {
    // NOTE: [Array initialiser with typed throws]
    //
    // This is unsafe, but is currently necessary because parallel_for requires
    // typed throws, which is incompatible with this method. Technically this
    // returns an array with invalid memory, but this works for our use case of
    // "allocating" an array and then immediately filling it in with the
    // parallel_for call. Once the typed-throws version of this method lands in
    // a release, we can delete this.
    //
    // https://github.com/swiftlang/swift/pull/83160
    @usableFromInline
    init(unsafeUninitializedCapacity count: Int) {
        // swiftlint:disable:next no_precondition
        precondition(count >= 0, "arrays must have non-negative sizes")
        self.init(
            unsafeUninitializedCapacity: count,
            initializingWith: { _, initializedCount in
                initializedCount = count
            }
        )
    }
}
