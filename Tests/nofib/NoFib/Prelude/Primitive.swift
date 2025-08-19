import Testing
import Numerics
import SwiftCheck
import SwiftToPTX

@Suite("Primitive") struct Primitive {
    @Suite("Int8") struct Int8Tests {
        // Ordering
        @Test("Int8.==") func test_eq() { prop_eq(Int8.self) }
        @Test("Int8.!=") func test_neq() { prop_neq(Int8.self) }
        @Test("Int8.<") func test_lt() { prop_lt(Int8.self) }
        @Test("Int8.>") func test_gt() { prop_gt(Int8.self) }
        @Test("Int8.<=") func test_lte() { prop_lte(Int8.self) }
        @Test("Int8.>=") func test_gte() { prop_gte(Int8.self) }
        @Test("Int8.min") func test_min() { prop_min(Int8.self) }
        @Test("Int8.max") func test_max() { prop_max(Int8.self) }

        // Numeric
        @Test("Int8.negate") func test_negate() { prop_negate(Int8.self) }
        @Test("Int8.abs") func test_abs() { prop_abs(Int8.self) }
        @Test("Int8.signum") func test_signum() { prop_signum(Int8.self) }
        // @Test("Int8.+", .bug(id: "86b4gq1tv")) func test_plus() { prop_plus(Int8.self) }
        // @Test("Int8.-", .bug(id: "86b4gq1tv")) func test_minus() { prop_minus(Int8.self) }
        // @Test("Int8.*", .bug(id: "86b4gq1tv")) func test_mul() { prop_mul(Int8.self) }
        @Test("Int8./") func test_quot() { prop_quot(Int8.self) }
        @Test("Int8.%") func test_rem() { prop_rem(Int8.self) }
        @Test("Int8.&+") func test_uncheckedPlus() { prop_uncheckedPlus(Int8.self) }
        @Test("Int8.&-") func test_uncheckedMinus() { prop_uncheckedMinus(Int8.self) }
        @Test("Int8.&*") func test_uncheckedMul() { prop_uncheckedMul(Int8.self) }
        @Test("Int8.quotientAndRemainder") func test_quotientAndRemainder() { prop_quotientAndRemainder(Int8.self) }
        @Test("Int8.isMultiple") func test_isMultiple() { prop_isMultiple(Int8.self) }
        @Test("Int8.addingReportingOverflow") func test_addingReportingOverflow() { prop_addingReportingOverflow(Int8.self) }
        @Test("Int8.subtractingReportingOverflow") func test_subtractingReportingOverflow() { prop_subtractingReportingOverflow(Int8.self) }
        @Test("Int8.multipliedReportingOverflow") func test_multipliedReportingOverflow() { prop_multipliedReportingOverflow(Int8.self) }
        @Test("Int8.dividedReportingOverflow") func test_dividedReportingOverflow() { prop_dividedReportingOverflow(Int8.self) }
        @Test("Int8.remainderReportingOverflow") func test_remainderReportingOverflow() { prop_remainderReportingOverflow(Int8.self) }
        @Test("Int8.multipliedFullWidth") func test_multipliedFullWidth() { prop_multipliedFullWidth(Int8.self) }
        // @Test("Int8.dividingFullWidth", .bug(id: "86b4gqe8t")) func test_dividingFullWidth() { prop_dividingFullWidth(Int8.self) }

        // Bitwise
        @Test("Int8.complement") func test_complement() { prop_complement(Int8.self) }
        @Test("Int8.zeroBitCount") func test_nonzeroBitCount() { prop_nonzeroBitCount(Int8.self) }
        @Test("Int8.leadingZeroBitCount") func test_leadingZeroBitCount() { prop_leadingZeroBitCount(Int8.self) }
        @Test("Int8.trailingZeroBitCount") func test_trailingZeroBitCount() { prop_trailingZeroBitCount(Int8.self) }
        @Test("Int8.byteSwapped") func test_byteSwapped() { prop_byteSwapped(Int8.self) }
        @Test("Int8.littleEndian") func test_littleEndian() { prop_littleEndian(Int8.self) }
        @Test("Int8.bigEndian") func test_bigEndian() { prop_bigEndian(Int8.self) }
        @Test("Int8.&") func test_and() { prop_and(Int8.self) }
        @Test("Int8.|") func test_or() { prop_or(Int8.self) }
        @Test("Int8.^") func test_xor() { prop_xor(Int8.self) }
        @Test("Int8.<<") func test_shiftL() { prop_shiftL(Int8.self) }
        @Test("Int8.>>") func test_shiftR() { prop_shiftR(Int8.self) }
        @Test("Int8.&<<") func test_uncheckedShiftL() { prop_uncheckedShiftL(Int8.self) }
        @Test("Int8.&>>") func test_uncheckedShiftR() { prop_uncheckedShiftR(Int8.self) }
    }

    @Suite("Int16") struct Int16Tests {
        // Ordering
        @Test("Int16.==") func test_eq() { prop_eq(Int16.self) }
        @Test("Int16.!=") func test_neq() { prop_neq(Int16.self) }
        @Test("Int16.<") func test_lt() { prop_lt(Int16.self) }
        @Test("Int16.>") func test_gt() { prop_gt(Int16.self) }
        @Test("Int16.<=") func test_lte() { prop_lte(Int16.self) }
        @Test("Int16.>=") func test_gte() { prop_gte(Int16.self) }
        @Test("Int16.min") func test_min() { prop_min(Int16.self) }
        @Test("Int16.max") func test_max() { prop_max(Int16.self) }

        // Numeric
        @Test("Int16.negate") func test_negate() { prop_negate(Int16.self) }
        @Test("Int16.abs") func test_abs() { prop_abs(Int16.self) }
        @Test("Int16.signum") func test_signum() { prop_signum(Int16.self) }
        @Test("Int16.+") func test_plus() { prop_plus(Int16.self) }
        @Test("Int16.-") func test_minus() { prop_minus(Int16.self) }
        @Test("Int16.*") func test_mul() { prop_mul(Int16.self) }
        @Test("Int16./") func test_quot() { prop_quot(Int16.self) }
        @Test("Int16.%") func test_rem() { prop_rem(Int16.self) }
        @Test("Int16.&+") func test_uncheckedPlus() { prop_uncheckedPlus(Int16.self) }
        @Test("Int16.&-") func test_uncheckedMinus() { prop_uncheckedMinus(Int16.self) }
        @Test("Int16.&*") func test_uncheckedMul() { prop_uncheckedMul(Int16.self) }
        @Test("Int16.quotientAndRemainder") func test_quotientAndRemainder() { prop_quotientAndRemainder(Int16.self) }
        @Test("Int16.isMultiple") func test_isMultiple() { prop_isMultiple(Int16.self) }
        @Test("Int16.addingReportingOverflow") func test_addingReportingOverflow() { prop_addingReportingOverflow(Int16.self) }
        @Test("Int16.subtractingReportingOverflow") func test_subtractingReportingOverflow() { prop_subtractingReportingOverflow(Int16.self) }
        @Test("Int16.multipliedReportingOverflow") func test_multipliedReportingOverflow() { prop_multipliedReportingOverflow(Int16.self) }
        @Test("Int16.dividedReportingOverflow") func test_dividedReportingOverflow() { prop_dividedReportingOverflow(Int16.self) }
        @Test("Int16.remainderReportingOverflow") func test_remainderReportingOverflow() { prop_remainderReportingOverflow(Int16.self) }
        @Test("Int16.multipliedFullWidth") func test_multipliedFullWidth() { prop_multipliedFullWidth(Int16.self) }
        // @Test("Int16.dividingFullWidth", .bug(id: "86b4gqe8t")) func test_dividingFullWidth() { prop_dividingFullWidth(Int16.self) }

        // Bitwise
        @Test("Int16.complement") func test_complement() { prop_complement(Int16.self) }
        @Test("Int16.zeroBitCount") func test_nonzeroBitCount() { prop_nonzeroBitCount(Int16.self) }
        @Test("Int16.leadingZeroBitCount") func test_leadingZeroBitCount() { prop_leadingZeroBitCount(Int16.self) }
        @Test("Int16.trailingZeroBitCount") func test_trailingZeroBitCount() { prop_trailingZeroBitCount(Int16.self) }
        @Test("Int16.byteSwapped") func test_byteSwapped() { prop_byteSwapped(Int16.self) }
        @Test("Int16.littleEndian") func test_littleEndian() { prop_littleEndian(Int16.self) }
        @Test("Int16.bigEndian") func test_bigEndian() { prop_bigEndian(Int16.self) }
        @Test("Int16.&") func test_and() { prop_and(Int16.self) }
        @Test("Int16.|") func test_or() { prop_or(Int16.self) }
        @Test("Int16.^") func test_xor() { prop_xor(Int16.self) }
        @Test("Int16.<<") func test_shiftL() { prop_shiftL(Int16.self) }
        @Test("Int16.>>") func test_shiftR() { prop_shiftR(Int16.self) }
        @Test("Int16.&<<") func test_uncheckedShiftL() { prop_uncheckedShiftL(Int16.self) }
        @Test("Int16.&>>") func test_uncheckedShiftR() { prop_uncheckedShiftR(Int16.self) }
    }

    @Suite("Int32") struct Int32Tests {
        // Ordering
        @Test("Int32.==") func test_eq() { prop_eq(Int32.self) }
        @Test("Int32.!=") func test_neq() { prop_neq(Int32.self) }
        @Test("Int32.<") func test_lt() { prop_lt(Int32.self) }
        @Test("Int32.>") func test_gt() { prop_gt(Int32.self) }
        @Test("Int32.<=") func test_lte() { prop_lte(Int32.self) }
        @Test("Int32.>=") func test_gte() { prop_gte(Int32.self) }
        @Test("Int32.min") func test_min() { prop_min(Int32.self) }
        @Test("Int32.max") func test_max() { prop_max(Int32.self) }

        // Numeric
        @Test("Int32.negate") func test_negate() { prop_negate(Int32.self) }
        @Test("Int32.abs") func test_abs() { prop_abs(Int32.self) }
        @Test("Int32.signum") func test_signum() { prop_signum(Int32.self) }
        @Test("Int32.+") func test_plus() { prop_plus(Int32.self) }
        @Test("Int32.-") func test_minus() { prop_minus(Int32.self) }
        @Test("Int32.*") func test_mul() { prop_mul(Int32.self) }
        @Test("Int32./") func test_quot() { prop_quot(Int32.self) }
        @Test("Int32.%") func test_rem() { prop_rem(Int32.self) }
        @Test("Int32.&+") func test_uncheckedPlus() { prop_uncheckedPlus(Int32.self) }
        @Test("Int32.&-") func test_uncheckedMinus() { prop_uncheckedMinus(Int32.self) }
        @Test("Int32.&*") func test_uncheckedMul() { prop_uncheckedMul(Int32.self) }
        @Test("Int32.quotientAndRemainder") func test_quotientAndRemainder() { prop_quotientAndRemainder(Int32.self) }
        @Test("Int32.isMultiple") func test_isMultiple() { prop_isMultiple(Int32.self) }
        @Test("Int32.addingReportingOverflow") func test_addingReportingOverflow() { prop_addingReportingOverflow(Int32.self) }
        @Test("Int32.subtractingReportingOverflow") func test_subtractingReportingOverflow() { prop_subtractingReportingOverflow(Int32.self) }
        @Test("Int32.multipliedReportingOverflow") func test_multipliedReportingOverflow() { prop_multipliedReportingOverflow(Int32.self) }
        @Test("Int32.dividedReportingOverflow") func test_dividedReportingOverflow() { prop_dividedReportingOverflow(Int32.self) }
        @Test("Int32.remainderReportingOverflow") func test_remainderReportingOverflow() { prop_remainderReportingOverflow(Int32.self) }
        @Test("Int32.multipliedFullWidth") func test_multipliedFullWidth() { prop_multipliedFullWidth(Int32.self) }
        // @Test("Int32.dividingFullWidth", .bug(id: "86b4gqe8t")) func test_dividingFullWidth() { prop_dividingFullWidth(Int32.self) }

        // Bitwise
        @Test("Int32.complement") func test_complement() { prop_complement(Int32.self) }
        @Test("Int32.zeroBitCount") func test_nonzeroBitCount() { prop_nonzeroBitCount(Int32.self) }
        @Test("Int32.leadingZeroBitCount") func test_leadingZeroBitCount() { prop_leadingZeroBitCount(Int32.self) }
        @Test("Int32.trailingZeroBitCount") func test_trailingZeroBitCount() { prop_trailingZeroBitCount(Int32.self) }
        @Test("Int32.byteSwapped") func test_byteSwapped() { prop_byteSwapped(Int32.self) }
        @Test("Int32.littleEndian") func test_littleEndian() { prop_littleEndian(Int32.self) }
        @Test("Int32.bigEndian") func test_bigEndian() { prop_bigEndian(Int32.self) }
        @Test("Int32.&") func test_and() { prop_and(Int32.self) }
        @Test("Int32.|") func test_or() { prop_or(Int32.self) }
        @Test("Int32.^") func test_xor() { prop_xor(Int32.self) }
        @Test("Int32.<<") func test_shiftL() { prop_shiftL(Int32.self) }
        @Test("Int32.>>") func test_shiftR() { prop_shiftR(Int32.self) }
        @Test("Int32.&<<") func test_uncheckedShiftL() { prop_uncheckedShiftL(Int32.self) }
        @Test("Int32.&>>") func test_uncheckedShiftR() { prop_uncheckedShiftR(Int32.self) }
    }

    @Suite("Int64") struct Int64Tests {
        // Ordering
        @Test("Int64.==") func test_eq() { prop_eq(Int64.self) }
        @Test("Int64.!=") func test_neq() { prop_neq(Int64.self) }
        @Test("Int64.<") func test_lt() { prop_lt(Int64.self) }
        @Test("Int64.>") func test_gt() { prop_gt(Int64.self) }
        @Test("Int64.<=") func test_lte() { prop_lte(Int64.self) }
        @Test("Int64.>=") func test_gte() { prop_gte(Int64.self) }
        @Test("Int64.min") func test_min() { prop_min(Int64.self) }
        @Test("Int64.max") func test_max() { prop_max(Int64.self) }

        // Numeric
        @Test("Int64.negate") func test_negate() { prop_negate(Int64.self) }
        @Test("Int64.abs") func test_abs() { prop_abs(Int64.self) }
        @Test("Int64.signum") func test_signum() { prop_signum(Int64.self) }
        @Test("Int64.+") func test_plus() { prop_plus(Int64.self) }
        @Test("Int64.-") func test_minus() { prop_minus(Int64.self) }
        @Test("Int64.*") func test_mul() { prop_mul(Int64.self) }
        @Test("Int64./") func test_quot() { prop_quot(Int64.self) }
        @Test("Int64.%") func test_rem() { prop_rem(Int64.self) }
        @Test("Int64.&+") func test_uncheckedPlus() { prop_uncheckedPlus(Int64.self) }
        @Test("Int64.&-") func test_uncheckedMinus() { prop_uncheckedMinus(Int64.self) }
        @Test("Int64.&*") func test_uncheckedMul() { prop_uncheckedMul(Int64.self) }
        @Test("Int64.quotientAndRemainder") func test_quotientAndRemainder() { prop_quotientAndRemainder(Int64.self) }
        @Test("Int64.isMultiple") func test_isMultiple() { prop_isMultiple(Int64.self) }
        @Test("Int64.addingReportingOverflow") func test_addingReportingOverflow() { prop_addingReportingOverflow(Int64.self) }
        @Test("Int64.subtractingReportingOverflow") func test_subtractingReportingOverflow() { prop_subtractingReportingOverflow(Int64.self) }
        @Test("Int64.multipliedReportingOverflow") func test_multipliedReportingOverflow() { prop_multipliedReportingOverflow(Int64.self) }
        @Test("Int64.dividedReportingOverflow") func test_dividedReportingOverflow() { prop_dividedReportingOverflow(Int64.self) }
        @Test("Int64.remainderReportingOverflow") func test_remainderReportingOverflow() { prop_remainderReportingOverflow(Int64.self) }
        @Test("Int64.multipliedFullWidth") func test_multipliedFullWidth() { prop_multipliedFullWidth(Int64.self) }
        // @Test("Int64.dividingFullWidth", .bug(id: "86b4gqe8t")) func test_dividingFullWidth() { prop_dividingFullWidth(Int64.self) }

        // Bitwise
        @Test("Int64.complement") func test_complement() { prop_complement(Int64.self) }
        @Test("Int64.zeroBitCount") func test_nonzeroBitCount() { prop_nonzeroBitCount(Int64.self) }
        @Test("Int64.leadingZeroBitCount") func test_leadingZeroBitCount() { prop_leadingZeroBitCount(Int64.self) }
        @Test("Int64.trailingZeroBitCount") func test_trailingZeroBitCount() { prop_trailingZeroBitCount(Int64.self) }
        @Test("Int64.byteSwapped") func test_byteSwapped() { prop_byteSwapped(Int64.self) }
        @Test("Int64.littleEndian") func test_littleEndian() { prop_littleEndian(Int64.self) }
        @Test("Int64.bigEndian") func test_bigEndian() { prop_bigEndian(Int64.self) }
        @Test("Int64.&") func test_and() { prop_and(Int64.self) }
        @Test("Int64.|") func test_or() { prop_or(Int64.self) }
        @Test("Int64.^") func test_xor() { prop_xor(Int64.self) }
        @Test("Int64.<<") func test_shiftL() { prop_shiftL(Int64.self) }
        @Test("Int64.>>") func test_shiftR() { prop_shiftR(Int64.self) }
        @Test("Int64.&<<") func test_uncheckedShiftL() { prop_uncheckedShiftL(Int64.self) }
        @Test("Int64.&>>") func test_uncheckedShiftR() { prop_uncheckedShiftR(Int64.self) }
    }

    @Suite("UInt8") struct UInt8Tests {
        // Ordering
        @Test("UInt8.==") func test_eq() { prop_eq(UInt8.self) }
        @Test("UInt8.!=") func test_neq() { prop_neq(UInt8.self) }
        @Test("UInt8.<") func test_lt() { prop_lt(UInt8.self) }
        @Test("UInt8.>") func test_gt() { prop_gt(UInt8.self) }
        @Test("UInt8.<=") func test_lte() { prop_lte(UInt8.self) }
        @Test("UInt8.>=") func test_gte() { prop_gte(UInt8.self) }
        @Test("UInt8.min") func test_min() { prop_min(UInt8.self) }
        @Test("UInt8.max") func test_max() { prop_max(UInt8.self) }

        // // Numeric
        @Test("UInt8.signum") func test_signum() { prop_signum(UInt8.self) }
        @Test("UInt8.+") func test_plus() { prop_plus(UInt8.self) }
        // @Test("UInt8.-", .bug(id: "86b4gq1tv")) func test_minus() { prop_minus(UInt8.self) }
        // @Test("UInt8.*", .bug(id: "86b4gq1tv")) func test_mul() { prop_mul(UInt8.self) }
        @Test("UInt8./") func test_quot() { prop_quot(UInt8.self) }
        @Test("UInt8.%") func test_rem() { prop_rem(UInt8.self) }
        @Test("UInt8.&+") func test_uncheckedPlus() { prop_uncheckedPlus(UInt8.self) }
        @Test("UInt8.&-") func test_uncheckedMinus() { prop_uncheckedMinus(UInt8.self) }
        @Test("UInt8.&*") func test_uncheckedMul() { prop_uncheckedMul(UInt8.self) }
        @Test("UInt8.quotientAndRemainder") func test_quotientAndRemainder() { prop_quotientAndRemainder(UInt8.self) }
        @Test("UInt8.isMultiple") func test_isMultiple() { prop_isMultiple(UInt8.self) }
        @Test("UInt8.addingReportingOverflow") func test_addingReportingOverflow() { prop_addingReportingOverflow(UInt8.self) }
        @Test("UInt8.subtractingReportingOverflow") func test_subtractingReportingOverflow() { prop_subtractingReportingOverflow(UInt8.self) }
        @Test("UInt8.multipliedReportingOverflow") func test_multipliedReportingOverflow() { prop_multipliedReportingOverflow(UInt8.self) }
        @Test("UInt8.dividedReportingOverflow") func test_dividedReportingOverflow() { prop_dividedReportingOverflow(UInt8.self) }
        @Test("UInt8.remainderReportingOverflow") func test_remainderReportingOverflow() { prop_remainderReportingOverflow(UInt8.self) }
        @Test("UInt8.multipliedFullWidth") func test_multipliedFullWidth() { prop_multipliedFullWidth(UInt8.self) }
        // @Test("UInt8.dividingFullWidth", .bug(id: "86b4gq1tv")) func test_dividingFullWidth() { prop_dividingFullWidth(UInt8.self) }

        // Bitwise
        @Test("UInt8.complement") func test_complement() { prop_complement(UInt8.self) }
        @Test("UInt8.zeroBitCount") func test_nonzeroBitCount() { prop_nonzeroBitCount(UInt8.self) }
        @Test("UInt8.leadingZeroBitCount") func test_leadingZeroBitCount() { prop_leadingZeroBitCount(UInt8.self) }
        @Test("UInt8.trailingZeroBitCount") func test_trailingZeroBitCount() { prop_trailingZeroBitCount(UInt8.self) }
        @Test("UInt8.byteSwapped") func test_byteSwapped() { prop_byteSwapped(UInt8.self) }
        @Test("UInt8.littleEndian") func test_littleEndian() { prop_littleEndian(UInt8.self) }
        @Test("UInt8.bigEndian") func test_bigEndian() { prop_bigEndian(UInt8.self) }
        @Test("UInt8.&") func test_and() { prop_and(UInt8.self) }
        @Test("UInt8.|") func test_or() { prop_or(UInt8.self) }
        @Test("UInt8.^") func test_xor() { prop_xor(UInt8.self) }
        @Test("UInt8.<<") func test_shiftL() { prop_shiftL(UInt8.self) }
        @Test("UInt8.>>") func test_shiftR() { prop_shiftR(UInt8.self) }
        @Test("UInt8.&<<") func test_uncheckedShiftL() { prop_uncheckedShiftL(UInt8.self) }
        @Test("UInt8.&>>") func test_uncheckedShiftR() { prop_uncheckedShiftR(UInt8.self) }
    }

    @Suite("UInt16") struct UInt16Tests {
        // Ordering
        @Test("UInt16.==") func test_eq() { prop_eq(UInt16.self) }
        @Test("UInt16.!=") func test_neq() { prop_neq(UInt16.self) }
        @Test("UInt16.<") func test_lt() { prop_lt(UInt16.self) }
        @Test("UInt16.>") func test_gt() { prop_gt(UInt16.self) }
        @Test("UInt16.<=") func test_lte() { prop_lte(UInt16.self) }
        @Test("UInt16.>=") func test_gte() { prop_gte(UInt16.self) }
        @Test("UInt16.min") func test_min() { prop_min(UInt16.self) }
        @Test("UInt16.max") func test_max() { prop_max(UInt16.self) }

        // Numeric
        @Test("UInt16.signum") func test_signum() { prop_signum(UInt16.self) }
        @Test("UInt16.+") func test_plus() { prop_plus(UInt16.self) }
        // @Test("UInt16.-", .bug(id: "86b4gq1tv")) func test_minus() { prop_minus(UInt16.self) }
        @Test("UInt16.*") func test_mul() { prop_mul(UInt16.self) }
        @Test("UInt16./") func test_quot() { prop_quot(UInt16.self) }
        @Test("UInt16.%") func test_rem() { prop_rem(UInt16.self) }
        @Test("UInt16.&+") func test_uncheckedPlus() { prop_uncheckedPlus(UInt16.self) }
        @Test("UInt16.&-") func test_uncheckedMinus() { prop_uncheckedMinus(UInt16.self) }
        @Test("UInt16.&*") func test_uncheckedMul() { prop_uncheckedMul(UInt16.self) }
        @Test("UInt16.quotientAndRemainder") func test_quotientAndRemainder() { prop_quotientAndRemainder(UInt16.self) }
        @Test("UInt16.isMultiple") func test_isMultiple() { prop_isMultiple(UInt16.self) }
        @Test("UInt16.addingReportingOverflow") func test_addingReportingOverflow() { prop_addingReportingOverflow(UInt16.self) }
        @Test("UInt16.subtractingReportingOverflow") func test_subtractingReportingOverflow() { prop_subtractingReportingOverflow(UInt16.self) }
        @Test("UInt16.multipliedReportingOverflow") func test_multipliedReportingOverflow() { prop_multipliedReportingOverflow(UInt16.self) }
        @Test("UInt16.dividedReportingOverflow") func test_dividedReportingOverflow() { prop_dividedReportingOverflow(UInt16.self) }
        @Test("UInt16.remainderReportingOverflow") func test_remainderReportingOverflow() { prop_remainderReportingOverflow(UInt16.self) }
        @Test("UInt16.multipliedFullWidth") func test_multipliedFullWidth() { prop_multipliedFullWidth(UInt16.self) }
        // @Test("UInt16.dividingFullWidth", .bug(id: "86b4gq1tv")) func test_dividingFullWidth() { prop_dividingFullWidth(UInt16.self) }

        // Bitwise
        @Test("UInt16.complement") func test_complement() { prop_complement(UInt16.self) }
        @Test("UInt16.zeroBitCount") func test_nonzeroBitCount() { prop_nonzeroBitCount(UInt16.self) }
        @Test("UInt16.leadingZeroBitCount") func test_leadingZeroBitCount() { prop_leadingZeroBitCount(UInt16.self) }
        @Test("UInt16.trailingZeroBitCount") func test_trailingZeroBitCount() { prop_trailingZeroBitCount(UInt16.self) }
        @Test("UInt16.byteSwapped") func test_byteSwapped() { prop_byteSwapped(UInt16.self) }
        @Test("UInt16.littleEndian") func test_littleEndian() { prop_littleEndian(UInt16.self) }
        @Test("UInt16.bigEndian") func test_bigEndian() { prop_bigEndian(UInt16.self) }
        @Test("UInt16.&") func test_and() { prop_and(UInt16.self) }
        @Test("UInt16.|") func test_or() { prop_or(UInt16.self) }
        @Test("UInt16.^") func test_xor() { prop_xor(UInt16.self) }
        @Test("UInt16.<<") func test_shiftL() { prop_shiftL(UInt16.self) }
        @Test("UInt16.>>") func test_shiftR() { prop_shiftR(UInt16.self) }
        @Test("UInt16.&<<") func test_uncheckedShiftL() { prop_uncheckedShiftL(UInt16.self) }
        @Test("UInt16.&>>") func test_uncheckedShiftR() { prop_uncheckedShiftR(UInt16.self) }
    }

    @Suite("UInt32") struct UInt32Tests {
        // Ordering
        @Test("UInt32.==") func test_eq() { prop_eq(UInt32.self) }
        @Test("UInt32.!=") func test_neq() { prop_neq(UInt32.self) }
        @Test("UInt32.<") func test_lt() { prop_lt(UInt32.self) }
        @Test("UInt32.>") func test_gt() { prop_gt(UInt32.self) }
        @Test("UInt32.<=") func test_lte() { prop_lte(UInt32.self) }
        @Test("UInt32.>=") func test_gte() { prop_gte(UInt32.self) }
        @Test("UInt32.min") func test_min() { prop_min(UInt32.self) }
        @Test("UInt32.max") func test_max() { prop_max(UInt32.self) }

        // Numeric
        @Test("UInt32.signum") func test_signum() { prop_signum(UInt32.self) }
        @Test("UInt32.+") func test_plus() { prop_plus(UInt32.self) }
        // @Test("UInt32.-", .bug(id: "86b4gq1tv")) func test_minus() { prop_minus(UInt32.self) }
        @Test("UInt32.*") func test_mul() { prop_mul(UInt32.self) }
        @Test("UInt32./") func test_quot() { prop_quot(UInt32.self) }
        @Test("UInt32.%") func test_rem() { prop_rem(UInt32.self) }
        @Test("UInt32.&+") func test_uncheckedPlus() { prop_uncheckedPlus(UInt32.self) }
        @Test("UInt32.&-") func test_uncheckedMinus() { prop_uncheckedMinus(UInt32.self) }
        @Test("UInt32.&*") func test_uncheckedMul() { prop_uncheckedMul(UInt32.self) }
        @Test("UInt32.quotientAndRemainder") func test_quotientAndRemainder() { prop_quotientAndRemainder(UInt32.self) }
        @Test("UInt32.isMultiple") func test_isMultiple() { prop_isMultiple(UInt32.self) }
        @Test("UInt32.addingReportingOverflow") func test_addingReportingOverflow() { prop_addingReportingOverflow(UInt32.self) }
        @Test("UInt32.subtractingReportingOverflow") func test_subtractingReportingOverflow() { prop_subtractingReportingOverflow(UInt32.self) }
        @Test("UInt32.multipliedReportingOverflow") func test_multipliedReportingOverflow() { prop_multipliedReportingOverflow(UInt32.self) }
        @Test("UInt32.dividedReportingOverflow") func test_dividedReportingOverflow() { prop_dividedReportingOverflow(UInt32.self) }
        @Test("UInt32.remainderReportingOverflow") func test_remainderReportingOverflow() { prop_remainderReportingOverflow(UInt32.self) }
        @Test("UInt32.multipliedFullWidth") func test_multipliedFullWidth() { prop_multipliedFullWidth(UInt32.self) }
        // @Test("UInt32.dividingFullWidth", .bug(id: "86b4gq1tv")) func test_dividingFullWidth() { prop_dividingFullWidth(UInt32.self) }

        // Bitwise
        @Test("UInt32.complement") func test_complement() { prop_complement(UInt32.self) }
        @Test("UInt32.zeroBitCount") func test_nonzeroBitCount() { prop_nonzeroBitCount(UInt32.self) }
        @Test("UInt32.leadingZeroBitCount") func test_leadingZeroBitCount() { prop_leadingZeroBitCount(UInt32.self) }
        @Test("UInt32.trailingZeroBitCount") func test_trailingZeroBitCount() { prop_trailingZeroBitCount(UInt32.self) }
        @Test("UInt32.byteSwapped") func test_byteSwapped() { prop_byteSwapped(UInt32.self) }
        @Test("UInt32.littleEndian") func test_littleEndian() { prop_littleEndian(UInt32.self) }
        @Test("UInt32.bigEndian") func test_bigEndian() { prop_bigEndian(UInt32.self) }
        @Test("UInt32.&") func test_and() { prop_and(UInt32.self) }
        @Test("UInt32.|") func test_or() { prop_or(UInt32.self) }
        @Test("UInt32.^") func test_xor() { prop_xor(UInt32.self) }
        @Test("UInt32.<<") func test_shiftL() { prop_shiftL(UInt32.self) }
        @Test("UInt32.>>") func test_shiftR() { prop_shiftR(UInt32.self) }
        @Test("UInt32.&<<") func test_uncheckedShiftL() { prop_uncheckedShiftL(UInt32.self) }
        @Test("UInt32.&>>") func test_uncheckedShiftR() { prop_uncheckedShiftR(UInt32.self) }
    }

    @Suite("UInt64") struct UInt64Tests {
        // Ordering
        @Test("UInt64.==") func test_eq() { prop_eq(UInt64.self) }
        @Test("UInt64.!=") func test_neq() { prop_neq(UInt64.self) }
        @Test("UInt64.<") func test_lt() { prop_lt(UInt64.self) }
        @Test("UInt64.>") func test_gt() { prop_gt(UInt64.self) }
        @Test("UInt64.<=") func test_lte() { prop_lte(UInt64.self) }
        @Test("UInt64.>=") func test_gte() { prop_gte(UInt64.self) }
        @Test("UInt64.min") func test_min() { prop_min(UInt64.self) }
        @Test("UInt64.max") func test_max() { prop_max(UInt64.self) }

        // Numeric
        @Test("UInt64.signum") func test_signum() { prop_signum(UInt64.self) }
        @Test("UInt64.+") func test_plus() { prop_plus(UInt64.self) }
        // @Test("UInt64.-", .bug(id: "86b4gq1tv")) func test_minus() { prop_minus(UInt64.self) }
        @Test("UInt64.*") func test_mul() { prop_mul(UInt64.self) }
        @Test("UInt64./") func test_quot() { prop_quot(UInt64.self) }
        @Test("UInt64.%") func test_rem() { prop_rem(UInt64.self) }
        @Test("UInt64.&+") func test_uncheckedPlus() { prop_uncheckedPlus(UInt64.self) }
        @Test("UInt64.&-") func test_uncheckedMinus() { prop_uncheckedMinus(UInt64.self) }
        @Test("UInt64.&*") func test_uncheckedMul() { prop_uncheckedMul(UInt64.self) }
        @Test("UInt64.quotientAndRemainder") func test_quotientAndRemainder() { prop_quotientAndRemainder(UInt64.self) }
        @Test("UInt64.isMultiple") func test_isMultiple() { prop_isMultiple(UInt64.self) }
        @Test("UInt64.addingReportingOverflow") func test_addingReportingOverflow() { prop_addingReportingOverflow(UInt64.self) }
        @Test("UInt64.subtractingReportingOverflow") func test_subtractingReportingOverflow() { prop_subtractingReportingOverflow(UInt64.self) }
        @Test("UInt64.multipliedReportingOverflow") func test_multipliedReportingOverflow() { prop_multipliedReportingOverflow(UInt64.self) }
        @Test("UInt64.dividedReportingOverflow") func test_dividedReportingOverflow() { prop_dividedReportingOverflow(UInt64.self) }
        @Test("UInt64.remainderReportingOverflow") func test_remainderReportingOverflow() { prop_remainderReportingOverflow(UInt64.self) }
        @Test("UInt64.multipliedFullWidth") func test_multipliedFullWidth() { prop_multipliedFullWidth(UInt64.self) }
        // @Test("UInt64.dividingFullWidth", .bug(id: "86b4gq3w3")) func test_dividingFullWidth() { prop_dividingFullWidth(UInt64.self) }

        // Bitwise
        @Test("UInt64.complement") func test_complement() { prop_complement(UInt64.self) }
        @Test("UInt64.zeroBitCount") func test_nonzeroBitCount() { prop_nonzeroBitCount(UInt64.self) }
        @Test("UInt64.leadingZeroBitCount") func test_leadingZeroBitCount() { prop_leadingZeroBitCount(UInt64.self) }
        @Test("UInt64.trailingZeroBitCount") func test_trailingZeroBitCount() { prop_trailingZeroBitCount(UInt64.self) }
        @Test("UInt64.byteSwapped") func test_byteSwapped() { prop_byteSwapped(UInt64.self) }
        @Test("UInt64.littleEndian") func test_littleEndian() { prop_littleEndian(UInt64.self) }
        @Test("UInt64.bigEndian") func test_bigEndian() { prop_bigEndian(UInt64.self) }
        @Test("UInt64.&") func test_and() { prop_and(UInt64.self) }
        @Test("UInt64.|") func test_or() { prop_or(UInt64.self) }
        @Test("UInt64.^") func test_xor() { prop_xor(UInt64.self) }
        @Test("UInt64.<<") func test_shiftL() { prop_shiftL(UInt64.self) }
        @Test("UInt64.>>") func test_shiftR() { prop_shiftR(UInt64.self) }
        @Test("UInt64.&<<") func test_uncheckedShiftL() { prop_uncheckedShiftL(UInt64.self) }
        @Test("UInt64.&>>") func test_uncheckedShiftR() { prop_uncheckedShiftR(UInt64.self) }
    }

#if arch(arm64)
    @Suite("Float16") struct Float16Tests {
        // Ordering
        @Test("Float16.==") func test_eq() { prop_eq(Float16.self) }
        @Test("Float16.!=") func test_neq() { prop_neq(Float16.self) }
        @Test("Float16.<") func test_lt() { prop_lt(Float16.self) }
        @Test("Float16.>") func test_gt() { prop_gt(Float16.self) }
        @Test("Float16.<=") func test_lte() { prop_lte(Float16.self) }
        @Test("Float16.>=") func test_gte() { prop_gte(Float16.self) }
        @Test("Float16.min") func test_min() { prop_min(Float16.self) }
        @Test("Float16.max") func test_max() { prop_max(Float16.self) }

        // Numeric
        @Test("Float16.negate") func test_negate() { prop_negate(Float16.self) }
        @Test("Float16.abs") func test_abs() { prop_abs(Float16.self) }
        @Test("Float16.+") func test_plus() { prop_plus(Float16.self) }
        @Test("Float16.-") func test_minus() { prop_minus(Float16.self) }
        @Test("Float16.*") func test_mul() { prop_mul(Float16.self) }
        @Test("Float16./") func test_quot() { prop_quot(Float16.self) }
        @Test("Float16.pow") func test_pow() { prop_pow(Float16.self) }
        @Test("Float16.powi") func test_powi() { prop_powi(Float16.self) }
        @Test("Float16.exponent") func test_exponent() { prop_exponent(Float16.self) }
        @Test("Float16.floatingPointClass") func test_floatingPointClass() { prop_floatingPointClass(Float16.self) }
        @Test("Float16.isCanonical") func test_isCanonical() { prop_isCanonical(Float16.self) }
        @Test("Float16.isFinite") func test_isFinite() { prop_isFinite(Float16.self) }
        @Test("Float16.isInfinite") func test_isInfinite() { prop_isInfinite(Float16.self) }
        @Test("Float16.isNaN") func test_isNaN() { prop_isNaN(Float16.self) }
        @Test("Float16.isSignalingNaN") func test_isSignalingNaN() { prop_isSignalingNaN(Float16.self) }
        @Test("Float16.isNormal") func test_isNormal() { prop_isNormal(Float16.self) }
        @Test("Float16.isSubnormal") func test_isSubnormal() { prop_isSubnormal(Float16.self) }
        @Test("Float16.isZero") func test_isZero() { prop_isZero(Float16.self) }
        @Test("Float16.nextDown") func test_nextDown() { prop_nextDown(Float16.self) }
        @Test("Float16.nextUp") func test_nextUp() { prop_nextUp(Float16.self) }
        @Test("Float16.sign") func test_sign() { prop_sign(Float16.self) }
        // @Test("Float16.significand", .bug(id: "86b4gq63t")) func test_significand() { prop_significand(Float16.self) }
        @Test("Float16.ulp") func test_ulp() { prop_ulp(Float16.self) }
        @Test("Float16.rounded") func test_rounded() { prop_rounded(Float16.self) }
        // @Test("Float16.roundedRule", .bug(id: "86b4gqdud")) func test_roundedRWithRoundingRule() { prop_roundedWithRoundingRule(Float16.self) }
        @Test("Float16.floor") func test_floor() { prop_floor(Float16.self) }
        @Test("Float16.ceiling") func test_ceiling() { prop_ceiling(Float16.self) }
        @Test("Float16.truncate") func test_truncate() { prop_truncate(Float16.self) }
        @Test("Float16.sqrt") func test_sqrt() { prop_sqrt(Float16.self) }
        @Test("Float16.reciprocal") func test_reciprocal() { prop_reciprocal(Float16.self) }
        @Test("Float16.exp") func test_exp() { prop_exp(Float16.self) }
        @Test("Float16.exp2") func test_exp2() { prop_exp2(Float16.self) }
        @Test("Float16.exp10") func test_exp10() { prop_exp10(Float16.self) }
        @Test("Float16.expMinusOne") func test_expMinusOne() { prop_expMinusOne(Float16.self) }
        @Test("Float16.log") func test_log() { prop_log(Float16.self) }
        @Test("Float16.log2") func test_log2() { prop_log2(Float16.self) }
        @Test("Float16.log10") func test_log10() { prop_log10(Float16.self) }
        @Test("Float16.logOnePlus") func test_logOnePlus() { prop_logOnePlus(Float16.self) }
        @Test("Float16.sin") func test_sin() { prop_sin(Float16.self) }
        @Test("Float16.cos") func test_cos() { prop_cos(Float16.self) }
        @Test("Float16.tan") func test_tan() { prop_tan(Float16.self) }
        @Test("Float16.asin") func test_asin() { prop_asin(Float16.self) }
        @Test("Float16.acos") func test_acos() { prop_acos(Float16.self) }
        @Test("Float16.atan") func test_atan() { prop_atan(Float16.self) }
        @Test("Float16.atan2") func test_atan2() { prop_atan2(Float16.self) }
        @Test("Float16.sinh") func test_sinh() { prop_sinh(Float16.self) }
        @Test("Float16.cosh") func test_cosh() { prop_cosh(Float16.self) }
        @Test("Float16.tanh") func test_tanh() { prop_tanh(Float16.self) }
        @Test("Float16.asinh") func test_asinh() { prop_asinh(Float16.self) }
        @Test("Float16.acosh") func test_acosh() { prop_acosh(Float16.self) }
        @Test("Float16.atanh") func test_atanh() { prop_atanh(Float16.self) }
        @Test("Float16.hypot") func test_hypot() { prop_hypot(Float16.self) }
        @Test("Float16.erf") func test_erf() { prop_erf(Float16.self) }
        @Test("Float16.erfc") func test_erfc() { prop_erfc(Float16.self) }
        @Test("Float16.gamma") func test_gamma() { prop_gamma(Float16.self) }
        @Test("Float16.logGamma") func test_logGamma() { prop_logGamma(Float16.self) }
    }
#endif

    @Suite("Float32") struct Float32Tests {
        // Ordering
        @Test("Float32.==") func test_eq() { prop_eq(Float32.self) }
        @Test("Float32.!=") func test_neq() { prop_neq(Float32.self) }
        @Test("Float32.<") func test_lt() { prop_lt(Float32.self) }
        @Test("Float32.>") func test_gt() { prop_gt(Float32.self) }
        @Test("Float32.<=") func test_lte() { prop_lte(Float32.self) }
        @Test("Float32.>=") func test_gte() { prop_gte(Float32.self) }
        @Test("Float32.min") func test_min() { prop_min(Float32.self) }
        @Test("Float32.max") func test_max() { prop_max(Float32.self) }

        // Numeric
        @Test("Float32.negate") func test_negate() { prop_negate(Float32.self) }
        @Test("Float32.abs") func test_abs() { prop_abs(Float32.self) }
        @Test("Float32.+") func test_plus() { prop_plus(Float32.self) }
        @Test("Float32.-") func test_minus() { prop_minus(Float32.self) }
        @Test("Float32.*") func test_mul() { prop_mul(Float32.self) }
        @Test("Float32./") func test_quot() { prop_quot(Float32.self) }
        @Test("Float32.pow") func test_pow() { prop_pow(Float32.self) }
        @Test("Float32.powi") func test_powi() { prop_powi(Float32.self) }
        @Test("Float32.exponent") func test_exponent() { prop_exponent(Float32.self) }
        @Test("Float32.floatingPointClass") func test_floatingPointClass() { prop_floatingPointClass(Float32.self) }
        @Test("Float32.isCanonical") func test_isCanonical() { prop_isCanonical(Float32.self) }
        @Test("Float32.isFinite") func test_isFinite() { prop_isFinite(Float32.self) }
        @Test("Float32.isInfinite") func test_isInfinite() { prop_isInfinite(Float32.self) }
        @Test("Float32.isNaN") func test_isNaN() { prop_isNaN(Float32.self) }
        @Test("Float32.isSignalingNaN") func test_isSignalingNaN() { prop_isSignalingNaN(Float32.self) }
        @Test("Float32.isNormal") func test_isNormal() { prop_isNormal(Float32.self) }
        @Test("Float32.isSubnormal") func test_isSubnormal() { prop_isSubnormal(Float32.self) }
        @Test("Float32.isZero") func test_isZero() { prop_isZero(Float32.self) }
        @Test("Float32.nextDown") func test_nextDown() { prop_nextDown(Float32.self) }
        @Test("Float32.nextUp") func test_nextUp() { prop_nextUp(Float32.self) }
        @Test("Float32.sign") func test_sign() { prop_sign(Float32.self) }
        // @Test("Float32.significand", .bug(id: "86b4gq63t")) func test_significand() { prop_significand(Float32.self) }
        @Test("Float32.ulp") func test_ulp() { prop_ulp(Float32.self) }
        @Test("Float32.rounded") func test_rounded() { prop_rounded(Float32.self) }
        // @Test("Float32.roundedRule", .bug(id: "86b4gqdud")) func test_roundedRWithRoundingRule() { prop_roundedWithRoundingRule(Float32.self) }
        @Test("Float32.floor") func test_floor() { prop_floor(Float32.self) }
        @Test("Float32.ceiling") func test_ceiling() { prop_ceiling(Float32.self) }
        @Test("Float32.truncate") func test_truncate() { prop_truncate(Float32.self) }
        @Test("Float32.sqrt") func test_sqrt() { prop_sqrt(Float32.self) }
        @Test("Float32.reciprocal") func test_reciprocal() { prop_reciprocal(Float32.self) }
        @Test("Float32.exp") func test_exp() { prop_exp(Float32.self) }
        @Test("Float32.exp2") func test_exp2() { prop_exp2(Float32.self) }
        @Test("Float32.exp10") func test_exp10() { prop_exp10(Float32.self) }
        @Test("Float32.expMinusOne") func test_expMinusOne() { prop_expMinusOne(Float32.self) }
        @Test("Float32.log") func test_log() { prop_log(Float32.self) }
        @Test("Float32.log2") func test_log2() { prop_log2(Float32.self) }
        @Test("Float32.log10") func test_log10() { prop_log10(Float32.self) }
        @Test("Float32.logOnePlus") func test_logOnePlus() { prop_logOnePlus(Float32.self) }
        @Test("Float32.sin") func test_sin() { prop_sin(Float32.self) }
        @Test("Float32.cos") func test_cos() { prop_cos(Float32.self) }
        @Test("Float32.tan") func test_tan() { prop_tan(Float32.self) }
        @Test("Float32.asin") func test_asin() { prop_asin(Float32.self) }
        @Test("Float32.acos") func test_acos() { prop_acos(Float32.self) }
        @Test("Float32.atan") func test_atan() { prop_atan(Float32.self) }
        @Test("Float32.atan2") func test_atan2() { prop_atan2(Float32.self) }
        @Test("Float32.sinh") func test_sinh() { prop_sinh(Float32.self) }
        @Test("Float32.cosh") func test_cosh() { prop_cosh(Float32.self) }
        @Test("Float32.tanh") func test_tanh() { prop_tanh(Float32.self) }
        @Test("Float32.asinh") func test_asinh() { prop_asinh(Float32.self) }
        @Test("Float32.acosh") func test_acosh() { prop_acosh(Float32.self) }
        @Test("Float32.atanh") func test_atanh() { prop_atanh(Float32.self) }
        @Test("Float32.hypot") func test_hypot() { prop_hypot(Float32.self) }
        @Test("Float32.erf") func test_erf() { prop_erf(Float32.self) }
        @Test("Float32.erfc") func test_erfc() { prop_erfc(Float32.self) }
        @Test("Float32.gamma") func test_gamma() { prop_gamma(Float32.self) }
        @Test("Float32.logGamma") func test_logGamma() { prop_logGamma(Float32.self) }
    }

    @Suite("Float64") struct Float64Tests {
        // Ordering
        @Test("Float64.==") func test_eq() { prop_eq(Float64.self) }
        @Test("Float64.!=") func test_neq() { prop_neq(Float64.self) }
        @Test("Float64.<") func test_lt() { prop_lt(Float64.self) }
        @Test("Float64.>") func test_gt() { prop_gt(Float64.self) }
        @Test("Float64.<=") func test_lte() { prop_lte(Float64.self) }
        @Test("Float64.>=") func test_gte() { prop_gte(Float64.self) }
        @Test("Float64.min") func test_min() { prop_min(Float64.self) }
        @Test("Float64.max") func test_max() { prop_max(Float64.self) }

        // Numeric
        @Test("Float64.negate") func test_negate() { prop_negate(Float64.self) }
        @Test("Float64.abs") func test_abs() { prop_abs(Float64.self) }
        @Test("Float64.+") func test_plus() { prop_plus(Float64.self) }
        @Test("Float64.-") func test_minus() { prop_minus(Float64.self) }
        @Test("Float64.*") func test_mul() { prop_mul(Float64.self) }
        @Test("Float64./") func test_quot() { prop_quot(Float64.self) }
        @Test("Float64.pow") func test_pow() { prop_pow(Float64.self) }
        @Test("Float64.powi") func test_powi() { prop_powi(Float64.self) }
        @Test("Float64.exponent") func test_exponent() { prop_exponent(Float64.self) }
        @Test("Float64.floatingPointClass") func test_floatingPointClass() { prop_floatingPointClass(Float64.self) }
        @Test("Float64.isCanonical") func test_isCanonical() { prop_isCanonical(Float64.self) }
        @Test("Float64.isFinite") func test_isFinite() { prop_isFinite(Float64.self) }
        @Test("Float64.isInfinite") func test_isInfinite() { prop_isInfinite(Float64.self) }
        @Test("Float64.isNaN") func test_isNaN() { prop_isNaN(Float64.self) }
        @Test("Float64.isSignalingNaN") func test_isSignalingNaN() { prop_isSignalingNaN(Float64.self) }
        @Test("Float64.isNormal") func test_isNormal() { prop_isNormal(Float64.self) }
        @Test("Float64.isSubnormal") func test_isSubnormal() { prop_isSubnormal(Float64.self) }
        @Test("Float64.isZero") func test_isZero() { prop_isZero(Float64.self) }
        @Test("Float64.nextDown") func test_nextDown() { prop_nextDown(Float64.self) }
        @Test("Float64.nextUp") func test_nextUp() { prop_nextUp(Float64.self) }
        @Test("Float64.sign") func test_sign() { prop_sign(Float64.self) }
        @Test("Float64.significand") func test_significand() { prop_significand(Float64.self) }
        @Test("Float64.ulp") func test_ulp() { prop_ulp(Float64.self) }
        @Test("Float64.rounded") func test_rounded() { prop_rounded(Float64.self) }
        // @Test("Float64.roundedRule", .bug(id: "86b4gqdud")) func test_roundedRWithRoundingRule() { prop_roundedWithRoundingRule(Float64.self) }
        @Test("Float64.floor") func test_floor() { prop_floor(Float64.self) }
        @Test("Float64.ceiling") func test_ceiling() { prop_ceiling(Float64.self) }
        @Test("Float64.truncate") func test_truncate() { prop_truncate(Float64.self) }
        @Test("Float64.sqrt") func test_sqrt() { prop_sqrt(Float64.self) }
        @Test("Float64.reciprocal") func test_reciprocal() { prop_reciprocal(Float64.self) }
        @Test("Float64.exp") func test_exp() { prop_exp(Float64.self) }
        @Test("Float64.exp2") func test_exp2() { prop_exp2(Float64.self) }
        @Test("Float64.exp10") func test_exp10() { prop_exp10(Float64.self) }
        @Test("Float64.expMinusOne") func test_expMinusOne() { prop_expMinusOne(Float64.self) }
        @Test("Float64.log") func test_log() { prop_log(Float64.self) }
        @Test("Float64.log2") func test_log2() { prop_log2(Float64.self) }
        @Test("Float64.log10") func test_log10() { prop_log10(Float64.self) }
        @Test("Float64.logOnePlus") func test_logOnePlus() { prop_logOnePlus(Float64.self) }
        @Test("Float64.sin") func test_sin() { prop_sin(Float64.self) }
        @Test("Float64.cos") func test_cos() { prop_cos(Float64.self) }
        @Test("Float64.tan") func test_tan() { prop_tan(Float64.self) }
        @Test("Float64.asin") func test_asin() { prop_asin(Float64.self) }
        @Test("Float64.acos") func test_acos() { prop_acos(Float64.self) }
        @Test("Float64.atan") func test_atan() { prop_atan(Float64.self) }
        @Test("Float64.atan2") func test_atan2() { prop_atan2(Float64.self) }
        @Test("Float64.sinh") func test_sinh() { prop_sinh(Float64.self) }
        @Test("Float64.cosh") func test_cosh() { prop_cosh(Float64.self) }
        @Test("Float64.tanh") func test_tanh() { prop_tanh(Float64.self) }
        @Test("Float64.asinh") func test_asinh() { prop_asinh(Float64.self) }
        @Test("Float64.acosh") func test_acosh() { prop_acosh(Float64.self) }
        @Test("Float64.atanh") func test_atanh() { prop_atanh(Float64.self) }
        @Test("Float64.hypot") func test_hypot() { prop_hypot(Float64.self) }
        @Test("Float64.erf") func test_erf() { prop_erf(Float64.self) }
        @Test("Float64.erfc") func test_erfc() { prop_erfc(Float64.self) }
        @Test("Float64.gamma") func test_gamma() { prop_gamma(Float64.self) }
        @Test("Float64.logGamma") func test_logGamma() { prop_logGamma(Float64.self) }
    }
}

// XXX: We need to put all of the functions here in the one module due to
// compilation restrictions under `swift test`; namely the `-enable-testing`
// flag that gets introduced exposes internal functions for testing, which is
// preventing functions from being optimised completely (or at least, an
// unoptimised version remains, which the compiler borks at). We work around
// that by moving all property tests to this module _and_ marking them as
// private (the last part is key!).

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

// MARK: Equality

// @inline(never)
private func prop_eq<T : Arbitrary & Equatable>(_ proxy: T.Type) {
    property(String(describing: T.self)+".==") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink([T].arbitrary) { (ys: [T]) in
        let expected = zip(xs, ys).map{ (x, y) in x == y }
        let actual   = zipWith(xs, ys, ==)
        return try? #require( actual == expected )
      }}
}

// @inline(never)
private func prop_neq<T : Arbitrary & Equatable>(_ proxy: T.Type) {
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
private func prop_lt<T : Arbitrary & Comparable>(_ proxy: T.Type) {
    property(String(describing: T.self)+".<") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink([T].arbitrary) { (ys: [T]) in
        let expected = zip(xs, ys).map{ (x, y) in x < y }
        let actual   = zipWith(xs, ys, <)
        return try? #require( actual == expected )
      }}
}

// @inline(never)
private func prop_gt<T : Arbitrary & Comparable>(_ proxy: T.Type) {
    property(String(describing: T.self)+".>") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink([T].arbitrary) { (ys: [T]) in
        let expected = zip(xs, ys).map{ (x, y) in x > y }
        let actual   = zipWith(xs, ys, >)
        return try? #require( actual == expected )
      }}
}

// @inline(never)
private func prop_lte<T : Arbitrary & Comparable>(_ proxy: T.Type) {
    property(String(describing: T.self)+".<=") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink([T].arbitrary) { (ys: [T]) in
        let expected = zip(xs, ys).map{ (x, y) in x <= y }
        let actual   = zipWith(xs, ys, <=)
        return try? #require( actual == expected )
      }}
}

// @inline(never)
private func prop_gte<T : Arbitrary & Comparable>(_ proxy: T.Type) {
    property(String(describing: T.self)+".>=") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink([T].arbitrary) { (ys: [T]) in
        let expected = zip(xs, ys).map{ (x, y) in x >= y }
        let actual   = zipWith(xs, ys, >=)
        return try? #require( actual == expected )
      }}
}

// @inline(never)
private func prop_min<T : Arbitrary & Comparable>(_ proxy: T.Type) {
    property(String(describing: T.self)+".>=") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink([T].arbitrary) { (ys: [T]) in
        let expected = zip(xs, ys).map{ (x, y) in min(x, y) }
        let actual   = zipWith(xs, ys) { (x, y) in min(x, y) }
        return try? #require( actual == expected )
      }}
}

// @inline(never)
private func prop_max<T : Arbitrary & Comparable>(_ proxy: T.Type) {
    property(String(describing: T.self)+".>=") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink([T].arbitrary) { (ys: [T]) in
        let expected = zip(xs, ys).map{ (x, y) in max(x, y) }
        let actual   = zipWith(xs, ys) { (x, y) in max(x, y) }
        return try? #require( actual == expected )
      }}
}


// MARK: SignedNumeric

// @inline(never)
private func prop_negate<T : Arbitrary & SignedNumeric>(_ proxy: T.Type) {
    property(String(describing: T.self)+".negate") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { x in -x }
        let actual   = map(xs) { x in -x }
        return try? #require( actual == expected )
    }
}

// @inline(never)
private func prop_abs<T : Arbitrary & Comparable & SignedNumeric>(_ proxy: T.Type) {
    property(String(describing: T.self)+".abs") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { abs($0) }
        let actual   = map(xs) { abs($0) }
        return try? #require( actual == expected )
    }
}

// MARK: BinaryInteger

// @inline(never)
private func prop_signum<T : Arbitrary & BinaryInteger>(_ proxy: T.Type) {
    property(String(describing: T.self)+".signum") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { $0.signum() }
        let actual   = map(xs) { $0.signum() }
        return try? #require( actual == expected )
    }
}

// MARK: AdditiveArithmetic

// @inline(never)
private func prop_plus<T : Arbitrary & AdditiveArithmetic>(_ proxy: T.Type) {
    property(String(describing: T.self)+".+") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink([T].arbitrary) { (ys: [T]) in
        let expected = zip(xs, ys).map{ (x, y) in x + y }
        let actual   = zipWith(xs, ys, +)
        return try? #require( actual == expected )
      }}
}

// @inline(never)
private func prop_minus<T : Arbitrary & AdditiveArithmetic>(_ proxy: T.Type) {
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
private func prop_mul<T : Arbitrary & Numeric>(_ proxy: T.Type) {
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
private func prop_quot<T : Arbitrary & BinaryInteger>(_ proxy: T.Type) {
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
private func prop_rem<T : Arbitrary & BinaryInteger>(_ proxy: T.Type) {
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
private func prop_quotientAndRemainder<T : Arbitrary & BinaryInteger>(_ proxy: T.Type) {
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
private func prop_isMultiple<T : Arbitrary & BinaryInteger>(_ proxy: T.Type) {
    property(String(describing: T.self)+"./") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink([T].arbitrary) { (ys: [T]) in
        let expected = zip(xs, ys).map{ (x, y) in x.isMultiple(of: y) }
        let actual   = zipWith(xs, ys) { (x, y) in x.isMultiple(of: y) }
        return try? #require( actual == expected )
      }}
}

// @inline(never)
private func prop_and<T : Arbitrary & BinaryInteger>(_ proxy: T.Type) {
    property(String(describing: T.self)+".&") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink([T].arbitrary) { (ys: [T]) in
        let expected = zip(xs, ys).map{ (x, y) in x & y }
        let actual   = zipWith(xs, ys, &)
        return try? #require( actual == expected )
      }}
}

// @inline(never)
private func prop_or<T : Arbitrary & BinaryInteger>(_ proxy: T.Type) {
    property(String(describing: T.self)+".&") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink([T].arbitrary) { (ys: [T]) in
        let expected = zip(xs, ys).map{ (x, y) in x | y }
        let actual   = zipWith(xs, ys, |)
        return try? #require( actual == expected )
      }}
}

// @inline(never)
private func prop_xor<T : Arbitrary & BinaryInteger>(_ proxy: T.Type) {
    property(String(describing: T.self)+".&") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink([T].arbitrary) { (ys: [T]) in
        let expected = zip(xs, ys).map{ (x, y) in x ^ y }
        let actual   = zipWith(xs, ys, ^)
        return try? #require( actual == expected )
      }}
}

// @inline(never)
private func prop_shiftL<T : Arbitrary & BinaryInteger>(_ proxy: T.Type) {
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
private func prop_shiftR<T : Arbitrary & BinaryInteger>(_ proxy: T.Type) {
    let gen = Gen<Int>.choose((-T.zero.bitWidth, T.zero.bitWidth))
    property(String(describing: T.self)+".>>") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink(gen.proliferate) { (ys: [Int]) in
        let expected = zip(xs, ys).map{ (x, y) in x >> y }
        let actual   = zipWith(xs, ys, >>)
        return try? #require( actual == expected )
      }}
}

// @inline(never)
private func prop_complement<T: Arbitrary & BinaryInteger>(_ proxy: T.Type) {
    property(String(describing: T.self)+".complement") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { ~$0 }
        let actual   = map(xs) { ~$0 }
        return try? #require( actual == expected )
    }
}

// @inline(never)
private func prop_trailingZeroBitCount<T: Arbitrary & BinaryInteger>(_ proxy: T.Type) {
    property(String(describing: T.self)+".trailingZeroBitCount") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { $0.trailingZeroBitCount }
        let actual   = map(xs) { $0.trailingZeroBitCount }
        return try? #require( actual == expected )
    }
}

// MARK: FixedWidthInteger

// @inline(never)
private func prop_leadingZeroBitCount<T: Arbitrary & FixedWidthInteger>(_ proxy: T.Type) {
    property(String(describing: T.self)+".leadingZeroBitCount") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { $0.leadingZeroBitCount }
        let actual   = map(xs) { $0.leadingZeroBitCount }
        return try? #require( actual == expected )
    }
}

// @inline(never)
private func prop_nonzeroBitCount<T: Arbitrary & FixedWidthInteger>(_ proxy: T.Type) {
    property(String(describing: T.self)+".nonzeroBitCount") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { $0.nonzeroBitCount }
        let actual   = map(xs) { $0.nonzeroBitCount }
        return try? #require( actual == expected )
    }
}

// @inline(never)
private func prop_byteSwapped<T: Arbitrary & FixedWidthInteger>(_ proxy: T.Type) {
    property(String(describing: T.self)+".byteSwapped") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { $0.byteSwapped }
        let actual   = map(xs) { $0.byteSwapped }
        return try? #require( actual == expected )
    }
}

// @inline(never)
private func prop_littleEndian<T: Arbitrary & FixedWidthInteger>(_ proxy: T.Type) {
    property(String(describing: T.self)+".littleEndian") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { $0.littleEndian }
        let actual   = map(xs) { $0.littleEndian }
        return try? #require( actual == expected )
    }
}

// @inline(never)
private func prop_bigEndian<T: Arbitrary & FixedWidthInteger>(_ proxy: T.Type) {
    property(String(describing: T.self)+".bigEndian") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { $0.bigEndian }
        let actual   = map(xs) { $0.bigEndian }
        return try? #require( actual == expected )
    }
}


// @inline(never)
private func prop_uncheckedPlus<T : Arbitrary & FixedWidthInteger>(_ proxy: T.Type) {
    property(String(describing: T.self)+".&*") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink([T].arbitrary) { (ys: [T]) in
        let expected = zip(xs, ys).map{ (x, y) in x &+ y }
        let actual   = zipWith(xs, ys, &+)
        return try? #require( actual == expected )
      }}
}

// @inline(never)
private func prop_uncheckedMinus<T : Arbitrary & FixedWidthInteger>(_ proxy: T.Type) {
    property(String(describing: T.self)+".&-") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink([T].arbitrary) { (ys: [T]) in
        let expected = zip(xs, ys).map{ (x, y) in x &+ y }
        let actual   = zipWith(xs, ys, &+)
        return try? #require( actual == expected )
      }}
}

// @inline(never)
private func prop_uncheckedMul<T : Arbitrary & FixedWidthInteger>(_ proxy: T.Type) {
    property(String(describing: T.self)+".&*") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink([T].arbitrary) { (ys: [T]) in
        let expected = zip(xs, ys).map{ (x, y) in x &* y }
        let actual   = zipWith(xs, ys, &*)
        return try? #require( actual == expected )
      }}
}

// @inline(never)
private func prop_uncheckedShiftL<T : Arbitrary & RandomType & FixedWidthInteger>(_ proxy: T.Type) {
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
private func prop_uncheckedShiftR<T : Arbitrary & RandomType & FixedWidthInteger>(_ proxy: T.Type) {
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
private func prop_addingReportingOverflow<T : Arbitrary & FixedWidthInteger>(_ proxy: T.Type) {
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
private func prop_subtractingReportingOverflow<T : Arbitrary & FixedWidthInteger>(_ proxy: T.Type) {
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
private func prop_multipliedReportingOverflow<T : Arbitrary & FixedWidthInteger>(_ proxy: T.Type) {
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
private func prop_dividedReportingOverflow<T : Arbitrary & FixedWidthInteger>(_ proxy: T.Type) {
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
private func prop_remainderReportingOverflow<T : Arbitrary & FixedWidthInteger>(_ proxy: T.Type) {
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
private func prop_multipliedFullWidth<T : Arbitrary & FixedWidthInteger>(_ proxy: T.Type) {
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
private func prop_dividingFullWidth<T : Arbitrary & FixedWidthInteger>(_ proxy: T.Type)
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
private func prop_quot<T : Arbitrary & Similar & FloatingPoint>(_ proxy: T.Type) {
    let gen = T.arbitrary.suchThat { !($0 ~~~ 0) }
    property(String(describing: T.self)+"./") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink(gen.proliferate) { (ys: [T]) in
        let expected = zip(xs, ys).map{ (x, y) in x / y }
        let actual   = zipWith(xs, ys, /)
        return try? #require( actual ~~~ expected )
      }}
}

// @inline(never)
private func prop_exponent<T: Arbitrary & FloatingPoint>(_ proxy: T.Type) {
    property(String(describing: T.self)+".exponent") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { $0.exponent }
        let actual   = map(xs) { $0.exponent }
        return try? #require( actual == expected )
    }
}

// @inline(never)
private func prop_floatingPointClass<T: Arbitrary & FloatingPoint>(_ proxy: T.Type) {
    property(String(describing: T.self)+".floatingPointClass") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { $0.floatingPointClass }
        let actual   = map(xs) { $0.floatingPointClass }
        return try? #require( actual == expected )
    }
}

// @inline(never)
private func prop_isCanonical<T: Arbitrary & FloatingPoint>(_ proxy: T.Type) {
    property(String(describing: T.self)+".isCanonical") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { $0.isCanonical }
        let actual   = map(xs) { $0.isCanonical }
        return try? #require( actual == expected )
    }
}

// @inline(never)
private func prop_isFinite<T: Arbitrary & FloatingPoint>(_ proxy: T.Type) {
    property(String(describing: T.self)+".isFinite") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { $0.isFinite }
        let actual   = map(xs) { $0.isFinite }
        return try? #require( actual == expected )
    }
}

// @inline(never)
private func prop_isInfinite<T: Arbitrary & FloatingPoint>(_ proxy: T.Type) {
    property(String(describing: T.self)+".isInfinite") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { $0.isInfinite }
        let actual   = map(xs) { $0.isInfinite }
        return try? #require( actual == expected )
    }
}

// @inline(never)
private func prop_isNaN<T: Arbitrary & FloatingPoint>(_ proxy: T.Type) {
    property(String(describing: T.self)+".isNaN") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { $0.isNaN }
        let actual   = map(xs) { $0.isNaN }
        return try? #require( actual == expected )
    }
}

// @inline(never)
private func prop_isSignalingNaN<T: Arbitrary & FloatingPoint>(_ proxy: T.Type) {
    property(String(describing: T.self)+".isSignalingNaN") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { $0.isSignalingNaN }
        let actual   = map(xs) { $0.isSignalingNaN }
        return try? #require( actual == expected )
    }
}

// @inline(never)
private func prop_isNormal<T: Arbitrary & FloatingPoint>(_ proxy: T.Type) {
    property(String(describing: T.self)+".isNormal") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { $0.isNormal }
        let actual   = map(xs) { $0.isNormal }
        return try? #require( actual == expected )
    }
}

// @inline(never)
private func prop_isSubnormal<T: Arbitrary & FloatingPoint>(_ proxy: T.Type) {
    property(String(describing: T.self)+".isSubnormal") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { $0.isSubnormal }
        let actual   = map(xs) { $0.isSubnormal }
        return try? #require( actual == expected )
    }
}

// @inline(never)
private func prop_isZero<T: Arbitrary & FloatingPoint>(_ proxy: T.Type) {
    property(String(describing: T.self)+".isZero") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { $0.isZero }
        let actual   = map(xs) { $0.isZero }
        return try? #require( actual == expected )
    }
}

// @inline(never)
private func prop_nextDown<T: Arbitrary & FloatingPoint>(_ proxy: T.Type) {
    property(String(describing: T.self)+".nextDown") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { $0.nextDown }
        let actual   = map(xs) { $0.nextDown }
        return try? #require( actual == expected )
    }
}

// @inline(never)
private func prop_nextUp<T: Arbitrary & FloatingPoint>(_ proxy: T.Type) {
    property(String(describing: T.self)+".nextUp") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { $0.nextUp }
        let actual   = map(xs) { $0.nextUp }
        return try? #require( actual == expected )
    }
}

// @inline(never)
private func prop_sign<T: Arbitrary & FloatingPoint>(_ proxy: T.Type) {
    property(String(describing: T.self)+".sign") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { $0.sign }
        let actual   = map(xs) { $0.sign }
        return try? #require( actual == expected )
    }
}

// @inline(never)
private func prop_significand<T: Arbitrary & FloatingPoint>(_ proxy: T.Type) {
    property(String(describing: T.self)+".significand") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { $0.significand }
        let actual   = map(xs) { $0.significand }
        return try? #require( actual == expected )
    }
}

// @inline(never)
private func prop_ulp<T: Arbitrary & FloatingPoint>(_ proxy: T.Type) {
    let gen = T.arbitrary.suchThat { !($0.isInfinite) } // Float16
    property(String(describing: T.self)+".ulp") <-
      forAllNoShrink(gen.proliferate) { (xs: [T]) in
        let expected = xs.map { $0.ulp }
        let actual   = map(xs) { $0.ulp }
        return try? #require( actual == expected )
    }
}

// @inline(never)
private func prop_rounded<T: Arbitrary & FloatingPoint>(_ proxy: T.Type) {
    property(String(describing: T.self)+".rounded") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { $0.rounded() }
        let actual   = map(xs) { $0.rounded() }
        return try? #require( actual == expected )
    }
}

// Not working ):
// @inline(never)
private func prop_roundedWithRoundingRule<T: Arbitrary & FloatingPoint>(_ proxy: T.Type) {
    property(String(describing: T.self)+".roundedWithRoundingRule") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink(FloatingPointRoundingRule.arbitrary) { (rule: FloatingPointRoundingRule) in
        let expected = xs.map { $0.rounded(rule) }
        let actual   = map(xs) { $0.rounded(rule) }
        return try? #require( actual == expected )
    }}
}

// @inline(never)
private func prop_floor<T: Arbitrary & FloatingPoint>(_ proxy: T.Type) {
    property(String(describing: T.self)+".floor") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { $0.rounded(.down) }
        let actual   = map(xs) { $0.rounded(.down) }
        return try? #require( actual == expected )
    }
}

// @inline(never)
private func prop_ceiling<T: Arbitrary & FloatingPoint>(_ proxy: T.Type) {
    property(String(describing: T.self)+".ceiling") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { $0.rounded(.up) }
        let actual   = map(xs) { $0.rounded(.up) }
        return try? #require( actual == expected )
    }
}

// @inline(never)
private func prop_truncate<T: Arbitrary & FloatingPoint>(_ proxy: T.Type) {
    property(String(describing: T.self)+".truncate") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { $0.rounded(.towardZero) }
        let actual   = map(xs) { $0.rounded(.towardZero) }
        return try? #require( actual == expected )
    }
}

// MARK: swift-numerics

// @inline(never)
private func prop_pow<T : Arbitrary & Similar & ElementaryFunctions>(_ proxy: T.Type) {
    property(String(describing: T.self)+"pow") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink([T].arbitrary) { (ys: [T]) in
        let expected = zip(xs, ys).map{ (x, y) in T.pow(x, y) }
        let actual   = zipWith(xs, ys) { (x, y) in T.pow(x, y) }
        return try? #require( actual ~~~ expected )
      }}
}

// @inline(never)
private func prop_powi<T : Arbitrary & Similar & ElementaryFunctions>(_ proxy: T.Type) {
    property(String(describing: T.self)+"powi") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink([Int].arbitrary) { (ys: [Int]) in
        let expected = zip(xs, ys).map{ (x, y) in T.pow(x, y) }
        let actual   = zipWith(xs, ys) { (x, y) in T.pow(x, y) }
        return try? #require( actual ~~~ expected )
      }}
}

// @inline(never)
private func prop_sqrt<T: Arbitrary & Similar & RandomType & FloatingPoint & ElementaryFunctions>(_ proxy: T.Type) {
    let gen = Gen.sized { size in Gen.choose((0, T(size))) }
    property(String(describing: T.self)+".sqrt") <-
      forAllNoShrink(gen.proliferate) { (xs: [T]) in
        let expected = xs.map { T.sqrt($0) }
        let actual   = map(xs) { T.sqrt($0) }
        return try? #require( actual ~~~ expected )
    }
}

// @inline(never)
private func prop_reciprocal<T: Arbitrary & Similar & RandomType & AlgebraicField>(_ proxy: T.Type) {
    property(String(describing: T.self)+".reciprocal") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { $0.reciprocal }
        let actual   = map(xs) { $0.reciprocal }
        return try? #require( actual ~~~ expected )
    }
}

// @inline(never)
private func prop_exp<T: Arbitrary & Similar & ElementaryFunctions>(_ proxy: T.Type) {
    property(String(describing: T.self)+".exp") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { T.exp($0) }
        let actual   = map(xs) { T.exp($0) }
        return try? #require( actual ~~~ expected )
    }
}

// @inline(never)
private func prop_exp2<T: Arbitrary & Similar & RealFunctions>(_ proxy: T.Type) {
    property(String(describing: T.self)+".ex2p") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { T.exp2($0) }
        let actual   = map(xs) { T.exp2($0) }
        return try? #require( actual ~~~ expected )
    }
}

// @inline(never)
private func prop_exp10<T: Arbitrary & Similar & RealFunctions>(_ proxy: T.Type) {
    property(String(describing: T.self)+".exp10") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { T.exp10($0) }
        let actual   = map(xs) { T.exp10($0) }
        return try? #require( actual ~~~ expected )
    }
}

// @inline(never)
private func prop_expMinusOne<T: Arbitrary & Similar & ElementaryFunctions>(_ proxy: T.Type) {
    property(String(describing: T.self)+".expMinusOne") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { T.expMinusOne($0) }
        let actual   = map(xs) { T.expMinusOne($0) }
        return try? #require( actual ~~~ expected )
    }
}

// @inline(never)
private func prop_log<T: Arbitrary & Similar & RandomType & FloatingPoint & ElementaryFunctions>(_ proxy: T.Type) {
    let gen = Gen.sized { size in Gen.choose((T(0).nextUp, T(size))) }
    property(String(describing: T.self)+".log") <-
      forAllNoShrink(gen.proliferate) { (xs: [T]) in
        let expected = xs.map { T.log($0) }
        let actual   = map(xs) { T.log($0) }
        return try? #require( actual ~~~ expected )
    }
}

// @inline(never)
private func prop_log2<T: Arbitrary & Similar & RandomType & FloatingPoint & RealFunctions>(_ proxy: T.Type) {
    let gen = Gen.sized { size in Gen.choose((T(0).nextUp, T(size))) }
    property(String(describing: T.self)+".log2") <-
      forAllNoShrink(gen.proliferate) { (xs: [T]) in
        let expected = xs.map { T.log2($0) }
        let actual   = map(xs) { T.log2($0) }
        return try? #require( actual ~~~ expected )
    }
}

// @inline(never)
private func prop_log10<T: Arbitrary & Similar & RandomType & FloatingPoint & RealFunctions>(_ proxy: T.Type) {
    let gen = Gen.sized { size in Gen.choose((T(0).nextUp, T(size))) }
    property(String(describing: T.self)+".log10") <-
      forAllNoShrink(gen.proliferate) { (xs: [T]) in
        let expected = xs.map { T.log10($0) }
        let actual   = map(xs) { T.log10($0) }
        return try? #require( actual ~~~ expected )
    }
}

// @inline(never)
private func prop_logOnePlus<T: Arbitrary & Similar & RandomType & FloatingPoint & ElementaryFunctions>(_ proxy: T.Type) {
    let gen = Gen.sized { size in Gen.choose((T(-1).nextUp, T(size))) }
    property(String(describing: T.self)+".logOnePlus") <-
      forAllNoShrink(gen.proliferate) { (xs: [T]) in
        let expected = xs.map { T.log(onePlus: $0) }
        let actual   = map(xs) { T.log(onePlus: $0) }
        return try? #require( actual ~~~ expected )
    }
}

// @inline(never)
private func prop_sin<T: Arbitrary & Similar & ElementaryFunctions>(_ proxy: T.Type) {
    property(String(describing: T.self)+".sin") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { T.sin($0) }
        let actual   = map(xs) { T.sin($0) }
        return try? #require( actual ~~~ expected )
    }
}

// @inline(never)
private func prop_cos<T: Arbitrary & Similar & ElementaryFunctions>(_ proxy: T.Type) {
    property(String(describing: T.self)+".cos") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { T.cos($0) }
        let actual   = map(xs) { T.cos($0) }
        return try? #require( actual ~~~ expected )
    }
}

// @inline(never)
private func prop_tan<T: Arbitrary & Similar & FloatingPoint & ElementaryFunctions>(_ proxy: T.Type) {
    let gen = T.arbitrary.suchThat { !($0 ~~~ 0) }
    property(String(describing: T.self)+".tan") <-
      forAllNoShrink(gen.proliferate) { (xs: [T]) in
        let expected = xs.map { T.tan($0) }
        let actual   = map(xs) { T.tan($0) }
        return try? #require( actual ~~~ expected )
    }
}

// @inline(never)
private func prop_asin<T: Arbitrary & Similar & RandomType & FloatingPoint & ElementaryFunctions>(_ proxy: T.Type) {
    let gen = Gen.choose((T(-1), T(1)))
    property(String(describing: T.self)+".asin") <-
      forAllNoShrink(gen.proliferate) { (xs: [T]) in
        let expected = xs.map { T.asin($0) }
        let actual   = map(xs) { T.asin($0) }
        return try? #require( actual ~~~ expected )
    }
}

// @inline(never)
private func prop_acos<T: Arbitrary & Similar & RandomType & FloatingPoint & ElementaryFunctions>(_ proxy: T.Type) {
    let gen = Gen.choose((T(-1), T(1)))
    property(String(describing: T.self)+".acos") <-
      forAllNoShrink(gen.proliferate) { (xs: [T]) in
        let expected = xs.map { T.acos($0) }
        let actual   = map(xs) { T.acos($0) }
        return try? #require( actual ~~~ expected )
    }
}

// @inline(never)
private func prop_atan<T: Arbitrary & Similar & FloatingPoint & ElementaryFunctions>(_ proxy: T.Type) {
    property(String(describing: T.self)+".atan") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { T.atan($0) }
        let actual   = map(xs) { T.atan($0) }
        return try? #require( actual ~~~ expected )
    }
}

// @inline(never)
private func prop_sinh<T: Arbitrary & Similar & ElementaryFunctions>(_ proxy: T.Type) {
    property(String(describing: T.self)+".sinh") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { T.sinh($0) }
        let actual   = map(xs) { T.sinh($0) }
        return try? #require( actual ~~~ expected )
    }
}

// @inline(never)
private func prop_cosh<T: Arbitrary & Similar & ElementaryFunctions>(_ proxy: T.Type) {
    property(String(describing: T.self)+".cosh") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { T.cosh($0) }
        let actual   = map(xs) { T.cosh($0) }
        return try? #require( actual ~~~ expected )
    }
}

// @inline(never)
private func prop_tanh<T: Arbitrary & Similar & ElementaryFunctions>(_ proxy: T.Type) {
    property(String(describing: T.self)+".tanh") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { T.tanh($0) }
        let actual   = map(xs) { T.tanh($0) }
        return try? #require( actual ~~~ expected )
    }
}

// @inline(never)
private func prop_asinh<T: Arbitrary & Similar & ElementaryFunctions>(_ proxy: T.Type) {
    property(String(describing: T.self)+".asinh") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { T.asinh($0) }
        let actual   = map(xs) { T.asinh($0) }
        return try? #require( actual ~~~ expected )
    }
}

// @inline(never)
private func prop_acosh<T: Arbitrary & Similar & RandomType & FloatingPoint & ElementaryFunctions>(_ proxy: T.Type) {
    let gen = Gen.sized { size in Gen.choose((T(1), T(size))) }
    property(String(describing: T.self)+".acosh") <-
      forAllNoShrink(gen.proliferate) { (xs: [T]) in
        let expected = xs.map { T.acosh($0) }
        let actual   = map(xs) { T.acosh($0) }
        return try? #require( actual ~~~ expected )
    }
}

// @inline(never)
private func prop_atanh<T: Arbitrary & Similar & RandomType & FloatingPoint & ElementaryFunctions>(_ proxy: T.Type) {
    let gen = Gen.choose((T(-1), T(1)))
    property(String(describing: T.self)+".atanh") <-
      forAllNoShrink(gen.proliferate) { (xs: [T]) in
        let expected = xs.map { T.atanh($0) }
        let actual   = map(xs) { T.atanh($0) }
        return try? #require( actual ~~~ expected )
    }
}

// @inline(never)
private func prop_atan2<T : Arbitrary & Similar & RealFunctions>(_ proxy: T.Type) {
    property(String(describing: T.self)+"atan2") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink([T].arbitrary) { (ys: [T]) in
        let expected = zip(xs, ys).map{ (x, y) in T.atan2(y: y, x: x) }
        let actual   = zipWith(xs, ys) { (x, y) in T.atan2(y: y, x: x) }
        return try? #require( actual ~~~ expected )
      }}
}

// @inline(never)
private func prop_erf<T: Arbitrary & Similar & RealFunctions>(_ proxy: T.Type) {
    property(String(describing: T.self)+".erf") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { T.erf($0) }
        let actual   = map(xs) { T.erf($0) }
        return try? #require( actual ~~~ expected )
    }
}

// @inline(never)
private func prop_erfc<T: Arbitrary & Similar & RealFunctions>(_ proxy: T.Type) {
    property(String(describing: T.self)+".erfc") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { T.erfc($0) }
        let actual   = map(xs) { T.erfc($0) }
        return try? #require( actual ~~~ expected )
    }
}

// @inline(never)
private func prop_gamma<T: Arbitrary & Similar & RealFunctions>(_ proxy: T.Type) {
    property(String(describing: T.self)+".gamma") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { T.gamma($0) }
        let actual   = map(xs) { T.gamma($0) }
        return try? #require( actual ~~~ expected )
    }
}

// @inline(never)
private func prop_logGamma<T: Arbitrary & Similar & RealFunctions>(_ proxy: T.Type) {
    property(String(describing: T.self)+".logGamma") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { T.logGamma($0) }
        let actual   = map(xs) { T.logGamma($0) }
        return try? #require( actual ~~~ expected )
    }
}

// @inline(never)
private func prop_hypot<T : Arbitrary & Similar & RealFunctions>(_ proxy: T.Type) {
    property(String(describing: T.self)+"hypot") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink([T].arbitrary) { (ys: [T]) in
        let expected = zip(xs, ys).map{ (x, y) in T.hypot(x, y) }
        let actual   = zipWith(xs, ys) { (x, y) in T.hypot(x, y) }
        return try? #require( actual ~~~ expected )
      }}
}


