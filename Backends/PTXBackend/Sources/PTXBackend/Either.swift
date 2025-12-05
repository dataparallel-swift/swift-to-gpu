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

// swiftlint:disable identifier_name comma

/// The 'Either' type represents values with two possibilities: a value of type
/// 'Either<A, B>' is either '.left(A)' or '.right(B)'.
///
public enum Either<A, B> {
    case left(A)
    case right(B)

    /// Returns true if the value is a 'left' value, false otherwise
    public var isLeft: Bool {
        switch self {
            case .left: return true
            case .right: return false
        }
    }

    /// Returns true if the value is a 'right' value, false otherwise
    public var isRight: Bool {
        switch self {
            case .left: return false
            case .right: return true
        }
    }
}

extension Either: Equatable where A: Equatable, B: Equatable {
    @inlinable
    public static func == (lhs: Self, rhs: Self) -> Bool {
        switch (lhs, rhs) {
            case let (.left(a), .left(b)): return a == b
            case let (.right(a), .right(b)): return a == b
            default: return false
        }
    }
}

extension Either: Comparable where A: Comparable, B: Comparable {
    @inlinable
    public static func < (lhs: Self, rhs: Self) -> Bool {
        switch (lhs, rhs) {
            case let (.left(a), .left(b)): return a < b
            case (.left, .right): return true
            case (.right, .left): return false
            case let (.right(a), .right(b)): return a < b
        }
    }
}
