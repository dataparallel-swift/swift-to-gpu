// Copyright (c) 2025 PassiveLogic, Inc.

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
