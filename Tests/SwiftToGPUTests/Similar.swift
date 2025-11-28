// Copyright (c) 2025 PassiveLogic, Inc.

import Numerics

infix operator ~~~

protocol Similar {
    @inlinable
    static func ~~~ (lhs: Self, rhs: Self) -> Bool
}

extension Int: Similar {
    @inlinable
    static func ~~~ (lhs: Self, rhs: Self) -> Bool {
        lhs == rhs
    }
}

extension Int8: Similar {
    @inlinable
    static func ~~~ (lhs: Self, rhs: Self) -> Bool {
        lhs == rhs
    }
}

extension Int16: Similar {
    @inlinable
    static func ~~~ (lhs: Self, rhs: Self) -> Bool {
        lhs == rhs
    }
}

extension Int32: Similar {
    @inlinable
    static func ~~~ (lhs: Self, rhs: Self) -> Bool {
        lhs == rhs
    }
}

extension Int64: Similar {
    @inlinable
    static func ~~~ (lhs: Self, rhs: Self) -> Bool {
        lhs == rhs
    }
}

extension Int128: Similar {
    @inlinable
    static func ~~~ (lhs: Self, rhs: Self) -> Bool {
        lhs == rhs
    }
}

extension UInt: Similar {
    @inlinable
    static func ~~~ (lhs: Self, rhs: Self) -> Bool {
        lhs == rhs
    }
}

extension UInt8: Similar {
    @inlinable
    static func ~~~ (lhs: Self, rhs: Self) -> Bool {
        lhs == rhs
    }
}

extension UInt16: Similar {
    @inlinable
    static func ~~~ (lhs: Self, rhs: Self) -> Bool {
        lhs == rhs
    }
}

extension UInt32: Similar {
    @inlinable
    static func ~~~ (lhs: Self, rhs: Self) -> Bool {
        lhs == rhs
    }
}

extension UInt64: Similar {
    @inlinable
    static func ~~~ (lhs: Self, rhs: Self) -> Bool {
        lhs == rhs
    }
}

extension UInt128: Similar {
    @inlinable
    static func ~~~ (lhs: Self, rhs: Self) -> Bool {
        lhs == rhs
    }
}

#if arch(arm64)
extension Float16: Similar {
    @inlinable
    static func ~~~ (lhs: Self, rhs: Self) -> Bool {
        // swiftformat:disable indent
        (lhs.isInfinite && rhs.isInfinite)
        ||
        (lhs.isNaN && rhs.isNaN)
        ||
        lhs.isApproximatelyEqual(to: rhs)
        // absRelTol(epsilonAbs: 0.0001, epsilonRel: 0.01, lhs, rhs)
        // swiftformat:enable indent
    }
}
#endif

extension Float32: Similar {
    @inlinable
    static func ~~~ (lhs: Self, rhs: Self) -> Bool {
        // swiftformat:disable indent
        (lhs.isInfinite && rhs.isInfinite)
        ||
        (lhs.isNaN && rhs.isNaN)
        ||
        lhs.isApproximatelyEqual(to: rhs)
        // absRelTol(epsilonAbs: 0.00001, epsilonRel: 0.001, lhs, rhs)
        // swiftformat:enable indent
    }
}

extension Float64: Similar {
    @inlinable
    static func ~~~ (lhs: Self, rhs: Self) -> Bool {
        // swiftformat:disable indent
        (lhs.isInfinite && rhs.isInfinite)
        ||
        (lhs.isNaN && rhs.isNaN)
        ||
        lhs.isApproximatelyEqual(to: rhs)
        // absRelTol(epsilonAbs: 0.000001, epsilonRel: 0.0001, lhs, rhs)
        // swiftformat:enable indent
    }
}

extension Optional: Similar where Wrapped: Similar {
    static func ~~~ (lhs: Self, rhs: Self) -> Bool {
        switch (lhs, rhs) {
            case (.none, .none): return true
            case let (.some(x), .some(y)): return x ~~~ y
            default: return false
        }
    }
}

extension Array: Similar where Element: Similar {
    static func ~~~ (lhs: Self, rhs: Self) -> Bool {
        return lhs.count == rhs.count
            && zip(lhs, rhs)
            .map({ x, y in x ~~~ y })
            .allSatisfy({ $0 })
    }
}

@inlinable
func absRelTol<A: FloatingPoint>(epsilonAbs: A, epsilonRel: A, _ lhs: A, _ rhs: A) -> Bool {
    if lhs.isInfinite && rhs.isInfinite {
        return true
    }
    else if lhs.isNaN && rhs.isNaN {
        return true
    }
    else if abs(lhs - rhs) < epsilonAbs {
        return true
    }
    else if abs(lhs) > abs(rhs) {
        return abs((lhs - rhs) / lhs) < epsilonRel
    }
    else {
        return abs((rhs - lhs) / rhs) < epsilonRel
    }
}
