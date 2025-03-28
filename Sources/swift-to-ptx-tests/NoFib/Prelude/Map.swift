import Testing
import Numerics
import SwiftCheck
import SwiftToPTX

@Suite("no-fib/Prelude/map") struct MapTests {
    @Suite("map/Int8") struct Int8Tests {
        @Test("Int8/negate") func test_negate() { prop_negate(Int8.self) }
        @Test("Int8/abs") func test_abs() { prop_abs(Int8.self) }
        @Test("Int8/signum") func test_signum() { prop_signum(Int8.self) }
        @Test("Int8/complement") func test_complement() { prop_complement(Int8.self) }
        @Test("Int8/zeroBitCount") func test_nonzeroBitCount() { prop_nonzeroBitCount(Int8.self) }
        @Test("Int8/leadingZeroBitCount") func test_leadingZeroBitCount() { prop_leadingZeroBitCount(Int8.self) }
        @Test("Int8/trailingZeroBitCount") func test_trailingZeroBitCount() { prop_trailingZeroBitCount(Int8.self) }
        @Test("Int8/byteSwapped") func test_byteSwapped() { prop_byteSwapped(Int8.self) }
        @Test("Int8/littleEndian") func test_littleEndian() { prop_littleEndian(Int8.self) }
        @Test("Int8/bigEndian") func test_bigEndian() { prop_bigEndian(Int8.self) }
    }

    @Suite("map/Int16") struct Int16Tests {
        @Test("Int16/negate") func test_negate() { prop_negate(Int16.self) }
        @Test("Int16/abs") func test_abs() { prop_abs(Int16.self) }
        @Test("Int16/signum") func test_signum() { prop_signum(Int16.self) }
        @Test("Int16/complement") func test_complement() { prop_complement(Int16.self) }
        @Test("Int16/zeroBitCount") func test_nonzeroBitCount() { prop_nonzeroBitCount(Int16.self) }
        @Test("Int16/leadingZeroBitCount") func test_leadingZeroBitCount() { prop_leadingZeroBitCount(Int16.self) }
        @Test("Int16/trailingZeroBitCount") func test_trailingZeroBitCount() { prop_trailingZeroBitCount(Int16.self) }
        @Test("Int16/byteSwapped") func test_byteSwapped() { prop_byteSwapped(Int16.self) }
        @Test("Int16/littleEndian") func test_littleEndian() { prop_littleEndian(Int16.self) }
        @Test("Int16/bigEndian") func test_bigEndian() { prop_bigEndian(Int16.self) }
    }

    @Suite("map/Int32") struct Int32Tests {
        @Test("Int32/negate") func test_negate() { prop_negate(Int32.self) }
        @Test("Int32/abs") func test_abs() { prop_abs(Int32.self) }
        @Test("Int32/signum") func test_signum() { prop_signum(Int32.self) }
        @Test("Int32/complement") func test_complement() { prop_complement(Int32.self) }
        @Test("Int32/zeroBitCount") func test_nonzeroBitCount() { prop_nonzeroBitCount(Int32.self) }
        @Test("Int32/leadingZeroBitCount") func test_leadingZeroBitCount() { prop_leadingZeroBitCount(Int32.self) }
        @Test("Int32/trailingZeroBitCount") func test_trailingZeroBitCount() { prop_trailingZeroBitCount(Int32.self) }
        @Test("Int32/byteSwapped") func test_byteSwapped() { prop_byteSwapped(Int32.self) }
        @Test("Int32/littleEndian") func test_littleEndian() { prop_littleEndian(Int32.self) }
        @Test("Int32/bigEndian") func test_bigEndian() { prop_bigEndian(Int32.self) }
    }

    @Suite("map/Int64") struct Int64Tests {
        @Test("Int64/negate") func test_negate() { prop_negate(Int64.self) }
        @Test("Int64/abs") func test_abs() { prop_abs(Int64.self) }
        @Test("Int64/signum") func test_signum() { prop_signum(Int64.self) }
        @Test("Int64/complement") func test_complement() { prop_complement(Int64.self) }
        @Test("Int64/zeroBitCount") func test_nonzeroBitCount() { prop_nonzeroBitCount(Int64.self) }
        @Test("Int64/leadingZeroBitCount") func test_leadingZeroBitCount() { prop_leadingZeroBitCount(Int64.self) }
        @Test("Int64/trailingZeroBitCount") func test_trailingZeroBitCount() { prop_trailingZeroBitCount(Int64.self) }
        @Test("Int64/byteSwapped") func test_byteSwapped() { prop_byteSwapped(Int64.self) }
        @Test("Int64/littleEndian") func test_littleEndian() { prop_littleEndian(Int64.self) }
        @Test("Int64/bigEndian") func test_bigEndian() { prop_bigEndian(Int64.self) }
    }

    @Suite("map/UInt8") struct UInt8Tests {
        @Test("UInt8/signum") func test_signum() { prop_signum(UInt8.self) }
        @Test("UInt8/complement") func test_complement() { prop_complement(UInt8.self) }
        // @Test("UInt8/zeroBitCount") func test_nonzeroBitCount() { prop_nonzeroBitCount(UInt8.self) }
        // @Test("UInt8/leadingZeroBitCount") func test_leadingZeroBitCount() { prop_leadingZeroBitCount(UInt8.self) }
        // @Test("UInt8/trailingZeroBitCount") func test_trailingZeroBitCount() { prop_trailingZeroBitCount(UInt8.self) }
        @Test("UInt8/byteSwapped") func test_byteSwapped() { prop_byteSwapped(UInt8.self) }
        @Test("UInt8/littleEndian") func test_littleEndian() { prop_littleEndian(UInt8.self) }
        @Test("UInt8/bigEndian") func test_bigEndian() { prop_bigEndian(UInt8.self) }
    }

    @Suite("map/UInt16") struct UInt16Tests {
        @Test("UInt16/signum") func test_signum() { prop_signum(UInt16.self) }
        @Test("UInt16/complement") func test_complement() { prop_complement(UInt16.self) }
        // @Test("UInt16/zeroBitCount") func test_nonzeroBitCount() { prop_nonzeroBitCount(UInt16.self) }
        // @Test("UInt16/leadingZeroBitCount") func test_leadingZeroBitCount() { prop_leadingZeroBitCount(UInt16.self) }
        // @Test("UInt16/trailingZeroBitCount") func test_trailingZeroBitCount() { prop_trailingZeroBitCount(UInt16.self) }
        @Test("UInt16/byteSwapped") func test_byteSwapped() { prop_byteSwapped(UInt16.self) }
        @Test("UInt16/littleEndian") func test_littleEndian() { prop_littleEndian(UInt16.self) }
        @Test("UInt16/bigEndian") func test_bigEndian() { prop_bigEndian(UInt16.self) }
    }

    @Suite("UInt32") struct UInt32Tests {
        @Test("UInt32/signum") func test_signum() { prop_signum(UInt32.self) }
        @Test("UInt32/complement") func test_complement() { prop_complement(UInt32.self) }
        // @Test("UInt32/zeroBitCount") func test_nonzeroBitCount() { prop_nonzeroBitCount(UInt32.self) }
        // @Test("UInt32/leadingZeroBitCount") func test_leadingZeroBitCount() { prop_leadingZeroBitCount(UInt32.self) }
        // @Test("UInt32/trailingZeroBitCount") func test_trailingZeroBitCount() { prop_trailingZeroBitCount(UInt32.self) }
        @Test("UInt32/byteSwapped") func test_byteSwapped() { prop_byteSwapped(UInt32.self) }
        @Test("UInt32/littleEndian") func test_littleEndian() { prop_littleEndian(UInt32.self) }
        @Test("UInt32/bigEndian") func test_bigEndian() { prop_bigEndian(UInt32.self) }
    }

    @Suite("UInt64") struct UInt64Tests {
        @Test("UInt64/signum") func test_signum() { prop_signum(UInt64.self) }
        @Test("UInt64/complement") func test_complement() { prop_complement(UInt64.self) }
        // @Test("UInt64/zeroBitCount") func test_nonzeroBitCount() { prop_nonzeroBitCount(UInt64.self) }
        // @Test("UInt64/leadingZeroBitCount") func test_leadingZeroBitCount() { prop_leadingZeroBitCount(UInt64.self) }
        // @Test("UInt64/trailingZeroBitCount") func test_trailingZeroBitCount() { prop_trailingZeroBitCount(UInt64.self) }
        @Test("UInt64/byteSwapped") func test_byteSwapped() { prop_byteSwapped(UInt64.self) }
        @Test("UInt64/littleEndian") func test_littleEndian() { prop_littleEndian(UInt64.self) }
        @Test("UInt64/bigEndian") func test_bigEndian() { prop_bigEndian(UInt64.self) }
    }

    @Suite("map/Float16") struct Float16Tests {
        @Test("Float16/negate") func test_negate() { prop_negate(Float16.self) }
        @Test("Float16/abs") func test_abs() { prop_abs(Float16.self) }
        @Test("Float16/exponent") func test_exponent() { prop_exponent(Float16.self) }
        @Test("Float16/floatingPointClass") func test_floatingPointClass() { prop_floatingPointClass(Float16.self) }
        // @Test("Float16/isCanonical") func test_isCanonical() { prop_isCanonical(Float16.self) }
        @Test("Float16/isFinite") func test_isFinite() { prop_isFinite(Float16.self) }
        @Test("Float16/isInfinite") func test_isInfinite() { prop_isInfinite(Float16.self) }
        @Test("Float16/isNaN") func test_isNaN() { prop_isNaN(Float16.self) }
        @Test("Float16/isSignalingNaN") func test_isSignalingNaN() { prop_isSignalingNaN(Float16.self) }
        @Test("Float16/isNormal") func test_isNormal() { prop_isNormal(Float16.self) }
        @Test("Float16/isSubnormal") func test_isSubnormal() { prop_isSubnormal(Float16.self) }
        @Test("Float16/isZero") func test_isZero() { prop_isZero(Float16.self) }
        @Test("Float16/nextDown") func test_nextDown() { prop_nextDown(Float16.self) }
        @Test("Float16/nextUp") func test_nextUp() { prop_nextUp(Float16.self) }
        @Test("Float16/sign") func test_sign() { prop_sign(Float16.self) }
        @Test("Float16/significand") func test_significand() { prop_significand(Float16.self) }
        @Test("Float16/ulp") func test_ulp() { prop_ulp(Float16.self) }
        @Test("Float16/rounded") func test_rounded() { prop_rounded(Float16.self) }
        // @Test("Float16/roundedRule") func test_roundedRWithRoundingRule() { prop_roundedWithRoundingRule(Float16.self) }
        @Test("Float16/floor") func test_floor() { prop_floor(Float16.self) }
        @Test("Float16/ceiling") func test_ceiling() { prop_ceiling(Float16.self) }
        @Test("Float16/truncate") func test_truncate() { prop_truncate(Float16.self) }
        @Test("Float16/sqrt") func test_sqrt() { prop_sqrt(Float16.self) }
        @Test("Float16/reciprocal") func test_reciprocal() { prop_reciprocal(Float16.self) }
        @Test("Float16/exp") func test_exp() { prop_exp(Float16.self) }
        @Test("Float16/exp2") func test_exp2() { prop_exp2(Float16.self) }
        @Test("Float16/exp10") func test_exp10() { prop_exp10(Float16.self) }
        @Test("Float16/expMinusOne") func test_expMinusOne() { prop_expMinusOne(Float16.self) }
        @Test("Float16/log") func test_log() { prop_log(Float16.self) }
        @Test("Float16/log2") func test_log2() { prop_log2(Float16.self) }
        @Test("Float16/log10") func test_log10() { prop_log10(Float16.self) }
        @Test("Float16/logOnePlus") func test_logOnePlus() { prop_logOnePlus(Float16.self) }
        @Test("Float16/sin") func test_sin() { prop_sin(Float16.self) }
        @Test("Float16/cos") func test_cos() { prop_cos(Float16.self) }
        @Test("Float16/tan") func test_tan() { prop_tan(Float16.self) }
        @Test("Float16/asin") func test_asin() { prop_asin(Float16.self) }
        @Test("Float16/acos") func test_acos() { prop_acos(Float16.self) }
        @Test("Float16/atan") func test_atan() { prop_atan(Float16.self) }
        @Test("Float16/sinh") func test_sinh() { prop_sinh(Float16.self) }
        @Test("Float16/cosh") func test_cosh() { prop_cosh(Float16.self) }
        @Test("Float16/tanh") func test_tanh() { prop_tanh(Float16.self) }
        @Test("Float16/asinh") func test_asinh() { prop_asinh(Float16.self) }
        @Test("Float16/acosh") func test_acosh() { prop_acosh(Float16.self) }
        @Test("Float16/atanh") func test_atanh() { prop_atanh(Float16.self) }
        @Test("Float16/erf") func test_erf() { prop_erf(Float16.self) }
        @Test("Float16/erfc") func test_erfc() { prop_erfc(Float16.self) }
        @Test("Float16/gamma") func test_gamma() { prop_gamma(Float16.self) }
        @Test("Float16/logGamma") func test_logGamma() { prop_logGamma(Float16.self) }
    }

    @Suite("map/Float32") struct Float32Tests {
        @Test("Float32/negate") func test_negate() { prop_negate(Float32.self) }
        @Test("Float32/abs") func test_abs() { prop_abs(Float.self) }
        @Test("Float32/exponent") func test_exponent() { prop_exponent(Float.self) }
        @Test("Float32/floatingPointClass") func test_floatingPointClass() { prop_floatingPointClass(Float.self) }
        // @Test("Float32/isCanonical") func test_isCanonical() { prop_isCanonical(Float.self) }
        @Test("Float32/isFinite") func test_isFinite() { prop_isFinite(Float.self) }
        @Test("Float32/isInfinite") func test_isInfinite() { prop_isInfinite(Float.self) }
        @Test("Float32/isNaN") func test_isNaN() { prop_isNaN(Float.self) }
        @Test("Float32/isSignalingNaN") func test_isSignalingNaN() { prop_isSignalingNaN(Float.self) }
        @Test("Float32/isNormal") func test_isNormal() { prop_isNormal(Float.self) }
        @Test("Float32/isSubnormal") func test_isSubnormal() { prop_isSubnormal(Float.self) }
        @Test("Float32/isZero") func test_isZero() { prop_isZero(Float.self) }
        @Test("Float32/nextDown") func test_nextDown() { prop_nextDown(Float.self) }
        @Test("Float32/nextUp") func test_nextUp() { prop_nextUp(Float.self) }
        @Test("Float32/sign") func test_sign() { prop_sign(Float.self) }
        @Test("Float32/significand") func test_significand() { prop_significand(Float.self) }
        @Test("Float32/ulp") func test_ulp() { prop_ulp(Float.self) }
        @Test("Float32/rounded") func test_rounded() { prop_rounded(Float.self) }
        // @Test("Float32/roundedRule") func test_roundedRWithRoundingRule() { prop_roundedWithRoundingRule(Float.self) }
        @Test("Float32/floor") func test_floor() { prop_floor(Float.self) }
        @Test("Float32/ceiling") func test_ceiling() { prop_ceiling(Float.self) }
        @Test("Float32/truncate") func test_truncate() { prop_truncate(Float.self) }
        @Test("Float32/sqrt") func test_sqrt() { prop_sqrt(Float.self) }
        @Test("Float32/reciprocal") func test_reciprocal() { prop_reciprocal(Float32.self) }
        @Test("Float32/exp") func test_exp() { prop_exp(Float32.self) }
        @Test("Float32/exp2") func test_exp2() { prop_exp2(Float32.self) }
        @Test("Float32/exp10") func test_exp10() { prop_exp10(Float32.self) }
        @Test("Float32/expMinusOne") func test_expMinusOne() { prop_expMinusOne(Float32.self) }
        @Test("Float32/log") func test_log() { prop_log(Float32.self) }
        @Test("Float32/log2") func test_log2() { prop_log2(Float32.self) }
        @Test("Float32/log10") func test_log10() { prop_log10(Float32.self) }
        @Test("Float32/logOnePlus") func test_logOnePlus() { prop_logOnePlus(Float32.self) }
        @Test("Float32/sin") func test_sin() { prop_sin(Float32.self) }
        @Test("Float32/cos") func test_cos() { prop_cos(Float32.self) }
        @Test("Float32/tan") func test_tan() { prop_tan(Float32.self) }
        @Test("Float32/asin") func test_asin() { prop_asin(Float32.self) }
        @Test("Float32/acos") func test_acos() { prop_acos(Float32.self) }
        @Test("Float32/atan") func test_atan() { prop_atan(Float32.self) }
        @Test("Float32/sinh") func test_sinh() { prop_sinh(Float32.self) }
        @Test("Float32/cosh") func test_cosh() { prop_cosh(Float32.self) }
        @Test("Float32/tanh") func test_tanh() { prop_tanh(Float32.self) }
        @Test("Float32/asinh") func test_asinh() { prop_asinh(Float32.self) }
        @Test("Float32/acosh") func test_acosh() { prop_acosh(Float32.self) }
        @Test("Float32/atanh") func test_atanh() { prop_atanh(Float32.self) }
        @Test("Float32/erf") func test_erf() { prop_erf(Float32.self) }
        @Test("Float32/erfc") func test_erfc() { prop_erfc(Float32.self) }
        @Test("Float32/gamma") func test_gamma() { prop_gamma(Float32.self) }
        @Test("Float32/logGamma") func test_logGamma() { prop_logGamma(Float32.self) }
    }

    @Suite("map/Float64") struct Float64Tests {
        @Test("Float64/negate") func test_negate() { prop_negate(Float64.self) }
        @Test("Float64/abs") func test_abs() { prop_abs(Float64.self) }
        @Test("Float64/exponent") func test_exponent() { prop_exponent(Float64.self) }
        @Test("Float64/floatingPointClass") func test_floatingPointClass() { prop_floatingPointClass(Float64.self) }
        // @Test("Float64/isCanonical") func test_isCanonical() { prop_isCanonical(Float64.self) }
        @Test("Float64/isFinite") func test_isFinite() { prop_isFinite(Float64.self) }
        @Test("Float64/isInfinite") func test_isInfinite() { prop_isInfinite(Float64.self) }
        @Test("Float64/isNaN") func test_isNaN() { prop_isNaN(Float64.self) }
        @Test("Float64/isSignalingNaN") func test_isSignalingNaN() { prop_isSignalingNaN(Float64.self) }
        @Test("Float64/isNormal") func test_isNormal() { prop_isNormal(Float64.self) }
        @Test("Float64/isSubnormal") func test_isSubnormal() { prop_isSubnormal(Float64.self) }
        @Test("Float64/isZero") func test_isZero() { prop_isZero(Float64.self) }
        @Test("Float64/nextDown") func test_nextDown() { prop_nextDown(Float64.self) }
        @Test("Float64/nextUp") func test_nextUp() { prop_nextUp(Float64.self) }
        @Test("Float64/sign") func test_sign() { prop_sign(Float64.self) }
        @Test("Float64/significand") func test_significand() { prop_significand(Float64.self) }
        @Test("Float64/ulp") func test_ulp() { prop_ulp(Float64.self) }
        @Test("Float64/rounded") func test_rounded() { prop_rounded(Float64.self) }
        // @Test("Float64/roundedRule") func test_roundedRWithRoundingRule() { prop_roundedWithRoundingRule(Float64.self) }
        @Test("Float64/floor") func test_floor() { prop_floor(Float64.self) }
        @Test("Float64/ceiling") func test_ceiling() { prop_ceiling(Float64.self) }
        @Test("Float64/truncate") func test_truncate() { prop_truncate(Float64.self) }
        @Test("Float64/sqrt") func test_sqrt() { prop_sqrt(Float64.self) }
        @Test("Float64/reciprocal") func test_reciprocal() { prop_reciprocal(Float64.self) }
        @Test("Float64/exp") func test_exp() { prop_exp(Float64.self) }
        @Test("Float64/exp2") func test_exp2() { prop_exp2(Float64.self) }
        @Test("Float64/exp10") func test_exp10() { prop_exp10(Float64.self) }
        @Test("Float64/expMinusOne") func test_expMinusOne() { prop_expMinusOne(Float64.self) }
        @Test("Float64/log") func test_log() { prop_log(Float64.self) }
        @Test("Float64/log2") func test_log2() { prop_log2(Float64.self) }
        @Test("Float64/log10") func test_log10() { prop_log10(Float64.self) }
        @Test("Float64/logOnePlus") func test_logOnePlus() { prop_logOnePlus(Float64.self) }
        @Test("Float64/sin") func test_sin() { prop_sin(Float64.self) }
        @Test("Float64/cos") func test_cos() { prop_cos(Float64.self) }
        @Test("Float64/tan") func test_tan() { prop_tan(Float64.self) }
        @Test("Float64/asin") func test_asin() { prop_asin(Float64.self) }
        @Test("Float64/acos") func test_acos() { prop_acos(Float64.self) }
        @Test("Float64/atan") func test_atan() { prop_atan(Float64.self) }
        @Test("Float64/sinh") func test_sinh() { prop_sinh(Float64.self) }
        @Test("Float64/cosh") func test_cosh() { prop_cosh(Float64.self) }
        @Test("Float64/tanh") func test_tanh() { prop_tanh(Float64.self) }
        @Test("Float64/asinh") func test_asinh() { prop_asinh(Float64.self) }
        @Test("Float64/acosh") func test_acosh() { prop_acosh(Float64.self) }
        @Test("Float64/atanh") func test_atanh() { prop_atanh(Float64.self) }
        @Test("Float64/erf") func test_erf() { prop_erf(Float64.self) }
        @Test("Float64/erfc") func test_erfc() { prop_erfc(Float64.self) }
        @Test("Float64/gamma") func test_gamma() { prop_gamma(Float64.self) }
        @Test("Float64/logGamma") func test_logGamma() { prop_logGamma(Float64.self) }
    }
}

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
@inline(never)
func prop_negate<T : Arbitrary & SignedNumeric>(_ proxy: T.Type) {
    property(String(describing: T.self)+"/negate") <- forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { x in -x }
        let actual   = map(xs) { x in -x }
        return try? #require( actual == expected )
    }
}

@inline(never)
func prop_abs<T : Arbitrary & Comparable & SignedNumeric>(_ proxy: T.Type) {
    property(String(describing: T.self)+"/abs") <- forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { abs($0) }
        let actual   = map(xs) { abs($0) }
        return try? #require( actual == expected )
    }
}

@inline(never)
func prop_signum<T : Arbitrary & BinaryInteger>(_ proxy: T.Type) {
    property(String(describing: T.self)+"/signum") <- forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { $0.signum() }
        let actual   = map(xs) { $0.signum() }
        return try? #require( actual == expected )
    }
}

@inline(never)
func prop_complement<T: Arbitrary & BinaryInteger>(_ proxy: T.Type) {
    property(String(describing: T.self)+"/complement") <- forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { ~$0 }
        let actual   = map(xs) { ~$0 }
        return try? #require( actual == expected )
    }
}

@inline(never)
func prop_nonzeroBitCount<T: Arbitrary & FixedWidthInteger>(_ proxy: T.Type) {
    property(String(describing: T.self)+"/nonzeroBitCount") <- forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { $0.nonzeroBitCount }
        let actual   = map(xs) { $0.nonzeroBitCount }
        return try? #require( actual == expected )
    }
}

@inline(never)
func prop_leadingZeroBitCount<T: Arbitrary & FixedWidthInteger>(_ proxy: T.Type) {
    property(String(describing: T.self)+"/leadingZeroBitCount") <- forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { $0.leadingZeroBitCount }
        let actual   = map(xs) { $0.leadingZeroBitCount }
        return try? #require( actual == expected )
    }
}

@inline(never)
func prop_trailingZeroBitCount<T: Arbitrary & BinaryInteger>(_ proxy: T.Type) {
    property(String(describing: T.self)+"/trailingZeroBitCount") <- forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { $0.trailingZeroBitCount }
        let actual   = map(xs) { $0.trailingZeroBitCount }
        return try? #require( actual == expected )
    }
}

@inline(never)
func prop_byteSwapped<T: Arbitrary & FixedWidthInteger>(_ proxy: T.Type) {
    property(String(describing: T.self)+"/byteSwapped") <- forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { $0.byteSwapped }
        let actual   = map(xs) { $0.byteSwapped }
        return try? #require( actual == expected )
    }
}

@inline(never)
func prop_littleEndian<T: Arbitrary & FixedWidthInteger>(_ proxy: T.Type) {
    property(String(describing: T.self)+"/littleEndian") <- forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { $0.littleEndian }
        let actual   = map(xs) { $0.littleEndian }
        return try? #require( actual == expected )
    }
}

@inline(never)
func prop_bigEndian<T: Arbitrary & FixedWidthInteger>(_ proxy: T.Type) {
    property(String(describing: T.self)+"/bigEndian") <- forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { $0.bigEndian }
        let actual   = map(xs) { $0.bigEndian }
        return try? #require( actual == expected )
    }
}

@inline(never)
func prop_exponent<T: Arbitrary & FloatingPoint>(_ proxy: T.Type) {
    property(String(describing: T.self)+"/exponent") <- forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { $0.exponent }
        let actual   = map(xs) { $0.exponent }
        return try? #require( actual == expected )
    }
}

@inline(never)
func prop_floatingPointClass<T: Arbitrary & FloatingPoint>(_ proxy: T.Type) {
    property(String(describing: T.self)+"/floatingPointClass") <- forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { $0.floatingPointClass }
        let actual   = map(xs) { $0.floatingPointClass }
        return try? #require( actual == expected )
    }
}

@inline(never)
func prop_isCanonical<T: Arbitrary & FloatingPoint>(_ proxy: T.Type) {
    property(String(describing: T.self)+"/isCanonical") <- forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { $0.isCanonical }
        let actual   = map(xs) { $0.isCanonical }
        return try? #require( actual == expected )
    }
}

@inline(never)
func prop_isFinite<T: Arbitrary & FloatingPoint>(_ proxy: T.Type) {
    property(String(describing: T.self)+"/isFinite") <- forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { $0.isFinite }
        let actual   = map(xs) { $0.isFinite }
        return try? #require( actual == expected )
    }
}

@inline(never)
func prop_isInfinite<T: Arbitrary & FloatingPoint>(_ proxy: T.Type) {
    property(String(describing: T.self)+"/isInfinite") <- forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { $0.isInfinite }
        let actual   = map(xs) { $0.isInfinite }
        return try? #require( actual == expected )
    }
}

@inline(never)
func prop_isNaN<T: Arbitrary & FloatingPoint>(_ proxy: T.Type) {
    property(String(describing: T.self)+"/isNaN") <- forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { $0.isNaN }
        let actual   = map(xs) { $0.isNaN }
        return try? #require( actual == expected )
    }
}

@inline(never)
func prop_isSignalingNaN<T: Arbitrary & FloatingPoint>(_ proxy: T.Type) {
    property(String(describing: T.self)+"/isSignalingNaN") <- forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { $0.isSignalingNaN }
        let actual   = map(xs) { $0.isSignalingNaN }
        return try? #require( actual == expected )
    }
}

@inline(never)
func prop_isNormal<T: Arbitrary & FloatingPoint>(_ proxy: T.Type) {
    property(String(describing: T.self)+"/isNormal") <- forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { $0.isNormal }
        let actual   = map(xs) { $0.isNormal }
        return try? #require( actual == expected )
    }
}

@inline(never)
func prop_isSubnormal<T: Arbitrary & FloatingPoint>(_ proxy: T.Type) {
    property(String(describing: T.self)+"/isSubnormal") <- forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { $0.isSubnormal }
        let actual   = map(xs) { $0.isSubnormal }
        return try? #require( actual == expected )
    }
}

@inline(never)
func prop_isZero<T: Arbitrary & FloatingPoint>(_ proxy: T.Type) {
    property(String(describing: T.self)+"/isZero") <- forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { $0.isZero }
        let actual   = map(xs) { $0.isZero }
        return try? #require( actual == expected )
    }
}

@inline(never)
func prop_nextDown<T: Arbitrary & FloatingPoint>(_ proxy: T.Type) {
    property(String(describing: T.self)+"/nextDown") <- forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { $0.nextDown }
        let actual   = map(xs) { $0.nextDown }
        return try? #require( actual == expected )
    }
}

@inline(never)
func prop_nextUp<T: Arbitrary & FloatingPoint>(_ proxy: T.Type) {
    property(String(describing: T.self)+"/nextUp") <- forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { $0.nextUp }
        let actual   = map(xs) { $0.nextUp }
        return try? #require( actual == expected )
    }
}

@inline(never)
func prop_sign<T: Arbitrary & FloatingPoint>(_ proxy: T.Type) {
    property(String(describing: T.self)+"/sign") <- forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { $0.sign }
        let actual   = map(xs) { $0.sign }
        return try? #require( actual == expected )
    }
}

@inline(never)
func prop_significand<T: Arbitrary & FloatingPoint>(_ proxy: T.Type) {
    property(String(describing: T.self)+"/significand") <- forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { $0.significand }
        let actual   = map(xs) { $0.significand }
        return try? #require( actual == expected )
    }
}

@inline(never)
func prop_ulp<T: Arbitrary & FloatingPoint>(_ proxy: T.Type) {
    property(String(describing: T.self)+"/ulp") <- forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { $0.ulp }
        let actual   = map(xs) { $0.ulp }
        return try? #require( actual == expected )
    }
}

@inline(never)
func prop_rounded<T: Arbitrary & FloatingPoint>(_ proxy: T.Type) {
    property(String(describing: T.self)+"/rounded") <- forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { $0.rounded() }
        let actual   = map(xs) { $0.rounded() }
        return try? #require( actual == expected )
    }
}

// Not working ):
@inline(never)
func prop_roundedWithRoundingRule<T: Arbitrary & FloatingPoint>(_ proxy: T.Type) {
    property(String(describing: T.self)+"/roundedWithRoundingRule") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink(FloatingPointRoundingRule.arbitrary) { (rule: FloatingPointRoundingRule) in
        let expected = xs.map { $0.rounded(rule) }
        let actual   = map(xs) { $0.rounded(rule) }
        return try? #require( actual == expected )
    }}
}

@inline(never)
func prop_floor<T: Arbitrary & FloatingPoint>(_ proxy: T.Type) {
    property(String(describing: T.self)+"/floor") <- forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { $0.rounded(.down) }
        let actual   = map(xs) { $0.rounded(.down) }
        return try? #require( actual == expected )
    }
}

@inline(never)
func prop_ceiling<T: Arbitrary & FloatingPoint>(_ proxy: T.Type) {
    property(String(describing: T.self)+"/ceiling") <- forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { $0.rounded(.up) }
        let actual   = map(xs) { $0.rounded(.up) }
        return try? #require( actual == expected )
    }
}

@inline(never)
func prop_truncate<T: Arbitrary & FloatingPoint>(_ proxy: T.Type) {
    property(String(describing: T.self)+"/truncate") <- forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { $0.rounded(.towardZero) }
        let actual   = map(xs) { $0.rounded(.towardZero) }
        return try? #require( actual == expected )
    }
}

@inline(never)
func prop_sqrt<T: Arbitrary & Similar & RandomType & FloatingPoint & ElementaryFunctions>(_ proxy: T.Type) {
    let gen = Gen.sized { size in Gen.choose((0, T(size))) }
    property(String(describing: T.self)+"/sqrt") <- forAllNoShrink(gen.proliferate) { (xs: [T]) in
        let expected = xs.map { T.sqrt($0) }
        let actual   = map(xs) { T.sqrt($0) }
        return try? #require( actual ~~~ expected )
    }
}

@inline(never)
func prop_reciprocal<T: Arbitrary & Similar & RandomType & AlgebraicField>(_ proxy: T.Type) {
    property(String(describing: T.self)+"/reciprocal") <- forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { $0.reciprocal }
        let actual   = map(xs) { $0.reciprocal }
        return try? #require( actual ~~~ expected )
    }
}

@inline(never)
func prop_exp<T: Arbitrary & Similar & ElementaryFunctions>(_ proxy: T.Type) {
    property(String(describing: T.self)+"/exp") <- forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { T.exp($0) }
        let actual   = map(xs) { T.exp($0) }
        return try? #require( actual ~~~ expected )
    }
}

@inline(never)
func prop_exp2<T: Arbitrary & Similar & RealFunctions>(_ proxy: T.Type) {
    property(String(describing: T.self)+"/ex2p") <- forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { T.exp2($0) }
        let actual   = map(xs) { T.exp2($0) }
        return try? #require( actual ~~~ expected )
    }
}

@inline(never)
func prop_exp10<T: Arbitrary & Similar & RealFunctions>(_ proxy: T.Type) {
    property(String(describing: T.self)+"/exp10") <- forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { T.exp10($0) }
        let actual   = map(xs) { T.exp10($0) }
        return try? #require( actual ~~~ expected )
    }
}

@inline(never)
func prop_expMinusOne<T: Arbitrary & Similar & ElementaryFunctions>(_ proxy: T.Type) {
    property(String(describing: T.self)+"/expMinusOne") <- forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { T.expMinusOne($0) }
        let actual   = map(xs) { T.expMinusOne($0) }
        return try? #require( actual ~~~ expected )
    }
}

@inline(never)
func prop_log<T: Arbitrary & Similar & RandomType & FloatingPoint & ElementaryFunctions>(_ proxy: T.Type) {
    let gen = Gen.sized { size in Gen.choose((T(0).nextUp, T(size))) }
    property(String(describing: T.self)+"/log") <- forAllNoShrink(gen.proliferate) { (xs: [T]) in
        let expected = xs.map { T.log($0) }
        let actual   = map(xs) { T.log($0) }
        return try? #require( actual ~~~ expected )
    }
}

@inline(never)
func prop_log2<T: Arbitrary & Similar & RandomType & FloatingPoint & RealFunctions>(_ proxy: T.Type) {
    let gen = Gen.sized { size in Gen.choose((T(0).nextUp, T(size))) }
    property(String(describing: T.self)+"/log2") <- forAllNoShrink(gen.proliferate) { (xs: [T]) in
        let expected = xs.map { T.log2($0) }
        let actual   = map(xs) { T.log2($0) }
        return try? #require( actual ~~~ expected )
    }
}

@inline(never)
func prop_log10<T: Arbitrary & Similar & RandomType & FloatingPoint & RealFunctions>(_ proxy: T.Type) {
    let gen = Gen.sized { size in Gen.choose((T(0).nextUp, T(size))) }
    property(String(describing: T.self)+"/log10") <- forAllNoShrink(gen.proliferate) { (xs: [T]) in
        let expected = xs.map { T.log10($0) }
        let actual   = map(xs) { T.log10($0) }
        return try? #require( actual ~~~ expected )
    }
}

@inline(never)
func prop_logOnePlus<T: Arbitrary & Similar & RandomType & FloatingPoint & ElementaryFunctions>(_ proxy: T.Type) {
    let gen = Gen.sized { size in Gen.choose((T(-1).nextUp, T(size))) }
    property(String(describing: T.self)+"/logOnePlus") <- forAllNoShrink(gen.proliferate) { (xs: [T]) in
        let expected = xs.map { T.log(onePlus: $0) }
        let actual   = map(xs) { T.log(onePlus: $0) }
        return try? #require( actual ~~~ expected )
    }
}

@inline(never)
func prop_sin<T: Arbitrary & Similar & ElementaryFunctions>(_ proxy: T.Type) {
    property(String(describing: T.self)+"/sin") <- forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { T.sin($0) }
        let actual   = map(xs) { T.sin($0) }
        return try? #require( actual ~~~ expected )
    }
}

@inline(never)
func prop_cos<T: Arbitrary & Similar & ElementaryFunctions>(_ proxy: T.Type) {
    property(String(describing: T.self)+"/cos") <- forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { T.cos($0) }
        let actual   = map(xs) { T.cos($0) }
        return try? #require( actual ~~~ expected )
    }
}

@inline(never)
func prop_tan<T: Arbitrary & Similar & FloatingPoint & ElementaryFunctions>(_ proxy: T.Type) {
    let gen = T.arbitrary.suchThat { !($0 ~~~ 0) }
    property(String(describing: T.self)+"/tan") <- forAllNoShrink(gen.proliferate) { (xs: [T]) in
        let expected = xs.map { T.tan($0) }
        let actual   = map(xs) { T.tan($0) }
        return try? #require( actual ~~~ expected )
    }
}

@inline(never)
func prop_asin<T: Arbitrary & Similar & RandomType & FloatingPoint & ElementaryFunctions>(_ proxy: T.Type) {
    let gen = Gen.choose((T(-1), T(1)))
    property(String(describing: T.self)+"/asin") <- forAllNoShrink(gen.proliferate) { (xs: [T]) in
        let expected = xs.map { T.asin($0) }
        let actual   = map(xs) { T.asin($0) }
        return try? #require( actual ~~~ expected )
    }
}

@inline(never)
func prop_acos<T: Arbitrary & Similar & RandomType & FloatingPoint & ElementaryFunctions>(_ proxy: T.Type) {
    let gen = Gen.choose((T(-1), T(1)))
    property(String(describing: T.self)+"/acos") <- forAllNoShrink(gen.proliferate) { (xs: [T]) in
        let expected = xs.map { T.acos($0) }
        let actual   = map(xs) { T.acos($0) }
        return try? #require( actual ~~~ expected )
    }
}

@inline(never)
func prop_atan<T: Arbitrary & Similar & FloatingPoint & ElementaryFunctions>(_ proxy: T.Type) {
    property(String(describing: T.self)+"/atan") <- forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { T.atan($0) }
        let actual   = map(xs) { T.atan($0) }
        return try? #require( actual ~~~ expected )
    }
}

@inline(never)
func prop_sinh<T: Arbitrary & Similar & ElementaryFunctions>(_ proxy: T.Type) {
    property(String(describing: T.self)+"/sinh") <- forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { T.sinh($0) }
        let actual   = map(xs) { T.sinh($0) }
        return try? #require( actual ~~~ expected )
    }
}

@inline(never)
func prop_cosh<T: Arbitrary & Similar & ElementaryFunctions>(_ proxy: T.Type) {
    property(String(describing: T.self)+"/cosh") <- forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { T.cosh($0) }
        let actual   = map(xs) { T.cosh($0) }
        return try? #require( actual ~~~ expected )
    }
}

@inline(never)
func prop_tanh<T: Arbitrary & Similar & ElementaryFunctions>(_ proxy: T.Type) {
    property(String(describing: T.self)+"/tanh") <- forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { T.tanh($0) }
        let actual   = map(xs) { T.tanh($0) }
        return try? #require( actual ~~~ expected )
    }
}

@inline(never)
func prop_asinh<T: Arbitrary & Similar & ElementaryFunctions>(_ proxy: T.Type) {
    property(String(describing: T.self)+"/asinh") <- forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { T.asinh($0) }
        let actual   = map(xs) { T.asinh($0) }
        return try? #require( actual ~~~ expected )
    }
}

@inline(never)
func prop_acosh<T: Arbitrary & Similar & RandomType & FloatingPoint & ElementaryFunctions>(_ proxy: T.Type) {
    let gen = Gen.sized { size in Gen.choose((T(1), T(size))) }
    property(String(describing: T.self)+"/acosh") <- forAllNoShrink(gen.proliferate) { (xs: [T]) in
        let expected = xs.map { T.acosh($0) }
        let actual   = map(xs) { T.acosh($0) }
        return try? #require( actual ~~~ expected )
    }
}

@inline(never)
func prop_atanh<T: Arbitrary & Similar & RandomType & FloatingPoint & ElementaryFunctions>(_ proxy: T.Type) {
    let gen = Gen.choose((T(-1), T(1)))
    property(String(describing: T.self)+"/atanh") <- forAllNoShrink(gen.proliferate) { (xs: [T]) in
        let expected = xs.map { T.atanh($0) }
        let actual   = map(xs) { T.atanh($0) }
        return try? #require( actual ~~~ expected )
    }
}

@inline(never)
func prop_erf<T: Arbitrary & Similar & RealFunctions>(_ proxy: T.Type) {
    property(String(describing: T.self)+"/erf") <- forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { T.erf($0) }
        let actual   = map(xs) { T.erf($0) }
        return try? #require( actual ~~~ expected )
    }
}

@inline(never)
func prop_erfc<T: Arbitrary & Similar & RealFunctions>(_ proxy: T.Type) {
    property(String(describing: T.self)+"/erfc") <- forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { T.erfc($0) }
        let actual   = map(xs) { T.erfc($0) }
        return try? #require( actual ~~~ expected )
    }
}

@inline(never)
func prop_gamma<T: Arbitrary & Similar & RealFunctions>(_ proxy: T.Type) {
    property(String(describing: T.self)+"/gamma") <- forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { T.gamma($0) }
        let actual   = map(xs) { T.gamma($0) }
        return try? #require( actual ~~~ expected )
    }
}

@inline(never)
func prop_logGamma<T: Arbitrary & Similar & RealFunctions>(_ proxy: T.Type) {
    property(String(describing: T.self)+"/logGamma") <- forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { T.logGamma($0) }
        let actual   = map(xs) { T.logGamma($0) }
        return try? #require( actual ~~~ expected )
    }
}

