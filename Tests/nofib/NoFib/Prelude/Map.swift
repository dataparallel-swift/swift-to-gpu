import Testing
import Numerics
import SwiftCheck
import SwiftToPTX


// XXX: It would be nice if we could use this helper function, but unfortunately
// this is currently not possible because the plugin is currently specialising
// at the level of each `parallel_for` invocation. Thus, we would need to get
// Swift to stamp out a new copy of this function at each call site.
// Unfortunately, right now we have multiple calls to the `prop_map` function
// with a different closure `f` passed in its captured environment, and only a
// single call to `parallel_for` within the (single) implementation of
// `prop_map` within the module.
//
// @inline(__always)
// func prop_map<A: Arbitrary, B: Similar>(_ proxy: A.Type, _ f: @escaping (A) -> B) {
//     property(String(describing: A.self)) <- forAll { (xs: [A]) in
//         let expected = xs.map(f)
//         let actual   = map(xs, f)
//         return expected ~~~ actual
//     }
// }

// XXX: Using #require here rather than #expect so that we can get a return
// value to signal to swift-check whether the test passed or not.

// MARK: SignedNumeric

// @inline(never)
func prop_negate<T : Arbitrary & SignedNumeric>(_ proxy: T.Type) {
    property(String(describing: T.self)+".negate") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { x in -x }
        let actual   = map(xs) { x in -x }
        return try? #require( actual == expected )
    }
}

// @inline(never)
func prop_abs<T : Arbitrary & Comparable & SignedNumeric>(_ proxy: T.Type) {
    property(String(describing: T.self)+".abs") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { abs($0) }
        let actual   = map(xs) { abs($0) }
        return try? #require( actual == expected )
    }
}


// MARK: BinaryInteger

// @inline(never)
func prop_signum<T : Arbitrary & BinaryInteger>(_ proxy: T.Type) {
    property(String(describing: T.self)+".signum") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { $0.signum() }
        let actual   = map(xs) { $0.signum() }
        return try? #require( actual == expected )
    }
}

// @inline(never)
func prop_complement<T: Arbitrary & BinaryInteger>(_ proxy: T.Type) {
    property(String(describing: T.self)+".complement") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { ~$0 }
        let actual   = map(xs) { ~$0 }
        return try? #require( actual == expected )
    }
}

// @inline(never)
func prop_trailingZeroBitCount<T: Arbitrary & BinaryInteger>(_ proxy: T.Type) {
    property(String(describing: T.self)+".trailingZeroBitCount") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { $0.trailingZeroBitCount }
        let actual   = map(xs) { $0.trailingZeroBitCount }
        return try? #require( actual == expected )
    }
}


// MARK: FixedWidthInteger

// @inline(never)
func prop_leadingZeroBitCount<T: Arbitrary & FixedWidthInteger>(_ proxy: T.Type) {
    property(String(describing: T.self)+".leadingZeroBitCount") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { $0.leadingZeroBitCount }
        let actual   = map(xs) { $0.leadingZeroBitCount }
        return try? #require( actual == expected )
    }
}

// @inline(never)
func prop_nonzeroBitCount<T: Arbitrary & FixedWidthInteger>(_ proxy: T.Type) {
    property(String(describing: T.self)+".nonzeroBitCount") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { $0.nonzeroBitCount }
        let actual   = map(xs) { $0.nonzeroBitCount }
        return try? #require( actual == expected )
    }
}

// @inline(never)
func prop_byteSwapped<T: Arbitrary & FixedWidthInteger>(_ proxy: T.Type) {
    property(String(describing: T.self)+".byteSwapped") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { $0.byteSwapped }
        let actual   = map(xs) { $0.byteSwapped }
        return try? #require( actual == expected )
    }
}

// @inline(never)
func prop_littleEndian<T: Arbitrary & FixedWidthInteger>(_ proxy: T.Type) {
    property(String(describing: T.self)+".littleEndian") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { $0.littleEndian }
        let actual   = map(xs) { $0.littleEndian }
        return try? #require( actual == expected )
    }
}

// @inline(never)
func prop_bigEndian<T: Arbitrary & FixedWidthInteger>(_ proxy: T.Type) {
    property(String(describing: T.self)+".bigEndian") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { $0.bigEndian }
        let actual   = map(xs) { $0.bigEndian }
        return try? #require( actual == expected )
    }
}


// MARK: FloatingPoint

// @inline(never)
func prop_exponent<T: Arbitrary & FloatingPoint>(_ proxy: T.Type) {
    property(String(describing: T.self)+".exponent") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { $0.exponent }
        let actual   = map(xs) { $0.exponent }
        return try? #require( actual == expected )
    }
}

// @inline(never)
func prop_floatingPointClass<T: Arbitrary & FloatingPoint>(_ proxy: T.Type) {
    property(String(describing: T.self)+".floatingPointClass") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { $0.floatingPointClass }
        let actual   = map(xs) { $0.floatingPointClass }
        return try? #require( actual == expected )
    }
}

// @inline(never)
func prop_isCanonical<T: Arbitrary & FloatingPoint>(_ proxy: T.Type) {
    property(String(describing: T.self)+".isCanonical") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { $0.isCanonical }
        let actual   = map(xs) { $0.isCanonical }
        return try? #require( actual == expected )
    }
}

// @inline(never)
func prop_isFinite<T: Arbitrary & FloatingPoint>(_ proxy: T.Type) {
    property(String(describing: T.self)+".isFinite") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { $0.isFinite }
        let actual   = map(xs) { $0.isFinite }
        return try? #require( actual == expected )
    }
}

// @inline(never)
func prop_isInfinite<T: Arbitrary & FloatingPoint>(_ proxy: T.Type) {
    property(String(describing: T.self)+".isInfinite") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { $0.isInfinite }
        let actual   = map(xs) { $0.isInfinite }
        return try? #require( actual == expected )
    }
}

// @inline(never)
func prop_isNaN<T: Arbitrary & FloatingPoint>(_ proxy: T.Type) {
    property(String(describing: T.self)+".isNaN") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { $0.isNaN }
        let actual   = map(xs) { $0.isNaN }
        return try? #require( actual == expected )
    }
}

// @inline(never)
func prop_isSignalingNaN<T: Arbitrary & FloatingPoint>(_ proxy: T.Type) {
    property(String(describing: T.self)+".isSignalingNaN") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { $0.isSignalingNaN }
        let actual   = map(xs) { $0.isSignalingNaN }
        return try? #require( actual == expected )
    }
}

// @inline(never)
func prop_isNormal<T: Arbitrary & FloatingPoint>(_ proxy: T.Type) {
    property(String(describing: T.self)+".isNormal") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { $0.isNormal }
        let actual   = map(xs) { $0.isNormal }
        return try? #require( actual == expected )
    }
}

// @inline(never)
func prop_isSubnormal<T: Arbitrary & FloatingPoint>(_ proxy: T.Type) {
    property(String(describing: T.self)+".isSubnormal") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { $0.isSubnormal }
        let actual   = map(xs) { $0.isSubnormal }
        return try? #require( actual == expected )
    }
}

// @inline(never)
func prop_isZero<T: Arbitrary & FloatingPoint>(_ proxy: T.Type) {
    property(String(describing: T.self)+".isZero") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { $0.isZero }
        let actual   = map(xs) { $0.isZero }
        return try? #require( actual == expected )
    }
}

// @inline(never)
func prop_nextDown<T: Arbitrary & FloatingPoint>(_ proxy: T.Type) {
    property(String(describing: T.self)+".nextDown") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { $0.nextDown }
        let actual   = map(xs) { $0.nextDown }
        return try? #require( actual == expected )
    }
}

// @inline(never)
func prop_nextUp<T: Arbitrary & FloatingPoint>(_ proxy: T.Type) {
    property(String(describing: T.self)+".nextUp") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { $0.nextUp }
        let actual   = map(xs) { $0.nextUp }
        return try? #require( actual == expected )
    }
}

// @inline(never)
func prop_sign<T: Arbitrary & FloatingPoint>(_ proxy: T.Type) {
    property(String(describing: T.self)+".sign") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { $0.sign }
        let actual   = map(xs) { $0.sign }
        return try? #require( actual == expected )
    }
}

// @inline(never)
func prop_significand<T: Arbitrary & FloatingPoint>(_ proxy: T.Type) {
    property(String(describing: T.self)+".significand") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { $0.significand }
        let actual   = map(xs) { $0.significand }
        return try? #require( actual == expected )
    }
}

// @inline(never)
func prop_ulp<T: Arbitrary & FloatingPoint>(_ proxy: T.Type) {
    let gen = T.arbitrary.suchThat { !($0.isInfinite) } // Float16
    property(String(describing: T.self)+".ulp") <-
      forAllNoShrink(gen.proliferate) { (xs: [T]) in
        let expected = xs.map { $0.ulp }
        let actual   = map(xs) { $0.ulp }
        return try? #require( actual == expected )
    }
}

// @inline(never)
func prop_rounded<T: Arbitrary & FloatingPoint>(_ proxy: T.Type) {
    property(String(describing: T.self)+".rounded") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { $0.rounded() }
        let actual   = map(xs) { $0.rounded() }
        return try? #require( actual == expected )
    }
}

// Not working ):
// @inline(never)
func prop_roundedWithRoundingRule<T: Arbitrary & FloatingPoint>(_ proxy: T.Type) {
    property(String(describing: T.self)+".roundedWithRoundingRule") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink(FloatingPointRoundingRule.arbitrary) { (rule: FloatingPointRoundingRule) in
        let expected = xs.map { $0.rounded(rule) }
        let actual   = map(xs) { $0.rounded(rule) }
        return try? #require( actual == expected )
    }}
}

// @inline(never)
func prop_floor<T: Arbitrary & FloatingPoint>(_ proxy: T.Type) {
    property(String(describing: T.self)+".floor") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { $0.rounded(.down) }
        let actual   = map(xs) { $0.rounded(.down) }
        return try? #require( actual == expected )
    }
}

// @inline(never)
func prop_ceiling<T: Arbitrary & FloatingPoint>(_ proxy: T.Type) {
    property(String(describing: T.self)+".ceiling") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { $0.rounded(.up) }
        let actual   = map(xs) { $0.rounded(.up) }
        return try? #require( actual == expected )
    }
}

// @inline(never)
func prop_truncate<T: Arbitrary & FloatingPoint>(_ proxy: T.Type) {
    property(String(describing: T.self)+".truncate") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { $0.rounded(.towardZero) }
        let actual   = map(xs) { $0.rounded(.towardZero) }
        return try? #require( actual == expected )
    }
}


// MARK: swift-numerics

// @inline(never)
func prop_sqrt<T: Arbitrary & Similar & RandomType & FloatingPoint & ElementaryFunctions>(_ proxy: T.Type) {
    let gen = Gen.sized { size in Gen.choose((0, T(size))) }
    property(String(describing: T.self)+".sqrt") <-
      forAllNoShrink(gen.proliferate) { (xs: [T]) in
        let expected = xs.map { T.sqrt($0) }
        let actual   = map(xs) { T.sqrt($0) }
        return try? #require( actual ~~~ expected )
    }
}

// @inline(never)
func prop_reciprocal<T: Arbitrary & Similar & RandomType & AlgebraicField>(_ proxy: T.Type) {
    property(String(describing: T.self)+".reciprocal") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { $0.reciprocal }
        let actual   = map(xs) { $0.reciprocal }
        return try? #require( actual ~~~ expected )
    }
}

// @inline(never)
func prop_exp<T: Arbitrary & Similar & ElementaryFunctions>(_ proxy: T.Type) {
    property(String(describing: T.self)+".exp") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { T.exp($0) }
        let actual   = map(xs) { T.exp($0) }
        return try? #require( actual ~~~ expected )
    }
}

// @inline(never)
func prop_exp2<T: Arbitrary & Similar & RealFunctions>(_ proxy: T.Type) {
    property(String(describing: T.self)+".ex2p") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { T.exp2($0) }
        let actual   = map(xs) { T.exp2($0) }
        return try? #require( actual ~~~ expected )
    }
}

// @inline(never)
func prop_exp10<T: Arbitrary & Similar & RealFunctions>(_ proxy: T.Type) {
    property(String(describing: T.self)+".exp10") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { T.exp10($0) }
        let actual   = map(xs) { T.exp10($0) }
        return try? #require( actual ~~~ expected )
    }
}

// @inline(never)
func prop_expMinusOne<T: Arbitrary & Similar & ElementaryFunctions>(_ proxy: T.Type) {
    property(String(describing: T.self)+".expMinusOne") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { T.expMinusOne($0) }
        let actual   = map(xs) { T.expMinusOne($0) }
        return try? #require( actual ~~~ expected )
    }
}

// @inline(never)
func prop_log<T: Arbitrary & Similar & RandomType & FloatingPoint & ElementaryFunctions>(_ proxy: T.Type) {
    let gen = Gen.sized { size in Gen.choose((T(0).nextUp, T(size))) }
    property(String(describing: T.self)+".log") <-
      forAllNoShrink(gen.proliferate) { (xs: [T]) in
        let expected = xs.map { T.log($0) }
        let actual   = map(xs) { T.log($0) }
        return try? #require( actual ~~~ expected )
    }
}

// @inline(never)
func prop_log2<T: Arbitrary & Similar & RandomType & FloatingPoint & RealFunctions>(_ proxy: T.Type) {
    let gen = Gen.sized { size in Gen.choose((T(0).nextUp, T(size))) }
    property(String(describing: T.self)+".log2") <-
      forAllNoShrink(gen.proliferate) { (xs: [T]) in
        let expected = xs.map { T.log2($0) }
        let actual   = map(xs) { T.log2($0) }
        return try? #require( actual ~~~ expected )
    }
}

// @inline(never)
func prop_log10<T: Arbitrary & Similar & RandomType & FloatingPoint & RealFunctions>(_ proxy: T.Type) {
    let gen = Gen.sized { size in Gen.choose((T(0).nextUp, T(size))) }
    property(String(describing: T.self)+".log10") <-
      forAllNoShrink(gen.proliferate) { (xs: [T]) in
        let expected = xs.map { T.log10($0) }
        let actual   = map(xs) { T.log10($0) }
        return try? #require( actual ~~~ expected )
    }
}

// @inline(never)
func prop_logOnePlus<T: Arbitrary & Similar & RandomType & FloatingPoint & ElementaryFunctions>(_ proxy: T.Type) {
    let gen = Gen.sized { size in Gen.choose((T(-1).nextUp, T(size))) }
    property(String(describing: T.self)+".logOnePlus") <-
      forAllNoShrink(gen.proliferate) { (xs: [T]) in
        let expected = xs.map { T.log(onePlus: $0) }
        let actual   = map(xs) { T.log(onePlus: $0) }
        return try? #require( actual ~~~ expected )
    }
}

// @inline(never)
func prop_sin<T: Arbitrary & Similar & ElementaryFunctions>(_ proxy: T.Type) {
    property(String(describing: T.self)+".sin") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { T.sin($0) }
        let actual   = map(xs) { T.sin($0) }
        return try? #require( actual ~~~ expected )
    }
}

// @inline(never)
func prop_cos<T: Arbitrary & Similar & ElementaryFunctions>(_ proxy: T.Type) {
    property(String(describing: T.self)+".cos") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { T.cos($0) }
        let actual   = map(xs) { T.cos($0) }
        return try? #require( actual ~~~ expected )
    }
}

// @inline(never)
func prop_tan<T: Arbitrary & Similar & FloatingPoint & ElementaryFunctions>(_ proxy: T.Type) {
    let gen = T.arbitrary.suchThat { !($0 ~~~ 0) }
    property(String(describing: T.self)+".tan") <-
      forAllNoShrink(gen.proliferate) { (xs: [T]) in
        let expected = xs.map { T.tan($0) }
        let actual   = map(xs) { T.tan($0) }
        return try? #require( actual ~~~ expected )
    }
}

// @inline(never)
func prop_asin<T: Arbitrary & Similar & RandomType & FloatingPoint & ElementaryFunctions>(_ proxy: T.Type) {
    let gen = Gen.choose((T(-1), T(1)))
    property(String(describing: T.self)+".asin") <-
      forAllNoShrink(gen.proliferate) { (xs: [T]) in
        let expected = xs.map { T.asin($0) }
        let actual   = map(xs) { T.asin($0) }
        return try? #require( actual ~~~ expected )
    }
}

// @inline(never)
func prop_acos<T: Arbitrary & Similar & RandomType & FloatingPoint & ElementaryFunctions>(_ proxy: T.Type) {
    let gen = Gen.choose((T(-1), T(1)))
    property(String(describing: T.self)+".acos") <-
      forAllNoShrink(gen.proliferate) { (xs: [T]) in
        let expected = xs.map { T.acos($0) }
        let actual   = map(xs) { T.acos($0) }
        return try? #require( actual ~~~ expected )
    }
}

// @inline(never)
func prop_atan<T: Arbitrary & Similar & FloatingPoint & ElementaryFunctions>(_ proxy: T.Type) {
    property(String(describing: T.self)+".atan") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { T.atan($0) }
        let actual   = map(xs) { T.atan($0) }
        return try? #require( actual ~~~ expected )
    }
}

// @inline(never)
func prop_sinh<T: Arbitrary & Similar & ElementaryFunctions>(_ proxy: T.Type) {
    property(String(describing: T.self)+".sinh") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { T.sinh($0) }
        let actual   = map(xs) { T.sinh($0) }
        return try? #require( actual ~~~ expected )
    }
}

// @inline(never)
func prop_cosh<T: Arbitrary & Similar & ElementaryFunctions>(_ proxy: T.Type) {
    property(String(describing: T.self)+".cosh") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { T.cosh($0) }
        let actual   = map(xs) { T.cosh($0) }
        return try? #require( actual ~~~ expected )
    }
}

// @inline(never)
func prop_tanh<T: Arbitrary & Similar & ElementaryFunctions>(_ proxy: T.Type) {
    property(String(describing: T.self)+".tanh") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { T.tanh($0) }
        let actual   = map(xs) { T.tanh($0) }
        return try? #require( actual ~~~ expected )
    }
}

// @inline(never)
func prop_asinh<T: Arbitrary & Similar & ElementaryFunctions>(_ proxy: T.Type) {
    property(String(describing: T.self)+".asinh") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { T.asinh($0) }
        let actual   = map(xs) { T.asinh($0) }
        return try? #require( actual ~~~ expected )
    }
}

// @inline(never)
func prop_acosh<T: Arbitrary & Similar & RandomType & FloatingPoint & ElementaryFunctions>(_ proxy: T.Type) {
    let gen = Gen.sized { size in Gen.choose((T(1), T(size))) }
    property(String(describing: T.self)+".acosh") <-
      forAllNoShrink(gen.proliferate) { (xs: [T]) in
        let expected = xs.map { T.acosh($0) }
        let actual   = map(xs) { T.acosh($0) }
        return try? #require( actual ~~~ expected )
    }
}

// @inline(never)
func prop_atanh<T: Arbitrary & Similar & RandomType & FloatingPoint & ElementaryFunctions>(_ proxy: T.Type) {
    let gen = Gen.choose((T(-1), T(1)))
    property(String(describing: T.self)+".atanh") <-
      forAllNoShrink(gen.proliferate) { (xs: [T]) in
        let expected = xs.map { T.atanh($0) }
        let actual   = map(xs) { T.atanh($0) }
        return try? #require( actual ~~~ expected )
    }
}

// @inline(never)
func prop_erf<T: Arbitrary & Similar & RealFunctions>(_ proxy: T.Type) {
    property(String(describing: T.self)+".erf") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { T.erf($0) }
        let actual   = map(xs) { T.erf($0) }
        return try? #require( actual ~~~ expected )
    }
}

// @inline(never)
func prop_erfc<T: Arbitrary & Similar & RealFunctions>(_ proxy: T.Type) {
    property(String(describing: T.self)+".erfc") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { T.erfc($0) }
        let actual   = map(xs) { T.erfc($0) }
        return try? #require( actual ~~~ expected )
    }
}

// @inline(never)
func prop_gamma<T: Arbitrary & Similar & RealFunctions>(_ proxy: T.Type) {
    property(String(describing: T.self)+".gamma") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { T.gamma($0) }
        let actual   = map(xs) { T.gamma($0) }
        return try? #require( actual ~~~ expected )
    }
}

// @inline(never)
func prop_logGamma<T: Arbitrary & Similar & RealFunctions>(_ proxy: T.Type) {
    property(String(describing: T.self)+".logGamma") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { T.logGamma($0) }
        let actual   = map(xs) { T.logGamma($0) }
        return try? #require( actual ~~~ expected )
    }
}

