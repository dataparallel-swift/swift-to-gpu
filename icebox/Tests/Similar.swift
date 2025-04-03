
protocol Similar {
    @inlinable
    static func ~= (lhs: Self, rhs: Self) -> Bool
}

extension Float : Similar {
    @inlinable
    static func ~= (lhs: Self, rhs: Self) -> Bool {
        absRelTol(epsilonAbs: 0.00001, epsilonRel: 0.001, lhs, rhs)
    }
}

extension Array : Similar where Element : Similar {
    static func ~= (lhs: Self, rhs: Self) -> Bool {
        return lhs.count == rhs.count
            && zip(lhs, rhs)
              .map({ (x,y) in x ~= y })
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

