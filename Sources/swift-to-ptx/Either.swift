

/// The 'Either' type represents values with two possibilities: a value of type
/// 'Either<A, B>' is either '.left(A)' or '.right(B)'.
///
public enum Either<A,B> {
    case left(A)
    case right(B)

    public var isLeft: Bool {
        switch self {
            case .left: return true
            case .right: return false
        }
    }

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
            case (.left(let a),  .left(let b)):  return a == b
            case (.right(let a), .right(let b)): return a == b
            default:                             return false
        }
    }
}

extension Either: Comparable where A: Comparable, B: Comparable {
    @inlinable
    public static func < (lhs: Self, rhs: Self) -> Bool {
        switch (lhs, rhs) {
            case (.left(let a),  .left(let b)):  return a < b
            case (.left,         .right):        return true
            case (.right,        .left):         return false
            case (.right(let a), .right(let b)): return a < b
        }
    }
}

