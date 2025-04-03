import Testing
import Numerics
import SwiftCheck
import SwiftToPTX


// MARK: Equality

// @inline(never)
func prop_eq<T : Arbitrary & Equatable>(_ proxy: T.Type) {
    property(String(describing: T.self)+".==") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink([T].arbitrary) { (ys: [T]) in
        let expected = zip(xs, ys).map{ (x, y) in x == y }
        let actual   = zipWith(xs, ys, ==)
        return try? #require( actual == expected )
      }}
}

// @inline(never)
func prop_neq<T : Arbitrary & Equatable>(_ proxy: T.Type) {
    property(String(describing: T.self)+".!=") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink([T].arbitrary) { (ys: [T]) in
        let expected = zip(xs, ys).map{ (x, y) in x != y }
        let actual   = zipWith(xs, ys, !=)
        return try? #require( actual == expected )
      }}
}


// MARK: Comparable

// @inline(never)
func prop_lt<T : Arbitrary & Comparable>(_ proxy: T.Type) {
    property(String(describing: T.self)+".<") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink([T].arbitrary) { (ys: [T]) in
        let expected = zip(xs, ys).map{ (x, y) in x < y }
        let actual   = zipWith(xs, ys, <)
        return try? #require( actual == expected )
      }}
}

// @inline(never)
func prop_gt<T : Arbitrary & Comparable>(_ proxy: T.Type) {
    property(String(describing: T.self)+".>") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink([T].arbitrary) { (ys: [T]) in
        let expected = zip(xs, ys).map{ (x, y) in x > y }
        let actual   = zipWith(xs, ys, >)
        return try? #require( actual == expected )
      }}
}

// @inline(never)
func prop_lte<T : Arbitrary & Comparable>(_ proxy: T.Type) {
    property(String(describing: T.self)+".<=") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink([T].arbitrary) { (ys: [T]) in
        let expected = zip(xs, ys).map{ (x, y) in x <= y }
        let actual   = zipWith(xs, ys, <=)
        return try? #require( actual == expected )
      }}
}

// @inline(never)
func prop_gte<T : Arbitrary & Comparable>(_ proxy: T.Type) {
    property(String(describing: T.self)+".>=") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink([T].arbitrary) { (ys: [T]) in
        let expected = zip(xs, ys).map{ (x, y) in x >= y }
        let actual   = zipWith(xs, ys, >=)
        return try? #require( actual == expected )
      }}
}

// @inline(never)
func prop_min<T : Arbitrary & Comparable>(_ proxy: T.Type) {
    property(String(describing: T.self)+".>=") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink([T].arbitrary) { (ys: [T]) in
        let expected = zip(xs, ys).map{ (x, y) in min(x, y) }
        let actual   = zipWith(xs, ys) { (x, y) in min(x, y) }
        return try? #require( actual == expected )
      }}
}

// @inline(never)
func prop_max<T : Arbitrary & Comparable>(_ proxy: T.Type) {
    property(String(describing: T.self)+".>=") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink([T].arbitrary) { (ys: [T]) in
        let expected = zip(xs, ys).map{ (x, y) in max(x, y) }
        let actual   = zipWith(xs, ys) { (x, y) in max(x, y) }
        return try? #require( actual == expected )
      }}
}


// MARK: AdditiveArithmetic

// @inline(never)
func prop_plus<T : Arbitrary & AdditiveArithmetic>(_ proxy: T.Type) {
    property(String(describing: T.self)+".+") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink([T].arbitrary) { (ys: [T]) in
        let expected = zip(xs, ys).map{ (x, y) in x + y }
        let actual   = zipWith(xs, ys, +)
        return try? #require( actual == expected )
      }}
}

// @inline(never)
func prop_minus<T : Arbitrary & AdditiveArithmetic>(_ proxy: T.Type) {
    property(String(describing: T.self)+".-") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink([T].arbitrary) { (ys: [T]) in
        let expected = zip(xs, ys).map{ (x, y) in x - y }
        let actual   = zipWith(xs, ys, -)
        return try? #require( actual == expected )
      }}
}


// MARK: Numeric

// @inline(never)
func prop_mul<T : Arbitrary & Numeric>(_ proxy: T.Type) {
    property(String(describing: T.self)+".*") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink([T].arbitrary) { (ys: [T]) in
        let expected = zip(xs, ys).map{ (x, y) in x * y }
        let actual   = zipWith(xs, ys, *)
        return try? #require( actual == expected )
      }}
}


// MARK: BinaryInteger

// @inline(never)
func prop_quot<T : Arbitrary & BinaryInteger>(_ proxy: T.Type) {
    let gen = T.arbitrary.suchThat { !($0 == 0) }
    property(String(describing: T.self)+"./") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink(gen.proliferate) { (ys: [T]) in
        let expected = zip(xs, ys).map{ (x, y) in x / y }
        let actual   = zipWith(xs, ys, /)
        return try? #require( actual == expected )
      }}
}

// @inline(never)
func prop_rem<T : Arbitrary & BinaryInteger>(_ proxy: T.Type) {
    let gen = T.arbitrary.suchThat { !($0 == 0) }
    property(String(describing: T.self)+"./") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink(gen.proliferate) { (ys: [T]) in
        let expected = zip(xs, ys).map{ (x, y) in x % y }
        let actual   = zipWith(xs, ys, %)
        return try? #require( actual == expected )
      }}
}

// @inline(never)
func prop_quotientAndRemainder<T : Arbitrary & BinaryInteger>(_ proxy: T.Type) {
    let gen = T.arbitrary.suchThat { !($0 == 0) }
    property(String(describing: T.self)+"./") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink(gen.proliferate) { (ys: [T]) in
        let expected = zip(xs, ys).map{ (x, y) in x.quotientAndRemainder(dividingBy: y) }
        let actual   = zipWith(xs, ys) { (x, y) in x.quotientAndRemainder(dividingBy: y) }
        let r1 : ()? = try? #require( actual.map{$0.quotient}  == expected.map{$0.quotient} )
        let r2 : ()? = try? #require( actual.map{$0.remainder} == expected.map{$0.remainder} )
        return (r1 != nil && r2 != nil)
      }}
}

// @inline(never)
func prop_isMultiple<T : Arbitrary & BinaryInteger>(_ proxy: T.Type) {
    property(String(describing: T.self)+"./") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink([T].arbitrary) { (ys: [T]) in
        let expected = zip(xs, ys).map{ (x, y) in x.isMultiple(of: y) }
        let actual   = zipWith(xs, ys) { (x, y) in x.isMultiple(of: y) }
        return try? #require( actual == expected )
      }}
}

// @inline(never)
func prop_and<T : Arbitrary & BinaryInteger>(_ proxy: T.Type) {
    property(String(describing: T.self)+".&") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink([T].arbitrary) { (ys: [T]) in
        let expected = zip(xs, ys).map{ (x, y) in x & y }
        let actual   = zipWith(xs, ys, &)
        return try? #require( actual == expected )
      }}
}

// @inline(never)
func prop_or<T : Arbitrary & BinaryInteger>(_ proxy: T.Type) {
    property(String(describing: T.self)+".&") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink([T].arbitrary) { (ys: [T]) in
        let expected = zip(xs, ys).map{ (x, y) in x | y }
        let actual   = zipWith(xs, ys, |)
        return try? #require( actual == expected )
      }}
}

// @inline(never)
func prop_xor<T : Arbitrary & BinaryInteger>(_ proxy: T.Type) {
    property(String(describing: T.self)+".&") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink([T].arbitrary) { (ys: [T]) in
        let expected = zip(xs, ys).map{ (x, y) in x ^ y }
        let actual   = zipWith(xs, ys, ^)
        return try? #require( actual == expected )
      }}
}

// @inline(never)
func prop_shiftL<T : Arbitrary & BinaryInteger>(_ proxy: T.Type) {
    let gen = Gen<Int>.choose((-T.zero.bitWidth, T.zero.bitWidth))
    property(String(describing: T.self)+".<<") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink(gen.proliferate) { (ys: [Int]) in
        let expected = zip(xs, ys).map{ (x, y) in x << y }
        let actual   = zipWith(xs, ys, <<)
        return try? #require( actual == expected )
      }}
}

// @inline(never)
func prop_shiftR<T : Arbitrary & BinaryInteger>(_ proxy: T.Type) {
    let gen = Gen<Int>.choose((-T.zero.bitWidth, T.zero.bitWidth))
    property(String(describing: T.self)+".>>") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink(gen.proliferate) { (ys: [Int]) in
        let expected = zip(xs, ys).map{ (x, y) in x >> y }
        let actual   = zipWith(xs, ys, >>)
        return try? #require( actual == expected )
      }}
}

// MARK: FixedWidthInteger

// @inline(never)
func prop_uncheckedPlus<T : Arbitrary & FixedWidthInteger>(_ proxy: T.Type) {
    property(String(describing: T.self)+".&*") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink([T].arbitrary) { (ys: [T]) in
        let expected = zip(xs, ys).map{ (x, y) in x &+ y }
        let actual   = zipWith(xs, ys, &+)
        return try? #require( actual == expected )
      }}
}

// @inline(never)
func prop_uncheckedMinus<T : Arbitrary & FixedWidthInteger>(_ proxy: T.Type) {
    property(String(describing: T.self)+".&-") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink([T].arbitrary) { (ys: [T]) in
        let expected = zip(xs, ys).map{ (x, y) in x &+ y }
        let actual   = zipWith(xs, ys, &+)
        return try? #require( actual == expected )
      }}
}

// @inline(never)
func prop_uncheckedMul<T : Arbitrary & FixedWidthInteger>(_ proxy: T.Type) {
    property(String(describing: T.self)+".&*") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink([T].arbitrary) { (ys: [T]) in
        let expected = zip(xs, ys).map{ (x, y) in x &* y }
        let actual   = zipWith(xs, ys, &*)
        return try? #require( actual == expected )
      }}
}

// @inline(never)
func prop_uncheckedShiftL<T : Arbitrary & RandomType & FixedWidthInteger>(_ proxy: T.Type) {
    let gen = Gen.choose((0, T(T.zero.bitWidth)))
    property(String(describing: T.self)+".&<<") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink(gen.proliferate) { (ys: [T]) in
        let expected = zip(xs, ys).map{ (x, y) in x &<< y }
        let actual   = zipWith(xs, ys, &<<)
        return try? #require( actual == expected )
      }}
}

// @inline(never)
func prop_uncheckedShiftR<T : Arbitrary & RandomType & FixedWidthInteger>(_ proxy: T.Type) {
    let gen = Gen.choose((0, T(T.zero.bitWidth)))
    property(String(describing: T.self)+".&>>") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink(gen.proliferate) { (ys: [T]) in
        let expected = zip(xs, ys).map{ (x, y) in x &>> y }
        let actual   = zipWith(xs, ys, &>>)
        return try? #require( actual == expected )
      }}
}

// @inline(never)
func prop_addingReportingOverflow<T : Arbitrary & FixedWidthInteger>(_ proxy: T.Type) {
    property(String(describing: T.self)+".addingReportingOverflow") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink([T].arbitrary) { (ys: [T]) in
        let expected = zip(xs, ys).map{ (x, y) in x.addingReportingOverflow(y) }
        let actual   = zipWith(xs, ys) { (x, y) in x.addingReportingOverflow(y) }
        let r1 : ()? = try? #require( actual.map{$0.partialValue} == expected.map{$0.partialValue} )
        let r2 : ()? = try? #require( actual.map{$0.overflow} == expected.map{$0.overflow} )
        return (r1 != nil && r2 != nil)
      }}
}

// @inline(never)
func prop_subtractingReportingOverflow<T : Arbitrary & FixedWidthInteger>(_ proxy: T.Type) {
    property(String(describing: T.self)+".subtractingReportingOverflow") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink([T].arbitrary) { (ys: [T]) in
        let expected = zip(xs, ys).map{ (x, y) in x.subtractingReportingOverflow(y) }
        let actual   = zipWith(xs, ys) { (x, y) in x.subtractingReportingOverflow(y) }
        let r1 : ()? = try? #require( actual.map{$0.partialValue} == expected.map{$0.partialValue} )
        let r2 : ()? = try? #require( actual.map{$0.overflow} == expected.map{$0.overflow} )
        return (r1 != nil && r2 != nil)
      }}
}

// @inline(never)
func prop_multipliedReportingOverflow<T : Arbitrary & FixedWidthInteger>(_ proxy: T.Type) {
    property(String(describing: T.self)+".multipliedReportingOverflow") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink([T].arbitrary) { (ys: [T]) in
        let expected = zip(xs, ys).map{ (x, y) in x.multipliedReportingOverflow(by: y) }
        let actual   = zipWith(xs, ys) { (x, y) in x.multipliedReportingOverflow(by: y) }
        let r1 : ()? = try? #require( actual.map{$0.partialValue} == expected.map{$0.partialValue} )
        let r2 : ()? = try? #require( actual.map{$0.overflow} == expected.map{$0.overflow} )
        return (r1 != nil && r2 != nil)
      }}
}

// @inline(never)
func prop_dividedReportingOverflow<T : Arbitrary & FixedWidthInteger>(_ proxy: T.Type) {
    property(String(describing: T.self)+".dividedReportingOverflow") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink([T].arbitrary) { (ys: [T]) in
        let expected = zip(xs, ys).map{ (x, y) in x.dividedReportingOverflow(by: y) }
        let actual   = zipWith(xs, ys) { (x, y) in x.dividedReportingOverflow(by: y) }
        let r1 : ()? = try? #require( actual.map{$0.partialValue} == expected.map{$0.partialValue} )
        let r2 : ()? = try? #require( actual.map{$0.overflow} == expected.map{$0.overflow} )
        return (r1 != nil && r2 != nil)
      }}
}

// @inline(never)
func prop_remainderReportingOverflow<T : Arbitrary & FixedWidthInteger>(_ proxy: T.Type) {
    property(String(describing: T.self)+".remainderReportingOverflow") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink([T].arbitrary) { (ys: [T]) in
        let expected = zip(xs, ys).map{ (x, y) in x.remainderReportingOverflow(dividingBy: y) }
        let actual   = zipWith(xs, ys) { (x, y) in x.remainderReportingOverflow(dividingBy: y) }
        let r1 : ()? = try? #require( actual.map{$0.partialValue} == expected.map{$0.partialValue} )
        let r2 : ()? = try? #require( actual.map{$0.overflow} == expected.map{$0.overflow} )
        return (r1 != nil && r2 != nil)
      }}
}

// @inline(never)
func prop_multipliedFullWidth<T : Arbitrary & FixedWidthInteger>(_ proxy: T.Type) {
    property(String(describing: T.self)+".multipliedFullWidth") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink([T].arbitrary) { (ys: [T]) in
        let expected = zip(xs, ys).map{ (x, y) in x.multipliedFullWidth(by: y) }
        let actual   = zipWith(xs, ys) { (x, y) in x.multipliedFullWidth(by: y) }
        let r1 : ()? = try? #require( actual.map{$0.high} == expected.map{$0.high} )
        let r2 : ()? = try? #require( actual.map{$0.low} == expected.map{$0.low} )
        return (r1 != nil && r2 != nil)
      }}
}

// @inline(never)
func prop_dividingFullWidth<T : Arbitrary & FixedWidthInteger>(_ proxy: T.Type)
  where T.Magnitude: Arbitrary {
    property(String(describing: T.self)+".dividingFullWidth") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink([T].arbitrary) { (ys: [T]) in
      forAllNoShrink([T.Magnitude].arbitrary) { (zs: [T.Magnitude]) in
        let expected = zip(xs, zip(ys, zs).map{ (y, z) in (high: y, low: z) })
                        .map{ (x, yz) in x.dividingFullWidth(yz) }

        // TODO: zipWith3
        let n        = min(min(xs.count, ys.count), zs.count)
        let actual   = generate(count: n) { i in
            let x = xs[i]
            let y = ys[i]
            let z = zs[i]
            return x.dividingFullWidth((high: y, low: z))
        }

        let r1 : ()? = try? #require( actual.map{$0.quotient} == expected.map{$0.quotient} )
        let r2 : ()? = try? #require( actual.map{$0.remainder} == expected.map{$0.remainder} )
        return (r1 != nil && r2 != nil)
      }}}
}


// MARK: FloatingPoint

// @inline(never)
func prop_quot<T : Arbitrary & Similar & FloatingPoint>(_ proxy: T.Type) {
    let gen = T.arbitrary.suchThat { !($0 ~~~ 0) }
    property(String(describing: T.self)+"./") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink(gen.proliferate) { (ys: [T]) in
        let expected = zip(xs, ys).map{ (x, y) in x / y }
        let actual   = zipWith(xs, ys, /)
        return try? #require( actual ~~~ expected )
      }}
}


// MARK: swift-numerics

// @inline(never)
func prop_pow<T : Arbitrary & Similar & ElementaryFunctions>(_ proxy: T.Type) {
    property(String(describing: T.self)+"pow") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink([T].arbitrary) { (ys: [T]) in
        let expected = zip(xs, ys).map{ (x, y) in T.pow(x, y) }
        let actual   = zipWith(xs, ys) { (x, y) in T.pow(x, y) }
        return try? #require( actual ~~~ expected )
      }}
}

// @inline(never)
func prop_powi<T : Arbitrary & Similar & ElementaryFunctions>(_ proxy: T.Type) {
    property(String(describing: T.self)+"powi") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink([Int].arbitrary) { (ys: [Int]) in
        let expected = zip(xs, ys).map{ (x, y) in T.pow(x, y) }
        let actual   = zipWith(xs, ys) { (x, y) in T.pow(x, y) }
        return try? #require( actual ~~~ expected )
      }}
}

// @inline(never)
func prop_atan2<T : Arbitrary & Similar & RealFunctions>(_ proxy: T.Type) {
    property(String(describing: T.self)+"atan2") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink([T].arbitrary) { (ys: [T]) in
        let expected = zip(xs, ys).map{ (x, y) in T.atan2(y: y, x: x) }
        let actual   = zipWith(xs, ys) { (x, y) in T.atan2(y: y, x: x) }
        return try? #require( actual ~~~ expected )
      }}
}

// @inline(never)
func prop_hypot<T : Arbitrary & Similar & RealFunctions>(_ proxy: T.Type) {
    property(String(describing: T.self)+"hypot") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink([T].arbitrary) { (ys: [T]) in
        let expected = zip(xs, ys).map{ (x, y) in T.hypot(x, y) }
        let actual   = zipWith(xs, ys) { (x, y) in T.hypot(x, y) }
        return try? #require( actual ~~~ expected )
      }}
}

