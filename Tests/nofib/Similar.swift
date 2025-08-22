import Numerics

infix operator ~~~

protocol Similar {
    @inlinable
    static func ~~~ (lhs: Self, rhs: Self) -> Bool
}

extension Int8 : Similar {
    @inlinable
    static func ~~~ (lhs: Self, rhs: Self) -> Bool {
        lhs == rhs
    }
}

extension Int16 : Similar {
    @inlinable
    static func ~~~ (lhs: Self, rhs: Self) -> Bool {
        lhs == rhs
    }
}

extension Int32 : Similar {
    @inlinable
    static func ~~~ (lhs: Self, rhs: Self) -> Bool {
        lhs == rhs
    }
}

extension Int64 : Similar {
    @inlinable
    static func ~~~ (lhs: Self, rhs: Self) -> Bool {
        lhs == rhs
    }
}

extension Int128 : Similar {
    @inlinable
    static func ~~~ (lhs: Self, rhs: Self) -> Bool {
        lhs == rhs
    }
}

extension Int : Similar {
    @inlinable
    static func ~~~ (lhs: Self, rhs: Self) -> Bool {
        lhs == rhs
    }
}

extension UInt8 : Similar {
    @inlinable
    static func ~~~ (lhs: Self, rhs: Self) -> Bool {
        lhs == rhs
    }
}

extension UInt16 : Similar {
    @inlinable
    static func ~~~ (lhs: Self, rhs: Self) -> Bool {
        lhs == rhs
    }
}

extension UInt32 : Similar {
    @inlinable
    static func ~~~ (lhs: Self, rhs: Self) -> Bool {
        lhs == rhs
    }
}

extension UInt64 : Similar {
    @inlinable
    static func ~~~ (lhs: Self, rhs: Self) -> Bool {
        lhs == rhs
    }
}

extension UInt128 : Similar {
    @inlinable
    static func ~~~ (lhs: Self, rhs: Self) -> Bool {
        lhs == rhs
    }
}

extension UInt : Similar {
    @inlinable
    static func ~~~ (lhs: Self, rhs: Self) -> Bool {
        lhs == rhs
    }
}

#if arch(arm64)
extension Float16 : Similar {
    @inlinable
    static func ~~~ (lhs: Self, rhs: Self) -> Bool {
        (lhs.isInfinite && rhs.isInfinite)
        ||
        (lhs.isNaN && rhs.isNaN)
        ||
        lhs.isApproximatelyEqual(to: rhs)
        // absRelTol(epsilonAbs: 0.0001, epsilonRel: 0.01, lhs, rhs)
    }
}
#endif

extension Float32 : Similar {
    @inlinable
    static func ~~~ (lhs: Self, rhs: Self) -> Bool {
        (lhs.isInfinite && rhs.isInfinite)
        ||
        (lhs.isNaN && rhs.isNaN)
        ||
        lhs.isApproximatelyEqual(to: rhs)
        // absRelTol(epsilonAbs: 0.00001, epsilonRel: 0.001, lhs, rhs)
    }
}

extension Float64 : Similar {
    @inlinable
    static func ~~~ (lhs: Self, rhs: Self) -> Bool {
        (lhs.isInfinite && rhs.isInfinite)
        ||
        (lhs.isNaN && rhs.isNaN)
        ||
        lhs.isApproximatelyEqual(to: rhs)
        // absRelTol(epsilonAbs: 0.000001, epsilonRel: 0.0001, lhs, rhs)
    }
}

extension Optional : Similar where Wrapped : Similar {
    static func ~~~ (lhs: Self, rhs: Self) -> Bool {
        switch (lhs, rhs) {
            case (.none,        .none):        return true
            case (.some(let a), .some(let b)): return a ~~~ b
            default:                           return false
        }
    }
}

extension Array : Similar where Element : Similar {
    static func ~~~ (lhs: Self, rhs: Self) -> Bool {
        return lhs.count == rhs.count
            && zip(lhs, rhs)
              .map({ (x,y) in x ~~~ y })
              .reduce(true, { x, y in x && y })
    }
}

@inlinable
func absRelTol<A : FloatingPoint>(epsilonAbs: A, epsilonRel: A, _ u: A, _ v: A) -> Bool
{
    if u.isInfinite && v.isInfinite {
        return true
    } else if u.isNaN && v.isNaN {
        return true
    } else if abs(u - v) < epsilonAbs {
        return true
    } else if abs(u) > abs(v) {
        return abs((u-v) / u) < epsilonRel
    } else {
        return abs((v-u) / v) < epsilonRel
    }
}

