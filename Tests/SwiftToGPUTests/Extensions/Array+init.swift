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

// swiftformat:disable trailingCommas
extension Array {
    // TODO: We can call `parallel_for` inside the initialization closure
    // in Swift 6.3. (https://github.com/swiftlang/swift/pull/83160).
    init(unsafeUninitializedCapacity count: Int) {
        // swiftlint:disable:next no_precondition
        precondition(count >= 0, "arrays must have non-negative sizes")
        self.init(
            unsafeUninitializedCapacity: count,
            initializingWith: { _, initializedCount in
                initializedCount = count
            },
        )
    }
}
