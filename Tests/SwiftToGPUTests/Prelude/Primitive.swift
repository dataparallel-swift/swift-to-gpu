// Copyright (c) 2025 PassiveLogic, Inc.

import Numerics
import SwiftCheck
import SwiftToGPU
import Testing

// swiftlint:disable file_length
// swiftformat:disable indent,braces

@Suite("Primitive") struct PrimitiveTests {
    @Suite("Bool") struct BoolTests {
        @Test("Bool.==") func eq() { eqTest(Bool.self) }
        @Test("Bool.!=") func neq() { neqTest(Bool.self) }
        @Test("Bool.!") func lnot() { lnotTest() }
        @Test("Bool.||") func lor() { lorTest() }
        @Test("Bool.&&") func land() { landTest() }
    }

    @Suite("Int8") struct Int8Tests {
        // Ordering
        @Test("Int8.==") func eq() { eqTest(Int8.self) }
        @Test("Int8.!=") func neq() { neqTest(Int8.self) }
        @Test("Int8.<") func lt() { ltTest(Int8.self) }
        @Test("Int8.>") func gt() { gtTest(Int8.self) }
        @Test("Int8.<=") func lte() { lteTest(Int8.self) }
        @Test("Int8.>=") func gte() { gteTest(Int8.self) }
        @Test("Int8.min") func min() { minTest(Int8.self) }
        @Test("Int8.max") func max() { maxTest(Int8.self) }

        // Numeric
        @Test("Int8.negate") func negate() { negateTest(Int8.self) }
        @Test("Int8.abs") func abs() { absTest(Int8.self) }
        @Test("Int8.signum") func signum() { signumTest(Int8.self) }
        // @Test("Int8.+", .bug(id: "86b4gq1tv")) func plus() { plusTest(Int8.self) }
        @Test("Int8.avoiding_overflow.+") func plusAvoidingOverflow() { plusAvoidingOverflowTest(Int8.self) }
        // @Test("Int8.-", .bug(id: "86b4gq1tv")) func minus() { minusTest(Int8.self) }
        @Test("Int8.avoiding_underflow.-") func minusAvoidingUnderflow() { minusAvoidingUnderflowTest(Int8.self) }
        // @Test("Int8.*", .bug(id: "86b4gq1tv")) func mul() { mulTest(Int8.self) }
        @Test("Int8.avoiding_overflow.*") func mulAvoidingOverflow() { mulAvoidingOverflowTest(Int8.self) }
        @Test("Int8./") func quot() { quotTest(Int8.self) }
        @Test("Int8.%") func rem() { remTest(Int8.self) }
        @Test("Int8.&+") func uncheckedPlus() { uncheckedPlusTest(Int8.self) }
        @Test("Int8.&-") func uncheckedMinus() { uncheckedMinusTest(Int8.self) }
        @Test("Int8.&*") func uncheckedMul() { uncheckedMulTest(Int8.self) }
        @Test("Int8.quotientAndRemainder") func quotientAndRemainder() { quotientAndRemainderTest(Int8.self) }
        @Test("Int8.isMultiple") func isMultiple() { isMultipleTest(Int8.self) }
        @Test("Int8.addingReportingOverflow") func addingReportingOverflow() { addingReportingOverflowTest(Int8.self) }
        @Test("Int8.subtractingReportingOverflow") func subtractingReportingOverflow() { subtractingReportingOverflowTest(Int8.self) }
        @Test("Int8.multipliedReportingOverflow") func multipliedReportingOverflow() { multipliedReportingOverflowTest(Int8.self) }
        @Test("Int8.dividedReportingOverflow") func dividedReportingOverflow() { dividedReportingOverflowTest(Int8.self) }
        @Test("Int8.remainderReportingOverflow") func remainderReportingOverflow() { remainderReportingOverflowTest(Int8.self) }
        @Test("Int8.multipliedFullWidth") func multipliedFullWidth() { multipliedFullWidthTest(Int8.self) }
        // @Test("Int8.dividingFullWidth", .bug(id: "86b4gqe8t")) func dividingFullWidth() { dividingFullWidthTest(Int8.self) }

        // Bitwise
        @Test("Int8.complement") func complement() { complementTest(Int8.self) }
        @Test("Int8.zeroBitCount") func nonzeroBitCount() { nonzeroBitCountTest(Int8.self) }
        @Test("Int8.leadingZeroBitCount") func leadingZeroBitCount() { leadingZeroBitCountTest(Int8.self) }
        @Test("Int8.trailingZeroBitCount") func trailingZeroBitCount() { trailingZeroBitCountTest(Int8.self) }
        @Test("Int8.byteSwapped") func byteSwapped() { byteSwappedTest(Int8.self) }
        @Test("Int8.littleEndian") func littleEndian() { littleEndianTest(Int8.self) }
        @Test("Int8.bigEndian") func bigEndian() { bigEndianTest(Int8.self) }
        @Test("Int8.&") func and() { andTest(Int8.self) }
        @Test("Int8.|") func or() { orTest(Int8.self) }
        @Test("Int8.^") func xor() { xorTest(Int8.self) }
        @Test("Int8.<<") func shiftL() { shiftLTest(Int8.self) }
        @Test("Int8.>>") func shiftR() { shiftRTest(Int8.self) }
        @Test("Int8.&<<") func uncheckedShiftL() { uncheckedShiftLTest(Int8.self) }
        @Test("Int8.&>>") func uncheckedShiftR() { uncheckedShiftRTest(Int8.self) }
    }

    @Suite("Int16") struct Int16Tests {
        // Ordering
        @Test("Int16.==") func eq() { eqTest(Int16.self) }
        @Test("Int16.!=") func neq() { neqTest(Int16.self) }
        @Test("Int16.<") func lt() { ltTest(Int16.self) }
        @Test("Int16.>") func gt() { gtTest(Int16.self) }
        @Test("Int16.<=") func lte() { lteTest(Int16.self) }
        @Test("Int16.>=") func gte() { gteTest(Int16.self) }
        @Test("Int16.min") func min() { minTest(Int16.self) }
        @Test("Int16.max") func max() { maxTest(Int16.self) }

        // Numeric
        @Test("Int16.negate") func negate() { negateTest(Int16.self) }
        @Test("Int16.abs") func abs() { absTest(Int16.self) }
        @Test("Int16.signum") func signum() { signumTest(Int16.self) }
        @Test("Int16.+") func plus() { plusTest(Int16.self) }
        @Test("Int16.-") func minus() { minusTest(Int16.self) }
        @Test("Int16.*") func mul() { mulTest(Int16.self) }
        @Test("Int16./") func quot() { quotTest(Int16.self) }
        @Test("Int16.%") func rem() { remTest(Int16.self) }
        @Test("Int16.&+") func uncheckedPlus() { uncheckedPlusTest(Int16.self) }
        @Test("Int16.&-") func uncheckedMinus() { uncheckedMinusTest(Int16.self) }
        @Test("Int16.&*") func uncheckedMul() { uncheckedMulTest(Int16.self) }
        @Test("Int16.quotientAndRemainder") func quotientAndRemainder() { quotientAndRemainderTest(Int16.self) }
        @Test("Int16.isMultiple") func isMultiple() { isMultipleTest(Int16.self) }
        @Test("Int16.addingReportingOverflow") func addingReportingOverflow() { addingReportingOverflowTest(Int16.self) }
        @Test("Int16.subtractingReportingOverflow") func subtractingReportingOverflow() { subtractingReportingOverflowTest(Int16.self) }
        @Test("Int16.multipliedReportingOverflow") func multipliedReportingOverflow() { multipliedReportingOverflowTest(Int16.self) }
        @Test("Int16.dividedReportingOverflow") func dividedReportingOverflow() { dividedReportingOverflowTest(Int16.self) }
        @Test("Int16.remainderReportingOverflow") func remainderReportingOverflow() { remainderReportingOverflowTest(Int16.self) }
        @Test("Int16.multipliedFullWidth") func multipliedFullWidth() { multipliedFullWidthTest(Int16.self) }
        // @Test("Int16.dividingFullWidth", .bug(id: "86b4gqe8t")) func dividingFullWidth() { dividingFullWidthTest(Int16.self) }

        // Bitwise
        @Test("Int16.complement") func complement() { complementTest(Int16.self) }
        @Test("Int16.zeroBitCount") func nonzeroBitCount() { nonzeroBitCountTest(Int16.self) }
        @Test("Int16.leadingZeroBitCount") func leadingZeroBitCount() { leadingZeroBitCountTest(Int16.self) }
        @Test("Int16.trailingZeroBitCount") func trailingZeroBitCount() { trailingZeroBitCountTest(Int16.self) }
        @Test("Int16.byteSwapped") func byteSwapped() { byteSwappedTest(Int16.self) }
        @Test("Int16.littleEndian") func littleEndian() { littleEndianTest(Int16.self) }
        @Test("Int16.bigEndian") func bigEndian() { bigEndianTest(Int16.self) }
        @Test("Int16.&") func and() { andTest(Int16.self) }
        @Test("Int16.|") func or() { orTest(Int16.self) }
        @Test("Int16.^") func xor() { xorTest(Int16.self) }
        @Test("Int16.<<") func shiftL() { shiftLTest(Int16.self) }
        @Test("Int16.>>") func shiftR() { shiftRTest(Int16.self) }
        @Test("Int16.&<<") func uncheckedShiftL() { uncheckedShiftLTest(Int16.self) }
        @Test("Int16.&>>") func uncheckedShiftR() { uncheckedShiftRTest(Int16.self) }
    }

    @Suite("Int32") struct Int32Tests {
        // Ordering
        @Test("Int32.==") func eq() { eqTest(Int32.self) }
        @Test("Int32.!=") func neq() { neqTest(Int32.self) }
        @Test("Int32.<") func lt() { ltTest(Int32.self) }
        @Test("Int32.>") func gt() { gtTest(Int32.self) }
        @Test("Int32.<=") func lte() { lteTest(Int32.self) }
        @Test("Int32.>=") func gte() { gteTest(Int32.self) }
        @Test("Int32.min") func min() { minTest(Int32.self) }
        @Test("Int32.max") func max() { maxTest(Int32.self) }

        // Numeric
        @Test("Int32.negate") func negate() { negateTest(Int32.self) }
        @Test("Int32.abs") func abs() { absTest(Int32.self) }
        @Test("Int32.signum") func signum() { signumTest(Int32.self) }
        @Test("Int32.+") func plus() { plusTest(Int32.self) }
        @Test("Int32.-") func minus() { minusTest(Int32.self) }
        @Test("Int32.*") func mul() { mulTest(Int32.self) }
        @Test("Int32./") func quot() { quotTest(Int32.self) }
        @Test("Int32.%") func rem() { remTest(Int32.self) }
        @Test("Int32.&+") func uncheckedPlus() { uncheckedPlusTest(Int32.self) }
        @Test("Int32.&-") func uncheckedMinus() { uncheckedMinusTest(Int32.self) }
        @Test("Int32.&*") func uncheckedMul() { uncheckedMulTest(Int32.self) }
        @Test("Int32.quotientAndRemainder") func quotientAndRemainder() { quotientAndRemainderTest(Int32.self) }
        @Test("Int32.isMultiple") func isMultiple() { isMultipleTest(Int32.self) }
        @Test("Int32.addingReportingOverflow") func addingReportingOverflow() { addingReportingOverflowTest(Int32.self) }
        @Test("Int32.subtractingReportingOverflow") func subtractingReportingOverflow() { subtractingReportingOverflowTest(Int32.self) }
        @Test("Int32.multipliedReportingOverflow") func multipliedReportingOverflow() { multipliedReportingOverflowTest(Int32.self) }
        @Test("Int32.dividedReportingOverflow") func dividedReportingOverflow() { dividedReportingOverflowTest(Int32.self) }
        @Test("Int32.remainderReportingOverflow") func remainderReportingOverflow() { remainderReportingOverflowTest(Int32.self) }
        @Test("Int32.multipliedFullWidth") func multipliedFullWidth() { multipliedFullWidthTest(Int32.self) }
        // @Test("Int32.dividingFullWidth", .bug(id: "86b4gqe8t")) func dividingFullWidth() { dividingFullWidthTest(Int32.self) }

        // Bitwise
        @Test("Int32.complement") func complement() { complementTest(Int32.self) }
        @Test("Int32.zeroBitCount") func nonzeroBitCount() { nonzeroBitCountTest(Int32.self) }
        @Test("Int32.leadingZeroBitCount") func leadingZeroBitCount() { leadingZeroBitCountTest(Int32.self) }
        @Test("Int32.trailingZeroBitCount") func trailingZeroBitCount() { trailingZeroBitCountTest(Int32.self) }
        @Test("Int32.byteSwapped") func byteSwapped() { byteSwappedTest(Int32.self) }
        @Test("Int32.littleEndian") func littleEndian() { littleEndianTest(Int32.self) }
        @Test("Int32.bigEndian") func bigEndian() { bigEndianTest(Int32.self) }
        @Test("Int32.&") func and() { andTest(Int32.self) }
        @Test("Int32.|") func or() { orTest(Int32.self) }
        @Test("Int32.^") func xor() { xorTest(Int32.self) }
        @Test("Int32.<<") func shiftL() { shiftLTest(Int32.self) }
        @Test("Int32.>>") func shiftR() { shiftRTest(Int32.self) }
        @Test("Int32.&<<") func uncheckedShiftL() { uncheckedShiftLTest(Int32.self) }
        @Test("Int32.&>>") func uncheckedShiftR() { uncheckedShiftRTest(Int32.self) }
    }

    @Suite("Int64") struct Int64Tests {
        // Ordering
        @Test("Int64.==") func eq() { eqTest(Int64.self) }
        @Test("Int64.!=") func neq() { neqTest(Int64.self) }
        @Test("Int64.<") func lt() { ltTest(Int64.self) }
        @Test("Int64.>") func gt() { gtTest(Int64.self) }
        @Test("Int64.<=") func lte() { lteTest(Int64.self) }
        @Test("Int64.>=") func gte() { gteTest(Int64.self) }
        @Test("Int64.min") func min() { minTest(Int64.self) }
        @Test("Int64.max") func max() { maxTest(Int64.self) }

        // Numeric
        @Test("Int64.negate") func negate() { negateTest(Int64.self) }
        @Test("Int64.abs") func abs() { absTest(Int64.self) }
        @Test("Int64.signum") func signum() { signumTest(Int64.self) }
        @Test("Int64.+") func plus() { plusTest(Int64.self) }
        @Test("Int64.-") func minus() { minusTest(Int64.self) }
        @Test("Int64.*") func mul() { mulTest(Int64.self) }
        @Test("Int64./") func quot() { quotTest(Int64.self) }
        @Test("Int64.%") func rem() { remTest(Int64.self) }
        @Test("Int64.&+") func uncheckedPlus() { uncheckedPlusTest(Int64.self) }
        @Test("Int64.&-") func uncheckedMinus() { uncheckedMinusTest(Int64.self) }
        @Test("Int64.&*") func uncheckedMul() { uncheckedMulTest(Int64.self) }
        @Test("Int64.quotientAndRemainder") func quotientAndRemainder() { quotientAndRemainderTest(Int64.self) }
        @Test("Int64.isMultiple") func isMultiple() { isMultipleTest(Int64.self) }
        @Test("Int64.addingReportingOverflow") func addingReportingOverflow() { addingReportingOverflowTest(Int64.self) }
        @Test("Int64.subtractingReportingOverflow") func subtractingRepontingOverflow() { subtractingReportingOverflowTest(Int64.self) }
        @Test("Int64.multipliedReportingOverflow") func multipliedReportingOverflow() { multipliedReportingOverflowTest(Int64.self) }
        @Test("Int64.dividedReportingOverflow") func dividedReportingOverflow() { dividedReportingOverflowTest(Int64.self) }
        @Test("Int64.remainderReportingOverflow") func remainderReportingOverflow() { remainderReportingOverflowTest(Int64.self) }
        @Test("Int64.multipliedFullWidth") func multipliedFullWidth() { multipliedFullWidthTest(Int64.self) }
        // @Test("Int64.dividingFullWidth", .bug(id: "86b4gqe8t")) func dividingFullWidth() { dividingFullWidthTest(Int64.self) }

        // Bitwise
        @Test("Int64.complement") func complement() { complementTest(Int64.self) }
        @Test("Int64.zeroBitCount") func nonzeroBitCount() { nonzeroBitCountTest(Int64.self) }
        @Test("Int64.leadingZeroBitCount") func leadingZeroBitCount() { leadingZeroBitCountTest(Int64.self) }
        @Test("Int64.trailingZeroBitCount") func trailingZeroBitCount() { trailingZeroBitCountTest(Int64.self) }
        @Test("Int64.byteSwapped") func byteSwapped() { byteSwappedTest(Int64.self) }
        @Test("Int64.littleEndian") func littleEndian() { littleEndianTest(Int64.self) }
        @Test("Int64.bigEndian") func bigEndian() { bigEndianTest(Int64.self) }
        @Test("Int64.&") func and() { andTest(Int64.self) }
        @Test("Int64.|") func or() { orTest(Int64.self) }
        @Test("Int64.^") func xor() { xorTest(Int64.self) }
        @Test("Int64.<<") func shiftL() { shiftLTest(Int64.self) }
        @Test("Int64.>>") func shiftR() { shiftRTest(Int64.self) }
        @Test("Int64.&<<") func uncheckedShiftL() { uncheckedShiftLTest(Int64.self) }
        @Test("Int64.&>>") func uncheckedShiftR() { uncheckedShiftRTest(Int64.self) }
    }

    @Suite("Int") struct IntTests {
        // Ordering
        @Test("Int.==") func eq() { eqTest(Int.self) }
        @Test("Int.!=") func neq() { neqTest(Int.self) }
        @Test("Int.<") func lt() { ltTest(Int.self) }
        @Test("Int.>") func gt() { gtTest(Int.self) }
        @Test("Int.<=") func lte() { lteTest(Int.self) }
        @Test("Int.>=") func gte() { gteTest(Int.self) }
        @Test("Int.min") func min() { minTest(Int.self) }
        @Test("Int.max") func max() { maxTest(Int.self) }

        // Numeric
        @Test("Int.negate") func negate() { negateTest(Int.self) }
        @Test("Int.abs") func abs() { absTest(Int.self) }
        @Test("Int.signum") func signum() { signumTest(Int.self) }
        @Test("Int.+") func plus() { plusTest(Int.self) }
        @Test("Int.-") func minus() { minusTest(Int.self) }
        @Test("Int.*") func mul() { mulTest(Int.self) }
        @Test("Int./") func quot() { quotTest(Int.self) }
        @Test("Int.%") func rem() { remTest(Int.self) }
        @Test("Int.&+") func uncheckedPlus() { uncheckedPlusTest(Int.self) }
        @Test("Int.&-") func uncheckedMinus() { uncheckedMinusTest(Int.self) }
        @Test("Int.&*") func uncheckedMul() { uncheckedMulTest(Int.self) }
        @Test("Int.quotientAndRemainder") func quotientAndRemainder() { quotientAndRemainderTest(Int.self) }
        @Test("Int.isMultiple") func isMultiple() { isMultipleTest(Int.self) }
        @Test("Int.addingReportingOverflow") func addingReportingOverflow() { addingReportingOverflowTest(Int.self) }
        @Test("Int.subtractingReportingOverflow") func subtractingReportingOverflow() { subtractingReportingOverflowTest(Int.self) }
        @Test("Int.multipliedReportingOverflow") func multipliedReportingOverflow() { multipliedReportingOverflowTest(Int.self) }
        @Test("Int.dividedReportingOverflow") func dividedReportingOverflow() { dividedReportingOverflowTest(Int.self) }
        @Test("Int.remainderReportingOverflow") func remainderReportingOverflow() { remainderReportingOverflowTest(Int.self) }
        @Test("Int.multipliedFullWidth") func multipliedFullWidth() { multipliedFullWidthTest(Int.self) }
        // @Test("Int.dividingFullWidth", .bug(id: "86b4gqe8t")) func dividingFullWidth() { dividingFullWidthTest(Int.self) }

        // Bitwise
        @Test("Int.complement") func complement() { complementTest(Int.self) }
        @Test("Int.zeroBitCount") func nonzeroBitCount() { nonzeroBitCountTest(Int.self) }
        @Test("Int.leadingZeroBitCount") func leadingZeroBitCount() { leadingZeroBitCountTest(Int.self) }
        @Test("Int.trailingZeroBitCount") func trailingZeroBitCount() { trailingZeroBitCountTest(Int.self) }
        @Test("Int.byteSwapped") func byteSwapped() { byteSwappedTest(Int.self) }
        @Test("Int.littleEndian") func littleEndian() { littleEndianTest(Int.self) }
        @Test("Int.bigEndian") func bigEndian() { bigEndianTest(Int.self) }
        @Test("Int.&") func and() { andTest(Int.self) }
        @Test("Int.|") func or() { orTest(Int.self) }
        @Test("Int.^") func xor() { xorTest(Int.self) }
        @Test("Int.<<") func shiftL() { shiftLTest(Int.self) }
        @Test("Int.>>") func shiftR() { shiftRTest(Int.self) }
        @Test("Int.&<<") func uncheckedShiftL() { uncheckedShiftLTest(Int.self) }
        @Test("Int.&>>") func uncheckedShiftR() { uncheckedShiftRTest(Int.self) }
    }

    @Suite("UInt8") struct UInt8Tests {
        // Ordering
        @Test("UInt8.==") func eq() { eqTest(UInt8.self) }
        @Test("UInt8.!=") func neq() { neqTest(UInt8.self) }
        @Test("UInt8.<") func lt() { ltTest(UInt8.self) }
        @Test("UInt8.>") func gt() { gtTest(UInt8.self) }
        @Test("UInt8.<=") func lte() { lteTest(UInt8.self) }
        @Test("UInt8.>=") func gte() { gteTest(UInt8.self) }
        @Test("UInt8.min") func min() { minTest(UInt8.self) }
        @Test("UInt8.max") func max() { maxTest(UInt8.self) }

        // // Numeric
        @Test("UInt8.signum") func signum() { signumTest(UInt8.self) }
        @Test("UInt8.+") func plus() { plusTest(UInt8.self) }
        // @Test("UInt8.-", .bug(id: "86b4gq1tv")) func minus() { minusTest(UInt8.self) }
        @Test("UInt8.avoiding_underflow.-") func minusAvoidingUnderflow() { minusAvoidingUnderflowTest(UInt8.self) }
        // @Test("UInt8.*", .bug(id: "86b4gq1tv")) func mul() { mulTest(UInt8.self) }
        @Test("UInt8.avoiding_overflow.*") func mulAvoidingOverflow() { mulAvoidingOverflowTest(UInt8.self) }
        @Test("UInt8./") func quot() { quotTest(UInt8.self) }
        @Test("UInt8.%") func rem() { remTest(UInt8.self) }
        @Test("UInt8.&+") func uncheckedPlus() { uncheckedPlusTest(UInt8.self) }
        @Test("UInt8.&-") func uncheckedMinus() { uncheckedMinusTest(UInt8.self) }
        @Test("UInt8.&*") func uncheckedMul() { uncheckedMulTest(UInt8.self) }
        @Test("UInt8.quotientAndRemainder") func quotientAndRemainder() { quotientAndRemainderTest(UInt8.self) }
        @Test("UInt8.isMultiple") func isMultiple() { isMultipleTest(UInt8.self) }
        @Test("UInt8.addingReportingOverflow") func addingReportingOverflow() { addingReportingOverflowTest(UInt8.self) }
        @Test("UInt8.subtractingReportingOverflow") func subtractingReportingOverflow() { subtractingReportingOverflowTest(UInt8.self) }
        @Test("UInt8.multipliedReportingOverflow") func multipliedReportingOverflow() { multipliedReportingOverflowTest(UInt8.self) }
        @Test("UInt8.dividedReportingOverflow") func dividedReportingOverflow() { dividedReportingOverflowTest(UInt8.self) }
        @Test("UInt8.remainderReportingOverflow") func remainderReportingOverflow() { remainderReportingOverflowTest(UInt8.self) }
        @Test("UInt8.multipliedFullWidth") func multipliedFullWidth() { multipliedFullWidthTest(UInt8.self) }
        // @Test("UInt8.dividingFullWidth", .bug(id: "86b4gq1tv")) func dividingFullWidth() { dividingFullWidthTest(UInt8.self) }

        // Bitwise
        @Test("UInt8.complement") func complement() { complementTest(UInt8.self) }
        @Test("UInt8.zeroBitCount") func nonzeroBitCount() { nonzeroBitCountTest(UInt8.self) }
        @Test("UInt8.leadingZeroBitCount") func leadingZeroBitCount() { leadingZeroBitCountTest(UInt8.self) }
        @Test("UInt8.trailingZeroBitCount") func trailingZeroBitCount() { trailingZeroBitCountTest(UInt8.self) }
        @Test("UInt8.byteSwapped") func byteSwapped() { byteSwappedTest(UInt8.self) }
        @Test("UInt8.littleEndian") func littleEndian() { littleEndianTest(UInt8.self) }
        @Test("UInt8.bigEndian") func bigEndian() { bigEndianTest(UInt8.self) }
        @Test("UInt8.&") func and() { andTest(UInt8.self) }
        @Test("UInt8.|") func or() { orTest(UInt8.self) }
        @Test("UInt8.^") func xor() { xorTest(UInt8.self) }
        @Test("UInt8.<<") func shiftL() { shiftLTest(UInt8.self) }
        @Test("UInt8.>>") func shiftR() { shiftRTest(UInt8.self) }
        @Test("UInt8.&<<") func uncheckedShiftL() { uncheckedShiftLTest(UInt8.self) }
        @Test("UInt8.&>>") func uncheckedShiftR() { uncheckedShiftRTest(UInt8.self) }
    }

    @Suite("UInt16") struct UInt16Tests {
        // Ordering
        @Test("UInt16.==") func eq() { eqTest(UInt16.self) }
        @Test("UInt16.!=") func neq() { neqTest(UInt16.self) }
        @Test("UInt16.<") func lt() { ltTest(UInt16.self) }
        @Test("UInt16.>") func gt() { gtTest(UInt16.self) }
        @Test("UInt16.<=") func lte() { lteTest(UInt16.self) }
        @Test("UInt16.>=") func gte() { gteTest(UInt16.self) }
        @Test("UInt16.min") func min() { minTest(UInt16.self) }
        @Test("UInt16.max") func max() { maxTest(UInt16.self) }

        // Numeric
        @Test("UInt16.signum") func signum() { signumTest(UInt16.self) }
        @Test("UInt16.+") func plus() { plusTest(UInt16.self) }
        // @Test("UInt16.-", .bug(id: "86b4gq1tv")) func minus() { minusTest(UInt16.self) }
        @Test("UInt16.avoiding_underflow.-") func minusAvoidingUnderflow() { minusAvoidingUnderflowTest(UInt16.self) }
        @Test("UInt16.*") func mul() { mulTest(UInt16.self) }
        @Test("UInt16./") func quot() { quotTest(UInt16.self) }
        @Test("UInt16.%") func rem() { remTest(UInt16.self) }
        @Test("UInt16.&+") func uncheckedPlus() { uncheckedPlusTest(UInt16.self) }
        @Test("UInt16.&-") func uncheckedMinus() { uncheckedMinusTest(UInt16.self) }
        @Test("UInt16.&*") func uncheckedMul() { uncheckedMulTest(UInt16.self) }
        @Test("UInt16.quotientAndRemainder") func quotientAndRemainder() { quotientAndRemainderTest(UInt16.self) }
        @Test("UInt16.isMultiple") func isMultiple() { isMultipleTest(UInt16.self) }
        @Test("UInt16.addingReportingOverflow") func addingReportingOverflow() { addingReportingOverflowTest(UInt16.self) }
        @Test("UInt16.subtractingReportingOverflow") func subtractingReportingOverflow() { subtractingReportingOverflowTest(UInt16.self) }
        @Test("UInt16.multipliedReportingOverflow") func multipliedReportingOverflow() { multipliedReportingOverflowTest(UInt16.self) }
        @Test("UInt16.dividedReportingOverflow") func dividedReportingOverflow() { dividedReportingOverflowTest(UInt16.self) }
        @Test("UInt16.remainderReportingOverflow") func remainderReportingOverflow() { remainderReportingOverflowTest(UInt16.self) }
        @Test("UInt16.multipliedFullWidth") func multipliedFullWidth() { multipliedFullWidthTest(UInt16.self) }
        // @Test("UInt16.dividingFullWidth", .bug(id: "86b4gq1tv")) func dividingFullWidth() { dividingFullWidthTest(UInt16.self) }

        // Bitwise
        @Test("UInt16.complement") func complement() { complementTest(UInt16.self) }
        @Test("UInt16.zeroBitCount") func nonzeroBitCount() { nonzeroBitCountTest(UInt16.self) }
        @Test("UInt16.leadingZeroBitCount") func leadingZeroBitCount() { leadingZeroBitCountTest(UInt16.self) }
        @Test("UInt16.trailingZeroBitCount") func trailingZeroBitCount() { trailingZeroBitCountTest(UInt16.self) }
        @Test("UInt16.byteSwapped") func byteSwapped() { byteSwappedTest(UInt16.self) }
        @Test("UInt16.littleEndian") func littleEndian() { littleEndianTest(UInt16.self) }
        @Test("UInt16.bigEndian") func bigEndian() { bigEndianTest(UInt16.self) }
        @Test("UInt16.&") func and() { andTest(UInt16.self) }
        @Test("UInt16.|") func or() { orTest(UInt16.self) }
        @Test("UInt16.^") func xor() { xorTest(UInt16.self) }
        @Test("UInt16.<<") func shiftL() { shiftLTest(UInt16.self) }
        @Test("UInt16.>>") func shiftR() { shiftRTest(UInt16.self) }
        @Test("UInt16.&<<") func uncheckedShiftL() { uncheckedShiftLTest(UInt16.self) }
        @Test("UInt16.&>>") func uncheckedShiftR() { uncheckedShiftRTest(UInt16.self) }
    }

    @Suite("UInt32") struct UInt32Tests {
        // Ordering
        @Test("UInt32.==") func eq() { eqTest(UInt32.self) }
        @Test("UInt32.!=") func neq() { neqTest(UInt32.self) }
        @Test("UInt32.<") func lt() { ltTest(UInt32.self) }
        @Test("UInt32.>") func gt() { gtTest(UInt32.self) }
        @Test("UInt32.<=") func lte() { lteTest(UInt32.self) }
        @Test("UInt32.>=") func gte() { gteTest(UInt32.self) }
        @Test("UInt32.min") func min() { minTest(UInt32.self) }
        @Test("UInt32.max") func max() { maxTest(UInt32.self) }

        // Numeric
        @Test("UInt32.signum") func signum() { signumTest(UInt32.self) }
        @Test("UInt32.+") func plus() { plusTest(UInt32.self) }
        // @Test("UInt32.-", .bug(id: "86b4gq1tv")) func minus() { minusTest(UInt32.self) }
        @Test("UInt32.avoiding_underflow.-") func minusAvoidingUnderflow() { minusAvoidingUnderflowTest(UInt32.self) }
        @Test("UInt32.*") func mul() { mulTest(UInt32.self) }
        @Test("UInt32./") func quot() { quotTest(UInt32.self) }
        @Test("UInt32.%") func rem() { remTest(UInt32.self) }
        @Test("UInt32.&+") func uncheckedPlus() { uncheckedPlusTest(UInt32.self) }
        @Test("UInt32.&-") func uncheckedMinus() { uncheckedMinusTest(UInt32.self) }
        @Test("UInt32.&*") func uncheckedMul() { uncheckedMulTest(UInt32.self) }
        @Test("UInt32.quotientAndRemainder") func quotientAndRemainder() { quotientAndRemainderTest(UInt32.self) }
        @Test("UInt32.isMultiple") func isMultiple() { isMultipleTest(UInt32.self) }
        @Test("UInt32.addingReportingOverflow") func addingReportingOverflow() { addingReportingOverflowTest(UInt32.self) }
        @Test("UInt32.subtractingReportingOverflow") func subtractingReportingOverflow() { subtractingReportingOverflowTest(UInt32.self) }
        @Test("UInt32.multipliedReportingOverflow") func multipliedReportingOverflow() { multipliedReportingOverflowTest(UInt32.self) }
        @Test("UInt32.dividedReportingOverflow") func dividedReportingOverflow() { dividedReportingOverflowTest(UInt32.self) }
        @Test("UInt32.remainderReportingOverflow") func remainderReportingOverflow() { remainderReportingOverflowTest(UInt32.self) }
        @Test("UInt32.multipliedFullWidth") func multipliedFullWidth() { multipliedFullWidthTest(UInt32.self) }
        // @Test("UInt32.dividingFullWidth", .bug(id: "86b4gq1tv")) func dividingFullWidth() { dividingFullWidthTest(UInt32.self) }

        // Bitwise
        @Test("UInt32.complement") func complement() { complementTest(UInt32.self) }
        @Test("UInt32.zeroBitCount") func nonzeroBitCount() { nonzeroBitCountTest(UInt32.self) }
        @Test("UInt32.leadingZeroBitCount") func leadingZeroBitCount() { leadingZeroBitCountTest(UInt32.self) }
        @Test("UInt32.trailingZeroBitCount") func trailingZeroBitCount() { trailingZeroBitCountTest(UInt32.self) }
        @Test("UInt32.byteSwapped") func byteSwapped() { byteSwappedTest(UInt32.self) }
        @Test("UInt32.littleEndian") func littleEndian() { littleEndianTest(UInt32.self) }
        @Test("UInt32.bigEndian") func bigEndian() { bigEndianTest(UInt32.self) }
        @Test("UInt32.&") func and() { andTest(UInt32.self) }
        @Test("UInt32.|") func or() { orTest(UInt32.self) }
        @Test("UInt32.^") func xor() { xorTest(UInt32.self) }
        @Test("UInt32.<<") func shiftL() { shiftLTest(UInt32.self) }
        @Test("UInt32.>>") func shiftR() { shiftRTest(UInt32.self) }
        @Test("UInt32.&<<") func uncheckedShiftL() { uncheckedShiftLTest(UInt32.self) }
        @Test("UInt32.&>>") func uncheckedShiftR() { uncheckedShiftRTest(UInt32.self) }
    }

    @Suite("UInt64") struct UInt64Tests {
        // Ordering
        @Test("UInt64.==") func eq() { eqTest(UInt64.self) }
        @Test("UInt64.!=") func neq() { neqTest(UInt64.self) }
        @Test("UInt64.<") func lt() { ltTest(UInt64.self) }
        @Test("UInt64.>") func gt() { gtTest(UInt64.self) }
        @Test("UInt64.<=") func lte() { lteTest(UInt64.self) }
        @Test("UInt64.>=") func gte() { gteTest(UInt64.self) }
        @Test("UInt64.min") func min() { minTest(UInt64.self) }
        @Test("UInt64.max") func max() { maxTest(UInt64.self) }

        // Numeric
        @Test("UInt64.signum") func signum() { signumTest(UInt64.self) }
        @Test("UInt64.+") func plus() { plusTest(UInt64.self) }
        // @Test("UInt64.-", .bug(id: "86b4gq1tv")) func minus() { minusTest(UInt64.self) }
        @Test("UInt64.avoiding_underflow.-") func minusAvoidingUnderflow() { minusAvoidingUnderflowTest(UInt64.self) }
        @Test("UInt64.*") func mul() { mulTest(UInt64.self) }
        @Test("UInt64./") func quot() { quotTest(UInt64.self) }
        @Test("UInt64.%") func rem() { remTest(UInt64.self) }
        @Test("UInt64.&+") func uncheckedPlus() { uncheckedPlusTest(UInt64.self) }
        @Test("UInt64.&-") func uncheckedMinus() { uncheckedMinusTest(UInt64.self) }
        @Test("UInt64.&*") func uncheckedMul() { uncheckedMulTest(UInt64.self) }
        @Test("UInt64.quotientAndRemainder") func quotientAndRemainder() { quotientAndRemainderTest(UInt64.self) }
        @Test("UInt64.isMultiple") func isMultiple() { isMultipleTest(UInt64.self) }
        @Test("UInt64.addingReportingOverflow") func addingReportingOverflow() { addingReportingOverflowTest(UInt64.self) }
        @Test("UInt64.subtractingReportingOverflow") func subtractingReportingOverflow() { subtractingReportingOverflowTest(UInt64.self) }
        @Test("UInt64.multipliedReportingOverflow") func multipliedReportingOverflow() { multipliedReportingOverflowTest(UInt64.self) }
        @Test("UInt64.dividedReportingOverflow") func dividedReportingOverflow() { dividedReportingOverflowTest(UInt64.self) }
        @Test("UInt64.remainderReportingOverflow") func remainderReportingOverflow() { remainderReportingOverflowTest(UInt64.self) }
        @Test("UInt64.multipliedFullWidth") func multipliedFullWidth() { multipliedFullWidthTest(UInt64.self) }
        // @Test("UInt64.dividingFullWidth", .bug(id: "86b4gq3w3")) func dividingFullWidth() { dividingFullWidthTest(UInt64.self) }

        // Bitwise
        @Test("UInt64.complement") func complement() { complementTest(UInt64.self) }
        @Test("UInt64.zeroBitCount") func nonzeroBitCount() { nonzeroBitCountTest(UInt64.self) }
        @Test("UInt64.leadingZeroBitCount") func leadingZeroBitCount() { leadingZeroBitCountTest(UInt64.self) }
        @Test("UInt64.trailingZeroBitCount") func trailingZeroBitCount() { trailingZeroBitCountTest(UInt64.self) }
        @Test("UInt64.byteSwapped") func byteSwapped() { byteSwappedTest(UInt64.self) }
        @Test("UInt64.littleEndian") func littleEndian() { littleEndianTest(UInt64.self) }
        @Test("UInt64.bigEndian") func bigEndian() { bigEndianTest(UInt64.self) }
        @Test("UInt64.&") func and() { andTest(UInt64.self) }
        @Test("UInt64.|") func or() { orTest(UInt64.self) }
        @Test("UInt64.^") func xor() { xorTest(UInt64.self) }
        @Test("UInt64.<<") func shiftL() { shiftLTest(UInt64.self) }
        @Test("UInt64.>>") func shiftR() { shiftRTest(UInt64.self) }
        @Test("UInt64.&<<") func uncheckedShiftL() { uncheckedShiftLTest(UInt64.self) }
        @Test("UInt64.&>>") func uncheckedShiftR() { uncheckedShiftRTest(UInt64.self) }
    }

    @Suite("UInt") struct UIntTests {
        // Ordering
        @Test("UInt.==") func eq() { eqTest(UInt.self) }
        @Test("UInt.!=") func neq() { neqTest(UInt.self) }
        @Test("UInt.<") func lt() { ltTest(UInt.self) }
        @Test("UInt.>") func gt() { gtTest(UInt.self) }
        @Test("UInt.<=") func lte() { lteTest(UInt.self) }
        @Test("UInt.>=") func gte() { gteTest(UInt.self) }
        @Test("UInt.min") func min() { minTest(UInt.self) }
        @Test("UInt.max") func max() { maxTest(UInt.self) }

        // Numeric
        @Test("UInt.signum") func signum() { signumTest(UInt.self) }
        @Test("UInt.+") func plus() { plusTest(UInt.self) }
        // @Test("UInt.-", .bug(id: "86b4gq1tv")) func minus() { minusTest(UInt.self) }
        @Test("UInt.avoiding_underflow.-") func minusAvoidingUnderflow() { minusAvoidingUnderflowTest(UInt.self) }
        @Test("UInt.*") func mul() { mulTest(UInt.self) }
        @Test("UInt./") func quot() { quotTest(UInt.self) }
        @Test("UInt.%") func rem() { remTest(UInt.self) }
        @Test("UInt.&+") func uncheckedPlus() { uncheckedPlusTest(UInt.self) }
        @Test("UInt.&-") func uncheckedMinus() { uncheckedMinusTest(UInt.self) }
        @Test("UInt.&*") func uncheckedMul() { uncheckedMulTest(UInt.self) }
        @Test("UInt.quotientAndRemainder") func quotientAndRemainder() { quotientAndRemainderTest(UInt.self) }
        @Test("UInt.isMultiple") func isMultiple() { isMultipleTest(UInt.self) }
        @Test("UInt.addingReportingOverflow") func addingReportingOverflow() { addingReportingOverflowTest(UInt.self) }
        @Test("UInt.subtractingReportingOverflow") func subtractingReportingOverflow() { subtractingReportingOverflowTest(UInt.self) }
        @Test("UInt.multipliedReportingOverflow") func multipliedReportingOverflow() { multipliedReportingOverflowTest(UInt.self) }
        @Test("UInt.dividedReportingOverflow") func dividedReportingOverflow() { dividedReportingOverflowTest(UInt.self) }
        @Test("UInt.remainderReportingOverflow") func remainderReportingOverflow() { remainderReportingOverflowTest(UInt.self) }
        @Test("UInt.multipliedFullWidth") func multipliedFullWidth() { multipliedFullWidthTest(UInt.self) }
        // @Test("UInt.dividingFullWidth", .bug(id: "86b4gq3w3")) func dividingFullWidth() { dividingFullWidthTest(UInt.self) }

        // Bitwise
        @Test("UInt.complement") func complement() { complementTest(UInt.self) }
        @Test("UInt.zeroBitCount") func nonzeroBitCount() { nonzeroBitCountTest(UInt.self) }
        @Test("UInt.leadingZeroBitCount") func leadingZeroBitCount() { leadingZeroBitCountTest(UInt.self) }
        @Test("UInt.trailingZeroBitCount") func trailingZeroBitCount() { trailingZeroBitCountTest(UInt.self) }
        @Test("UInt.byteSwapped") func byteSwapped() { byteSwappedTest(UInt.self) }
        @Test("UInt.littleEndian") func littleEndian() { littleEndianTest(UInt.self) }
        @Test("UInt.bigEndian") func bigEndian() { bigEndianTest(UInt.self) }
        @Test("UInt.&") func and() { andTest(UInt.self) }
        @Test("UInt.|") func or() { orTest(UInt.self) }
        @Test("UInt.^") func xor() { xorTest(UInt.self) }
        @Test("UInt.<<") func shiftL() { shiftLTest(UInt.self) }
        @Test("UInt.>>") func shiftR() { shiftRTest(UInt.self) }
        @Test("UInt.&<<") func uncheckedShiftL() { uncheckedShiftLTest(UInt.self) }
        @Test("UInt.&>>") func uncheckedShiftR() { uncheckedShiftRTest(UInt.self) }
    }

#if arch(arm64)
    @Suite("Float16") struct Float16Tests {
        // Ordering
        @Test("Float16.==") func eq() { eqTest(Float16.self) }
        @Test("Float16.!=") func neq() { neqTest(Float16.self) }
        @Test("Float16.<") func lt() { ltTest(Float16.self) }
        @Test("Float16.>") func gt() { gtTest(Float16.self) }
        @Test("Float16.<=") func lte() { lteTest(Float16.self) }
        @Test("Float16.>=") func gte() { gteTest(Float16.self) }
        @Test("Float16.min") func min() { minTest(Float16.self) }
        @Test("Float16.max") func max() { maxTest(Float16.self) }

        // Numeric
        @Test("Float16.negate") func negate() { negateTest(Float16.self) }
        @Test("Float16.abs") func abs() { absTest(Float16.self) }
        @Test("Float16.+") func plus() { plusTest(Float16.self) }
        @Test("Float16.-") func minus() { minusTest(Float16.self) }
        @Test("Float16.*") func mul() { mulTest(Float16.self) }
        @Test("Float16./") func quot() { quotTest(Float16.self) }
        @Test("Float16.pow") func pow() { powTest(Float16.self) }
        @Test("Float16.powi") func powi() { powiTest(Float16.self) }
        // @Test("Float16.exponent", .bug(id: "86b78aaem")) func exponent() { exponentTest(Float16.self) }
        @Test("Float16.floatingPointClass") func floatingPointClass() { floatingPointClassTest(Float16.self) }
        @Test("Float16.isCanonical") func isCanonical() { isCanonicalTest(Float16.self) }
        @Test("Float16.isFinite") func isFinite() { isFiniteTest(Float16.self) }
        @Test("Float16.isInfinite") func isInfinite() { isInfiniteTest(Float16.self) }
        @Test("Float16.isNaN") func isNaN() { isNaNTest(Float16.self) }
        @Test("Float16.isSignalingNaN") func isSignalingNaN() { isSignalingNaNTest(Float16.self) }
        @Test("Float16.isNormal") func isNormal() { isNormalTest(Float16.self) }
        @Test("Float16.isSubnormal") func isSubnormal() { isSubnormalTest(Float16.self) }
        @Test("Float16.isZero") func isZero() { isZeroTest(Float16.self) }
        @Test("Float16.nextDown") func nextDown() { nextDownTest(Float16.self) }
        @Test("Float16.nextUp") func nextUp() { nextUpTest(Float16.self) }
        @Test("Float16.sign") func sign() { signTest(Float16.self) }
        // @Test("Float16.significand", .bug(id: "86b4gq63t")) func significand() { significandTest(Float16.self) }
        @Test("Float16.ulp") func ulp() { ulpTest(Float16.self) }
        @Test("Float16.rounded") func rounded() { roundedTest(Float16.self) }
        // @Test("Float16.roundedRule", .bug(id: "86b4gqdud")) func roundedRWithRoundingRule() { roundedWithRoundingRuleTest(Float16.self) }
        @Test("Float16.floor") func floor() { floorTest(Float16.self) }
        @Test("Float16.ceiling") func ceiling() { ceilingTest(Float16.self) }
        @Test("Float16.truncate") func truncate() { truncateTest(Float16.self) }
        @Test("Float16.sqrt") func sqrt() { sqrtTest(Float16.self) }
        @Test("Float16.reciprocal") func reciprocal() { reciprocalTest(Float16.self) }
        @Test("Float16.exp") func exp() { expTest(Float16.self) }
        @Test("Float16.exp2") func exp2() { exp2Test(Float16.self) }
        @Test("Float16.exp10") func exp10() { exp10Test(Float16.self) }
        @Test("Float16.expMinusOne") func expMinusOne() { expMinusOneTest(Float16.self) }
        @Test("Float16.log") func log() { logTest(Float16.self) }
        @Test("Float16.log2") func log2() { log2Test(Float16.self) }
        @Test("Float16.log10") func log10() { log10Test(Float16.self) }
        @Test("Float16.logOnePlus") func logOnePlus() { logOnePlusTest(Float16.self) }
        @Test("Float16.sin") func sin() { sinTest(Float16.self) }
        @Test("Float16.cos") func cos() { cosTest(Float16.self) }
        @Test("Float16.tan") func tan() { tanTest(Float16.self) }
        @Test("Float16.asin") func asin() { asinTest(Float16.self) }
        @Test("Float16.acos") func acos() { acosTest(Float16.self) }
        @Test("Float16.atan") func atan() { atanTest(Float16.self) }
        @Test("Float16.atan2") func atan2() { atan2Test(Float16.self) }
        @Test("Float16.sinh") func sinh() { sinhTest(Float16.self) }
        @Test("Float16.cosh") func cosh() { coshTest(Float16.self) }
        @Test("Float16.tanh") func tanh() { tanhTest(Float16.self) }
        @Test("Float16.asinh") func asinh() { asinhTest(Float16.self) }
        @Test("Float16.acosh") func acosh() { acoshTest(Float16.self) }
        @Test("Float16.atanh") func atanh() { atanhTest(Float16.self) }
        @Test("Float16.hypot") func hypot() { hypotTest(Float16.self) }
        @Test("Float16.erf") func erf() { erfTest(Float16.self) }
        @Test("Float16.erfc") func erfc() { erfcTest(Float16.self) }
        @Test("Float16.gamma") func gamma() { gammaTest(Float16.self) }
        @Test("Float16.logGamma") func logGamma() { logGammaTest(Float16.self) }
    }
#endif

    @Suite("Float32") struct Float32Tests {
        // Ordering
        @Test("Float32.==") func eq() { eqTest(Float32.self) }
        @Test("Float32.!=") func neq() { neqTest(Float32.self) }
        @Test("Float32.<") func lt() { ltTest(Float32.self) }
        @Test("Float32.>") func gt() { gtTest(Float32.self) }
        @Test("Float32.<=") func lte() { lteTest(Float32.self) }
        @Test("Float32.>=") func gte() { gteTest(Float32.self) }
        @Test("Float32.min") func min() { minTest(Float32.self) }
        @Test("Float32.max") func max() { maxTest(Float32.self) }

        // Numeric
        @Test("Float32.negate") func negate() { negateTest(Float32.self) }
        @Test("Float32.abs") func abs() { absTest(Float32.self) }
        @Test("Float32.+") func plus() { plusTest(Float32.self) }
        @Test("Float32.-") func minus() { minusTest(Float32.self) }
        @Test("Float32.*") func mul() { mulTest(Float32.self) }
        @Test("Float32./") func quot() { quotTest(Float32.self) }
        @Test("Float32.pow") func pow() { powTest(Float32.self) }
        @Test("Float32.powi") func powi() { powiTest(Float32.self) }
        // @Test("Float32.exponent", .bug(id: "86b78aaem")) func exponent() { exponentTest(Float32.self) }
        @Test("Float32.floatingPointClass") func floatingPointClass() { floatingPointClassTest(Float32.self) }
        @Test("Float32.isCanonical") func isCanonical() { isCanonicalTest(Float32.self) }
        @Test("Float32.isFinite") func isFinite() { isFiniteTest(Float32.self) }
        @Test("Float32.isInfinite") func isInfinite() { isInfiniteTest(Float32.self) }
        @Test("Float32.isNaN") func isNaN() { isNaNTest(Float32.self) }
        @Test("Float32.isSignalingNaN") func isSignalingNaN() { isSignalingNaNTest(Float32.self) }
        @Test("Float32.isNormal") func isNormal() { isNormalTest(Float32.self) }
        @Test("Float32.isSubnormal") func isSubnormal() { isSubnormalTest(Float32.self) }
        @Test("Float32.isZero") func isZero() { isZeroTest(Float32.self) }
        @Test("Float32.nextDown") func nextDown() { nextDownTest(Float32.self) }
        @Test("Float32.nextUp") func nextUp() { nextUpTest(Float32.self) }
        @Test("Float32.sign") func sign() { signTest(Float32.self) }
        // @Test("Float32.significand", .bug(id: "86b4gq63t")) func significand() { significandTest(Float32.self) }
        @Test("Float32.ulp") func ulp() { ulpTest(Float32.self) }
        @Test("Float32.rounded") func rounded() { roundedTest(Float32.self) }
        // @Test("Float32.roundedRule", .bug(id: "86b4gqdud")) func roundedRWithRoundingRule() { roundedWithRoundingRuleTest(Float32.self) }
        @Test("Float32.floor") func floor() { floorTest(Float32.self) }
        @Test("Float32.ceiling") func ceiling() { ceilingTest(Float32.self) }
        @Test("Float32.truncate") func truncate() { truncateTest(Float32.self) }
        @Test("Float32.sqrt") func sqrt() { sqrtTest(Float32.self) }
        @Test("Float32.reciprocal") func reciprocal() { reciprocalTest(Float32.self) }
        @Test("Float32.exp") func exp() { expTest(Float32.self) }
        @Test("Float32.exp2") func exp2() { exp2Test(Float32.self) }
        @Test("Float32.exp10") func exp10() { exp10Test(Float32.self) }
        @Test("Float32.expMinusOne") func expMinusOne() { expMinusOneTest(Float32.self) }
        @Test("Float32.log") func log() { logTest(Float32.self) }
        @Test("Float32.log2") func log2() { log2Test(Float32.self) }
        @Test("Float32.log10") func log10() { log10Test(Float32.self) }
        @Test("Float32.logOnePlus") func logOnePlus() { logOnePlusTest(Float32.self) }
        @Test("Float32.sin") func sin() { sinTest(Float32.self) }
        @Test("Float32.cos") func cos() { cosTest(Float32.self) }
        @Test("Float32.tan") func tan() { tanTest(Float32.self) }
        @Test("Float32.asin") func asin() { asinTest(Float32.self) }
        @Test("Float32.acos") func acos() { acosTest(Float32.self) }
        @Test("Float32.atan") func atan() { atanTest(Float32.self) }
        @Test("Float32.atan2") func atan2() { atan2Test(Float32.self) }
        @Test("Float32.sinh") func sinh() { sinhTest(Float32.self) }
        @Test("Float32.cosh") func cosh() { coshTest(Float32.self) }
        @Test("Float32.tanh") func tanh() { tanhTest(Float32.self) }
        @Test("Float32.asinh") func asinh() { asinhTest(Float32.self) }
        @Test("Float32.acosh") func acosh() { acoshTest(Float32.self) }
        @Test("Float32.atanh") func atanh() { atanhTest(Float32.self) }
        @Test("Float32.hypot") func hypot() { hypotTest(Float32.self) }
        @Test("Float32.erf") func erf() { erfTest(Float32.self) }
        @Test("Float32.erfc") func erfc() { erfcTest(Float32.self) }
        @Test("Float32.gamma") func gamma() { gammaTest(Float32.self) }
        @Test("Float32.logGamma") func logGamma() { logGammaTest(Float32.self) }
    }

    @Suite("Float64") struct Float64Tests {
        // Ordering
        @Test("Float64.==") func eq() { eqTest(Float64.self) }
        @Test("Float64.!=") func neq() { neqTest(Float64.self) }
        @Test("Float64.<") func lt() { ltTest(Float64.self) }
        @Test("Float64.>") func gt() { gtTest(Float64.self) }
        @Test("Float64.<=") func lte() { lteTest(Float64.self) }
        @Test("Float64.>=") func gte() { gteTest(Float64.self) }
        @Test("Float64.min") func min() { minTest(Float64.self) }
        @Test("Float64.max") func max() { maxTest(Float64.self) }

        // Numeric
        @Test("Float64.negate") func negate() { negateTest(Float64.self) }
        @Test("Float64.abs") func abs() { absTest(Float64.self) }
        @Test("Float64.+") func plus() { plusTest(Float64.self) }
        @Test("Float64.-") func minus() { minusTest(Float64.self) }
        @Test("Float64.*") func mul() { mulTest(Float64.self) }
        @Test("Float64./") func quot() { quotTest(Float64.self) }
        @Test("Float64.pow") func pow() { powTest(Float64.self) }
        @Test("Float64.powi") func powi() { powiTest(Float64.self) }
        @Test("Float64.exponent") func exponent() { exponentTest(Float64.self) }
        @Test("Float64.floatingPointClass") func floatingPointClass() { floatingPointClassTest(Float64.self) }
        @Test("Float64.isCanonical") func isCanonical() { isCanonicalTest(Float64.self) }
        @Test("Float64.isFinite") func isFinite() { isFiniteTest(Float64.self) }
        @Test("Float64.isInfinite") func isInfinite() { isInfiniteTest(Float64.self) }
        @Test("Float64.isNaN") func isNaN() { isNaNTest(Float64.self) }
        @Test("Float64.isSignalingNaN") func isSignalingNaN() { isSignalingNaNTest(Float64.self) }
        @Test("Float64.isNormal") func isNormal() { isNormalTest(Float64.self) }
        @Test("Float64.isSubnormal") func isSubnormal() { isSubnormalTest(Float64.self) }
        @Test("Float64.isZero") func isZero() { isZeroTest(Float64.self) }
        @Test("Float64.nextDown") func nextDown() { nextDownTest(Float64.self) }
        @Test("Float64.nextUp") func nextUp() { nextUpTest(Float64.self) }
        @Test("Float64.sign") func sign() { signTest(Float64.self) }
        @Test("Float64.significand") func significand() { significandTest(Float64.self) }
        @Test("Float64.ulp") func ulp() { ulpTest(Float64.self) }
        @Test("Float64.rounded") func rounded() { roundedTest(Float64.self) }
        // @Test("Float64.roundedRule", .bug(id: "86b4gqdud")) func roundedRWithRoundingRule() { roundedWithRoundingRuleTest(Float64.self) }
        @Test("Float64.floor") func floor() { floorTest(Float64.self) }
        @Test("Float64.ceiling") func ceiling() { ceilingTest(Float64.self) }
        @Test("Float64.truncate") func truncate() { truncateTest(Float64.self) }
        @Test("Float64.sqrt") func sqrt() { sqrtTest(Float64.self) }
        @Test("Float64.reciprocal") func reciprocal() { reciprocalTest(Float64.self) }
        @Test("Float64.exp") func exp() { expTest(Float64.self) }
        @Test("Float64.exp2") func exp2() { exp2Test(Float64.self) }
        @Test("Float64.exp10") func exp10() { exp10Test(Float64.self) }
        @Test("Float64.expMinusOne") func expMinusOne() { expMinusOneTest(Float64.self) }
        @Test("Float64.log") func log() { logTest(Float64.self) }
        @Test("Float64.log2") func log2() { log2Test(Float64.self) }
        @Test("Float64.log10") func log10() { log10Test(Float64.self) }
        @Test("Float64.logOnePlus") func logOnePlus() { logOnePlusTest(Float64.self) }
        @Test("Float64.sin") func sin() { sinTest(Float64.self) }
        @Test("Float64.cos") func cos() { cosTest(Float64.self) }
        @Test("Float64.tan") func tan() { tanTest(Float64.self) }
        @Test("Float64.asin") func asin() { asinTest(Float64.self) }
        @Test("Float64.acos") func acos() { acosTest(Float64.self) }
        @Test("Float64.atan") func atan() { atanTest(Float64.self) }
        @Test("Float64.atan2") func atan2() { atan2Test(Float64.self) }
        @Test("Float64.sinh") func sinh() { sinhTest(Float64.self) }
        @Test("Float64.cosh") func cosh() { coshTest(Float64.self) }
        @Test("Float64.tanh") func tanh() { tanhTest(Float64.self) }
        @Test("Float64.asinh") func asinh() { asinhTest(Float64.self) }
        @Test("Float64.acosh") func acosh() { acoshTest(Float64.self) }
        @Test("Float64.atanh") func atanh() { atanhTest(Float64.self) }
        @Test("Float64.hypot") func hypot() { hypotTest(Float64.self) }
        @Test("Float64.erf") func erf() { erfTest(Float64.self) }
        @Test("Float64.erfc") func erfc() { erfcTest(Float64.self) }
        @Test("Float64.gamma") func gamma() { gammaTest(Float64.self) }
        @Test("Float64.logGamma") func logGamma() { logGammaTest(Float64.self) }
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
// Unfortunately, right now we have multiple calls to the `mapTest` function
// with a different closure `f` passed in its captured environment, and only a
// single call to `parallel_for` within the (single) implementation of
// `mapTest` within the module.
//
// @inline(__always)
// func mapTest<A: Arbitrary, B: Similar>(_ proxy: A.Type, _ f: @escaping (A) -> B) {
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
private func eqTest<T: Arbitrary & Equatable>(_: T.Type) {
    property(#function) <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink([T].arbitrary) { (ys: [T]) in
        let expected = zip(xs, ys).map { x, y in x == y }
        let actual   = zipWith(xs, ys, ==)
        return try? #require(actual == expected)
      }}
}

// @inline(never)
private func neqTest<T: Arbitrary & Equatable>(_: T.Type) {
    property(String(describing: T.self) + ".!=") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink([T].arbitrary) { (ys: [T]) in
        let expected = zip(xs, ys).map { x, y in x != y }
        let actual   = zipWith(xs, ys, !=)
        return try? #require(actual == expected)
      }}
}

// MARK: Comparable

// @inline(never)
private func lnotTest() {
    property("Bool.lnot") <-
      forAllNoShrink([Bool].arbitrary) { (xs: [Bool]) in
        let expected = xs.map(!)
        let actual   = map(xs, !)
        return try? #require(actual == expected)
      }
}

// @inline(never)
private func lorTest() {
    property("Bool.||") <-
      forAllNoShrink([Bool].arbitrary) { (xs: [Bool]) in
      forAllNoShrink([Bool].arbitrary) { (ys: [Bool]) in
        let expected = zip(xs, ys).map { x, y in x || y }
        let actual   = zipWith(xs, ys) { x, y in x || y }
        return try? #require(actual == expected)
      }}
}

// @inline(never)
private func landTest() {
    property("Bool.&&") <-
      forAllNoShrink([Bool].arbitrary) { (xs: [Bool]) in
      forAllNoShrink([Bool].arbitrary) { (ys: [Bool]) in
        let expected = zip(xs, ys).map { x, y in x && y }
        let actual   = zipWith(xs, ys) { x, y in x && y }
        return try? #require(actual == expected)
      }}
}

// @inline(never)
private func ltTest<T: Arbitrary & Comparable>(_: T.Type) {
    property(String(describing: T.self) + ".<") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink([T].arbitrary) { (ys: [T]) in
        let expected = zip(xs, ys).map { x, y in x < y }
        let actual   = zipWith(xs, ys, <)
        return try? #require(actual == expected)
      }}
}

// @inline(never)
private func gtTest<T: Arbitrary & Comparable>(_: T.Type) {
    property(String(describing: T.self) + ".>") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink([T].arbitrary) { (ys: [T]) in
        let expected = zip(xs, ys).map { x, y in x > y }
        let actual   = zipWith(xs, ys, >)
        return try? #require(actual == expected)
      }}
}

// @inline(never)
private func lteTest<T: Arbitrary & Comparable>(_: T.Type) {
    property(String(describing: T.self) + ".<=") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink([T].arbitrary) { (ys: [T]) in
        let expected = zip(xs, ys).map { x, y in x <= y }
        let actual   = zipWith(xs, ys, <=)
        return try? #require(actual == expected)
      }}
}

// @inline(never)
private func gteTest<T: Arbitrary & Comparable>(_: T.Type) {
    property(String(describing: T.self) + ".>=") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink([T].arbitrary) { (ys: [T]) in
        let expected = zip(xs, ys).map { x, y in x >= y }
        let actual   = zipWith(xs, ys, >=)
        return try? #require(actual == expected)
      }}
}

// @inline(never)
private func minTest<T: Arbitrary & Comparable>(_: T.Type) {
    property(String(describing: T.self) + ".>=") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink([T].arbitrary) { (ys: [T]) in
        let expected = zip(xs, ys).map { x, y in min(x, y) }
        let actual   = zipWith(xs, ys) { x, y in min(x, y) }
        return try? #require(actual == expected)
      }}
}

// @inline(never)
private func maxTest<T: Arbitrary & Comparable>(_: T.Type) {
    property(String(describing: T.self) + ".>=") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink([T].arbitrary) { (ys: [T]) in
        let expected = zip(xs, ys).map { x, y in max(x, y) }
        let actual   = zipWith(xs, ys) { x, y in max(x, y) }
        return try? #require(actual == expected)
      }}
}

// MARK: SignedNumeric

// @inline(never)
private func negateTest<T: Arbitrary & SignedNumeric>(_: T.Type) {
    property(String(describing: T.self) + ".negate") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { x in -x }
        let actual   = map(xs) { x in -x }
        return try? #require(actual == expected)
    }
}

// @inline(never)
private func absTest<T: Arbitrary & Comparable & SignedNumeric>(_: T.Type) {
    property(String(describing: T.self) + ".abs") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { abs($0) }
        let actual   = map(xs) { abs($0) }
        return try? #require(actual == expected)
    }
}

// MARK: BinaryInteger

// @inline(never)
private func signumTest<T: Arbitrary & BinaryInteger>(_: T.Type) {
    property(String(describing: T.self) + ".signum") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { $0.signum() }
        let actual   = map(xs) { $0.signum() }
        return try? #require(actual == expected)
    }
}

// MARK: AdditiveArithmetic

// @inline(never)
private func plusTest<T: Arbitrary & AdditiveArithmetic>(_: T.Type) {
    property(String(describing: T.self) + ".+") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink([T].arbitrary) { (ys: [T]) in
        let expected = zip(xs, ys).map { x, y in x + y }
        let actual   = zipWith(xs, ys, +)
        return try? #require(actual == expected)
      }}
}

// @inline(never)
// Workaround for https://app.clickup.com/t/86b4gq1tv
private func plusAvoidingOverflowTest<T: Arbitrary & FixedWidthInteger>(_: T.Type) {
    let gen = T.arbitrary.suchThat { (T.min / 2) <= $0 && $0 <= (T.max / 2) }
    property(String(describing: T.self) + ".avoiding_overflow.+") <-
      forAllNoShrink(gen.proliferate) { (xs: [T]) in
      forAllNoShrink(gen.proliferate) { (ys: [T]) in
        let expected = zip(xs, ys).map { x, y in x + y }
        let actual   = zipWith(xs, ys, +)
        return try? #require(actual == expected)
      }}
}

// @inline(never)
private func minusTest<T: Arbitrary & AdditiveArithmetic>(_: T.Type) {
    property(String(describing: T.self) + ".-") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink([T].arbitrary) { (ys: [T]) in
        let expected = zip(xs, ys).map { x, y in x - y }
        let actual   = zipWith(xs, ys, -)
        return try? #require(actual == expected)
      }}
}

// @inline(never)
// Workaround for https://app.clickup.com/t/86b4gq1tv
private func minusAvoidingUnderflowTest<T: Arbitrary & FixedWidthInteger>(_: T.Type) {
    let gen = T.arbitrary.suchThat { (T.min / 2) <= $0 && $0 <= (T.max / 2) }
    property(String(describing: T.self) + ".avoiding_underflow.-") <-
      forAllNoShrink(gen.proliferate) { (xs: [T]) in
      forAllNoShrink(gen.proliferate) { (ys: [T]) in
        let expected = zip(xs, ys).map { x, y in if x > y { x - y } else { y - x } }
        let actual   = zipWith(xs, ys) { x, y in if x > y { x - y } else { y - x } }
        return try? #require(actual == expected)
      }}
}

// MARK: Numeric

// @inline(never)
private func mulTest<T: Arbitrary & Numeric>(_: T.Type) {
    property(String(describing: T.self) + ".*") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink([T].arbitrary) { (ys: [T]) in
        let expected = zip(xs, ys).map { x, y in x * y }
        let actual   = zipWith(xs, ys, *)
        return try? #require(actual == expected)
      }}
}

// @inline(never)
// Workaround for https://app.clickup.com/t/86b4gq1tv
private func mulAvoidingOverflowTest<T: Arbitrary & FixedWidthInteger>(_: T.Type) {
    let lim = Double(T.max).squareRoot()
    let gen = T.arbitrary.suchThat { abs(Double($0)) <= lim }
    property(String(describing: T.self) + ".avoiding_overflow.*") <-
      forAllNoShrink(gen.proliferate) { (xs: [T]) in
      forAllNoShrink(gen.proliferate) { (ys: [T]) in
        let expected = zip(xs, ys).map { x, y in x * y }
        let actual   = zipWith(xs, ys, *)
        return try? #require(actual == expected)
      }}
}

// MARK: BinaryInteger

// @inline(never)
private func quotTest<T: Arbitrary & BinaryInteger>(_: T.Type) {
    let gen = T.arbitrary.suchThat { !($0 == 0) }
    property(String(describing: T.self) + "./") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink(gen.proliferate) { (ys: [T]) in
        let expected = zip(xs, ys).map { x, y in x / y }
        let actual   = zipWith(xs, ys, /)
        return try? #require(actual == expected)
      }}
}

// @inline(never)
private func remTest<T: Arbitrary & BinaryInteger>(_: T.Type) {
    let gen = T.arbitrary.suchThat { !($0 == 0) }
    property(String(describing: T.self) + "./") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink(gen.proliferate) { (ys: [T]) in
        let expected = zip(xs, ys).map { x, y in x % y }
        let actual   = zipWith(xs, ys, %)
        return try? #require(actual == expected)
      }}
}

// @inline(never)
private func quotientAndRemainderTest<T: Arbitrary & BinaryInteger>(_: T.Type) {
    let gen = T.arbitrary.suchThat { !($0 == 0) }
    property(String(describing: T.self) + "./") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink(gen.proliferate) { (ys: [T]) in
        let expected = zip(xs, ys).map { x, y in x.quotientAndRemainder(dividingBy: y) }
        let actual   = zipWith(xs, ys) { x, y in x.quotientAndRemainder(dividingBy: y) }
        let result1: ()? = try? #require(actual.map { $0.quotient }  == expected.map { $0.quotient })
        let result2: ()? = try? #require(actual.map { $0.remainder } == expected.map { $0.remainder })
        return result1 != nil && result2 != nil
      }}
}

// @inline(never)
private func isMultipleTest<T: Arbitrary & BinaryInteger>(_: T.Type) {
    property(String(describing: T.self) + "./") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink([T].arbitrary) { (ys: [T]) in
        let expected = zip(xs, ys).map { x, y in x.isMultiple(of: y) }
        let actual   = zipWith(xs, ys) { x, y in x.isMultiple(of: y) }
        return try? #require(actual == expected)
      }}
}

// @inline(never)
private func andTest<T: Arbitrary & BinaryInteger>(_: T.Type) {
    property(String(describing: T.self) + ".&") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink([T].arbitrary) { (ys: [T]) in
        let expected = zip(xs, ys).map { x, y in x & y }
        let actual   = zipWith(xs, ys, &)
        return try? #require(actual == expected)
      }}
}

// @inline(never)
private func orTest<T: Arbitrary & BinaryInteger>(_: T.Type) {
    property(String(describing: T.self) + ".&") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink([T].arbitrary) { (ys: [T]) in
        let expected = zip(xs, ys).map { x, y in x | y }
        let actual   = zipWith(xs, ys, |)
        return try? #require(actual == expected)
      }}
}

// @inline(never)
private func xorTest<T: Arbitrary & BinaryInteger>(_: T.Type) {
    property(String(describing: T.self) + ".&") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink([T].arbitrary) { (ys: [T]) in
        let expected = zip(xs, ys).map { x, y in x ^ y }
        let actual   = zipWith(xs, ys, ^)
        return try? #require(actual == expected)
      }}
}

// @inline(never)
private func shiftLTest<T: Arbitrary & BinaryInteger>(_: T.Type) {
    let gen = Gen<Int>.choose((-T.zero.bitWidth, T.zero.bitWidth))
    property(String(describing: T.self) + ".<<") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink(gen.proliferate) { (ys: [Int]) in
        let expected = zip(xs, ys).map { x, y in x << y }
        let actual   = zipWith(xs, ys, <<)
        return try? #require(actual == expected)
      }}
}

// @inline(never)
private func shiftRTest<T: Arbitrary & BinaryInteger>(_: T.Type) {
    let gen = Gen<Int>.choose((-T.zero.bitWidth, T.zero.bitWidth))
    property(String(describing: T.self) + ".>>") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink(gen.proliferate) { (ys: [Int]) in
        let expected = zip(xs, ys).map { x, y in x >> y }
        let actual   = zipWith(xs, ys, >>)
        return try? #require(actual == expected)
      }}
}

// @inline(never)
private func complementTest<T: Arbitrary & BinaryInteger>(_: T.Type) {
    property(String(describing: T.self) + ".complement") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { ~$0 }
        let actual   = map(xs) { ~$0 }
        return try? #require(actual == expected)
    }
}

// @inline(never)
private func trailingZeroBitCountTest<T: Arbitrary & BinaryInteger>(_: T.Type) {
    property(String(describing: T.self) + ".trailingZeroBitCount") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { $0.trailingZeroBitCount }
        let actual   = map(xs) { $0.trailingZeroBitCount }
        return try? #require(actual == expected)
    }
}

// MARK: FixedWidthInteger

// @inline(never)
private func leadingZeroBitCountTest<T: Arbitrary & FixedWidthInteger>(_: T.Type) {
    property(String(describing: T.self) + ".leadingZeroBitCount") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { $0.leadingZeroBitCount }
        let actual   = map(xs) { $0.leadingZeroBitCount }
        return try? #require(actual == expected)
    }
}

// @inline(never)
private func nonzeroBitCountTest<T: Arbitrary & FixedWidthInteger>(_: T.Type) {
    property(String(describing: T.self) + ".nonzeroBitCount") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { $0.nonzeroBitCount }
        let actual   = map(xs) { $0.nonzeroBitCount }
        return try? #require(actual == expected)
    }
}

// @inline(never)
private func byteSwappedTest<T: Arbitrary & FixedWidthInteger>(_: T.Type) {
    property(String(describing: T.self) + ".byteSwapped") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { $0.byteSwapped }
        let actual   = map(xs) { $0.byteSwapped }
        return try? #require(actual == expected)
    }
}

// @inline(never)
private func littleEndianTest<T: Arbitrary & FixedWidthInteger>(_: T.Type) {
    property(String(describing: T.self) + ".littleEndian") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { $0.littleEndian }
        let actual   = map(xs) { $0.littleEndian }
        return try? #require(actual == expected)
    }
}

// @inline(never)
private func bigEndianTest<T: Arbitrary & FixedWidthInteger>(_: T.Type) {
    property(String(describing: T.self) + ".bigEndian") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { $0.bigEndian }
        let actual   = map(xs) { $0.bigEndian }
        return try? #require(actual == expected)
    }
}

// @inline(never)
private func uncheckedPlusTest<T: Arbitrary & FixedWidthInteger>(_: T.Type) {
    property(String(describing: T.self) + ".&*") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink([T].arbitrary) { (ys: [T]) in
        let expected = zip(xs, ys).map { x, y in x &+ y }
        let actual   = zipWith(xs, ys, &+)
        return try? #require(actual == expected)
      }}
}

// @inline(never)
private func uncheckedMinusTest<T: Arbitrary & FixedWidthInteger>(_: T.Type) {
    property(String(describing: T.self) + ".&-") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink([T].arbitrary) { (ys: [T]) in
        let expected = zip(xs, ys).map { x, y in x &+ y }
        let actual   = zipWith(xs, ys, &+)
        return try? #require(actual == expected)
      }}
}

// @inline(never)
private func uncheckedMulTest<T: Arbitrary & FixedWidthInteger>(_: T.Type) {
    property(String(describing: T.self) + ".&*") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink([T].arbitrary) { (ys: [T]) in
        let expected = zip(xs, ys).map { x, y in x &* y }
        let actual   = zipWith(xs, ys, &*)
        return try? #require(actual == expected)
      }}
}

// @inline(never)
private func uncheckedShiftLTest<T: Arbitrary & RandomType & FixedWidthInteger>(_: T.Type) {
    let gen = Gen.choose((0, T(T.zero.bitWidth)))
    property(String(describing: T.self) + ".&<<") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink(gen.proliferate) { (ys: [T]) in
        let expected = zip(xs, ys).map { x, y in x &<< y }
        let actual   = zipWith(xs, ys, &<<)
        return try? #require(actual == expected)
      }}
}

// @inline(never)
private func uncheckedShiftRTest<T: Arbitrary & RandomType & FixedWidthInteger>(_: T.Type) {
    let gen = Gen.choose((0, T(T.zero.bitWidth)))
    property(String(describing: T.self) + ".&>>") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink(gen.proliferate) { (ys: [T]) in
        let expected = zip(xs, ys).map { x, y in x &>> y }
        let actual   = zipWith(xs, ys, &>>)
        return try? #require(actual == expected)
      }}
}

// @inline(never)
private func addingReportingOverflowTest<T: Arbitrary & FixedWidthInteger>(_: T.Type) {
    property(String(describing: T.self) + ".addingReportingOverflow") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink([T].arbitrary) { (ys: [T]) in
        let expected = zip(xs, ys).map { x, y in x.addingReportingOverflow(y) }
        let actual   = zipWith(xs, ys) { x, y in x.addingReportingOverflow(y) }
        let result1: ()? = try? #require(actual.map { $0.partialValue } == expected.map { $0.partialValue })
        let result2: ()? = try? #require(actual.map { $0.overflow } == expected.map { $0.overflow })
        return result1 != nil && result2 != nil
      }}
}

// @inline(never)
private func subtractingReportingOverflowTest<T: Arbitrary & FixedWidthInteger>(_: T.Type) {
    property(String(describing: T.self) + ".subtractingReportingOverflow") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink([T].arbitrary) { (ys: [T]) in
        let expected = zip(xs, ys).map { x, y in x.subtractingReportingOverflow(y) }
        let actual   = zipWith(xs, ys) { x, y in x.subtractingReportingOverflow(y) }
        let result1: ()? = try? #require(actual.map { $0.partialValue } == expected.map { $0.partialValue })
        let result2: ()? = try? #require(actual.map { $0.overflow } == expected.map { $0.overflow })
        return result1 != nil && result2 != nil
      }}
}

// @inline(never)
private func multipliedReportingOverflowTest<T: Arbitrary & FixedWidthInteger>(_: T.Type) {
    property(String(describing: T.self) + ".multipliedReportingOverflow") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink([T].arbitrary) { (ys: [T]) in
        let expected = zip(xs, ys).map { x, y in x.multipliedReportingOverflow(by: y) }
        let actual   = zipWith(xs, ys) { x, y in x.multipliedReportingOverflow(by: y) }
        let result1: ()? = try? #require(actual.map { $0.partialValue } == expected.map { $0.partialValue })
        let result2: ()? = try? #require(actual.map { $0.overflow } == expected.map { $0.overflow })
        return result1 != nil && result2 != nil
      }}
}

// @inline(never)
private func dividedReportingOverflowTest<T: Arbitrary & FixedWidthInteger>(_: T.Type) {
    property(String(describing: T.self) + ".dividedReportingOverflow") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink([T].arbitrary) { (ys: [T]) in
        let expected = zip(xs, ys).map { x, y in x.dividedReportingOverflow(by: y) }
        let actual   = zipWith(xs, ys) { x, y in x.dividedReportingOverflow(by: y) }
        let result1: ()? = try? #require(actual.map { $0.partialValue } == expected.map { $0.partialValue })
        let result2: ()? = try? #require(actual.map { $0.overflow } == expected.map { $0.overflow })
        return result1 != nil && result2 != nil
      }}
}

// @inline(never)
private func remainderReportingOverflowTest<T: Arbitrary & FixedWidthInteger>(_: T.Type) {
    property(String(describing: T.self) + ".remainderReportingOverflow") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink([T].arbitrary) { (ys: [T]) in
        let expected = zip(xs, ys).map { x, y in x.remainderReportingOverflow(dividingBy: y) }
        let actual   = zipWith(xs, ys) { x, y in x.remainderReportingOverflow(dividingBy: y) }
        let result1: ()? = try? #require(actual.map { $0.partialValue } == expected.map { $0.partialValue })
        let result2: ()? = try? #require(actual.map { $0.overflow } == expected.map { $0.overflow })
        return result1 != nil && result2 != nil
      }}
}

// @inline(never)
private func multipliedFullWidthTest<T: Arbitrary & FixedWidthInteger>(_: T.Type) {
    property(String(describing: T.self) + ".multipliedFullWidth") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink([T].arbitrary) { (ys: [T]) in
        let expected = zip(xs, ys).map { x, y in x.multipliedFullWidth(by: y) }
        let actual   = zipWith(xs, ys) { x, y in x.multipliedFullWidth(by: y) }
        let result1: ()? = try? #require(actual.map { $0.high } == expected.map { $0.high })
        let result2: ()? = try? #require(actual.map { $0.low } == expected.map { $0.low })
        return result1 != nil && result2 != nil
      }}
}

// @inline(never)
private func dividingFullWidthTest<T: Arbitrary & FixedWidthInteger>(_: T.Type)
  where T.Magnitude: Arbitrary
{
    property(String(describing: T.self) + ".dividingFullWidth") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink([T].arbitrary) { (ys: [T]) in
      forAllNoShrink([T.Magnitude].arbitrary) { (zs: [T.Magnitude]) in
        let expected = zip(xs, zip(ys, zs).map { y, z in (high: y, low: z) })
                        .map { x, yz in x.dividingFullWidth(yz) } // swiftlint:disable:this identifier_name

        // TODO: zipWith3
        let n        = min(min(xs.count, ys.count), zs.count)
        let actual   = generate(count: n) { i in
            let x = xs[i]
            let y = ys[i]
            let z = zs[i]
            return x.dividingFullWidth((high: y, low: z))
        }

        let result1: ()? = try? #require(actual.map { $0.quotient } == expected.map { $0.quotient })
        let result2: ()? = try? #require(actual.map { $0.remainder } == expected.map { $0.remainder })
        return result1 != nil && result2 != nil
      }}}
}

// MARK: FloatingPoint

// @inline(never)
private func quotTest<T: Arbitrary & Similar & FloatingPoint>(_: T.Type) {
    let gen = T.arbitrary.suchThat { !($0 ~~~ 0) }
    property(String(describing: T.self) + "./") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink(gen.proliferate) { (ys: [T]) in
        let expected = zip(xs, ys).map { x, y in x / y }
        let actual   = zipWith(xs, ys, /)
        return try? #require(actual ~~~ expected)
      }}
}

// @inline(never)
private func exponentTest<T: Arbitrary & FloatingPoint>(_: T.Type) {
    property(String(describing: T.self) + ".exponent") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { $0.exponent }
        let actual   = map(xs) { $0.exponent }
        return try? #require(actual == expected)
    }
}

// @inline(never)
private func floatingPointClassTest<T: Arbitrary & FloatingPoint>(_: T.Type) {
    property(String(describing: T.self) + ".floatingPointClass") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { $0.floatingPointClass }
        let actual   = map(xs) { $0.floatingPointClass }
        return try? #require(actual == expected)
    }
}

// @inline(never)
private func isCanonicalTest<T: Arbitrary & FloatingPoint>(_: T.Type) {
    property(String(describing: T.self) + ".isCanonical") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { $0.isCanonical }
        let actual   = map(xs) { $0.isCanonical }
        return try? #require(actual == expected)
    }
}

// @inline(never)
private func isFiniteTest<T: Arbitrary & FloatingPoint>(_: T.Type) {
    property(String(describing: T.self) + ".isFinite") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { $0.isFinite }
        let actual   = map(xs) { $0.isFinite }
        return try? #require(actual == expected)
    }
}

// @inline(never)
private func isInfiniteTest<T: Arbitrary & FloatingPoint>(_: T.Type) {
    property(String(describing: T.self) + ".isInfinite") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { $0.isInfinite }
        let actual   = map(xs) { $0.isInfinite }
        return try? #require(actual == expected)
    }
}

// @inline(never)
private func isNaNTest<T: Arbitrary & FloatingPoint>(_: T.Type) {
    property(String(describing: T.self) + ".isNaN") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { $0.isNaN }
        let actual   = map(xs) { $0.isNaN }
        return try? #require(actual == expected)
    }
}

// @inline(never)
private func isSignalingNaNTest<T: Arbitrary & FloatingPoint>(_: T.Type) {
    property(String(describing: T.self) + ".isSignalingNaN") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { $0.isSignalingNaN }
        let actual   = map(xs) { $0.isSignalingNaN }
        return try? #require(actual == expected)
    }
}

// @inline(never)
private func isNormalTest<T: Arbitrary & FloatingPoint>(_: T.Type) {
    property(String(describing: T.self) + ".isNormal") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { $0.isNormal }
        let actual   = map(xs) { $0.isNormal }
        return try? #require(actual == expected)
    }
}

// @inline(never)
private func isSubnormalTest<T: Arbitrary & FloatingPoint>(_: T.Type) {
    property(String(describing: T.self) + ".isSubnormal") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { $0.isSubnormal }
        let actual   = map(xs) { $0.isSubnormal }
        return try? #require(actual == expected)
    }
}

// @inline(never)
private func isZeroTest<T: Arbitrary & FloatingPoint>(_: T.Type) {
    property(String(describing: T.self) + ".isZero") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { $0.isZero }
        let actual   = map(xs) { $0.isZero }
        return try? #require(actual == expected)
    }
}

// @inline(never)
private func nextDownTest<T: Arbitrary & FloatingPoint>(_: T.Type) {
    property(String(describing: T.self) + ".nextDown") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { $0.nextDown }
        let actual   = map(xs) { $0.nextDown }
        return try? #require(actual == expected)
    }
}

// @inline(never)
private func nextUpTest<T: Arbitrary & FloatingPoint>(_: T.Type) {
    property(String(describing: T.self) + ".nextUp") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { $0.nextUp }
        let actual   = map(xs) { $0.nextUp }
        return try? #require(actual == expected)
    }
}

// @inline(never)
private func signTest<T: Arbitrary & FloatingPoint>(_: T.Type) {
    property(String(describing: T.self) + ".sign") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { $0.sign }
        let actual   = map(xs) { $0.sign }
        return try? #require(actual == expected)
    }
}

// @inline(never)
private func significandTest<T: Arbitrary & FloatingPoint>(_: T.Type) {
    property(String(describing: T.self) + ".significand") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { $0.significand }
        let actual   = map(xs) { $0.significand }
        return try? #require(actual == expected)
    }
}

// @inline(never)
private func ulpTest<T: Arbitrary & FloatingPoint>(_: T.Type) {
    let gen = T.arbitrary.suchThat { !($0.isInfinite) } // Float16
    property(String(describing: T.self) + ".ulp") <-
      forAllNoShrink(gen.proliferate) { (xs: [T]) in
        let expected = xs.map { $0.ulp }
        let actual   = map(xs) { $0.ulp }
        return try? #require(actual == expected)
    }
}

// @inline(never)
private func roundedTest<T: Arbitrary & FloatingPoint>(_: T.Type) {
    property(String(describing: T.self) + ".rounded") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { $0.rounded() }
        let actual   = map(xs) { $0.rounded() }
        return try? #require(actual == expected)
    }
}

// Not working ):
// @inline(never)
private func roundedWithRoundingRuleTest<T: Arbitrary & FloatingPoint>(_: T.Type) {
    property(String(describing: T.self) + ".roundedWithRoundingRule") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink(FloatingPointRoundingRule.arbitrary) { (rule: FloatingPointRoundingRule) in
        let expected = xs.map { $0.rounded(rule) }
        let actual   = map(xs) { $0.rounded(rule) }
        return try? #require(actual == expected)
    }}
}

// @inline(never)
private func floorTest<T: Arbitrary & FloatingPoint>(_: T.Type) {
    property(String(describing: T.self) + ".floor") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { $0.rounded(.down) }
        let actual   = map(xs) { $0.rounded(.down) }
        return try? #require(actual == expected)
    }
}

// @inline(never)
private func ceilingTest<T: Arbitrary & FloatingPoint>(_: T.Type) {
    property(String(describing: T.self) + ".ceiling") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { $0.rounded(.up) }
        let actual   = map(xs) { $0.rounded(.up) }
        return try? #require(actual == expected)
    }
}

// @inline(never)
private func truncateTest<T: Arbitrary & FloatingPoint>(_: T.Type) {
    property(String(describing: T.self) + ".truncate") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { $0.rounded(.towardZero) }
        let actual   = map(xs) { $0.rounded(.towardZero) }
        return try? #require(actual == expected)
    }
}

// MARK: swift-numerics

// @inline(never)
private func powTest<T: Arbitrary & Similar & ElementaryFunctions>(_: T.Type) {
    property(String(describing: T.self) + "pow") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink([T].arbitrary) { (ys: [T]) in
        let expected = zip(xs, ys).map { x, y in T.pow(x, y) }
        let actual   = zipWith(xs, ys) { x, y in T.pow(x, y) }
        return try? #require(actual ~~~ expected)
      }}
}

// @inline(never)
private func powiTest<T: Arbitrary & Similar & ElementaryFunctions>(_: T.Type) {
    property(String(describing: T.self) + "powi") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink([Int].arbitrary) { (ys: [Int]) in
        let expected = zip(xs, ys).map { x, y in T.pow(x, y) }
        let actual   = zipWith(xs, ys) { x, y in T.pow(x, y) }
        return try? #require(actual ~~~ expected)
      }}
}

// @inline(never)
private func sqrtTest<T: Arbitrary & Similar & RandomType & FloatingPoint & ElementaryFunctions>(_: T.Type) {
    let gen = Gen.sized { size in Gen.choose((0, T(size))) }
    property(String(describing: T.self) + ".sqrt") <-
      forAllNoShrink(gen.proliferate) { (xs: [T]) in
        let expected = xs.map { T.sqrt($0) }
        let actual   = map(xs) { T.sqrt($0) }
        return try? #require(actual ~~~ expected)
    }
}

// @inline(never)
private func reciprocalTest<T: Arbitrary & Similar & RandomType & AlgebraicField>(_: T.Type) {
    property(String(describing: T.self) + ".reciprocal") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { $0.reciprocal }
        let actual   = map(xs) { $0.reciprocal }
        return try? #require(actual ~~~ expected)
    }
}

// @inline(never)
private func expTest<T: Arbitrary & Similar & ElementaryFunctions>(_: T.Type) {
    property(String(describing: T.self) + ".exp") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { T.exp($0) }
        let actual   = map(xs) { T.exp($0) }
        return try? #require(actual ~~~ expected)
    }
}

// @inline(never)
private func exp2Test<T: Arbitrary & Similar & RealFunctions>(_: T.Type) {
    property(String(describing: T.self) + ".ex2p") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { T.exp2($0) }
        let actual   = map(xs) { T.exp2($0) }
        return try? #require(actual ~~~ expected)
    }
}

// @inline(never)
private func exp10Test<T: Arbitrary & Similar & RealFunctions>(_: T.Type) {
    property(String(describing: T.self) + ".exp10") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { T.exp10($0) }
        let actual   = map(xs) { T.exp10($0) }
        return try? #require(actual ~~~ expected)
    }
}

// @inline(never)
private func expMinusOneTest<T: Arbitrary & Similar & ElementaryFunctions>(_: T.Type) {
    property(String(describing: T.self) + ".expMinusOne") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { T.expMinusOne($0) }
        let actual   = map(xs) { T.expMinusOne($0) }
        return try? #require(actual ~~~ expected)
    }
}

// @inline(never)
private func logTest<T: Arbitrary & Similar & RandomType & FloatingPoint & ElementaryFunctions>(_: T.Type) {
    let gen = Gen.sized { size in Gen.choose((T(0).nextUp, T(size))) }
    property(String(describing: T.self) + ".log") <-
      forAllNoShrink(gen.proliferate) { (xs: [T]) in
        let expected = xs.map { T.log($0) }
        let actual   = map(xs) { T.log($0) }
        return try? #require(actual ~~~ expected)
    }
}

// @inline(never)
private func log2Test<T: Arbitrary & Similar & RandomType & FloatingPoint & RealFunctions>(_: T.Type) {
    let gen = Gen.sized { size in Gen.choose((T(0).nextUp, T(size))) }
    property(String(describing: T.self) + ".log2") <-
      forAllNoShrink(gen.proliferate) { (xs: [T]) in
        let expected = xs.map { T.log2($0) }
        let actual   = map(xs) { T.log2($0) }
        return try? #require(actual ~~~ expected)
    }
}

// @inline(never)
private func log10Test<T: Arbitrary & Similar & RandomType & FloatingPoint & RealFunctions>(_: T.Type) {
    let gen = Gen.sized { size in Gen.choose((T(0).nextUp, T(size))) }
    property(String(describing: T.self) + ".log10") <-
      forAllNoShrink(gen.proliferate) { (xs: [T]) in
        let expected = xs.map { T.log10($0) }
        let actual   = map(xs) { T.log10($0) }
        return try? #require(actual ~~~ expected)
    }
}

// @inline(never)
private func logOnePlusTest<T: Arbitrary & Similar & RandomType & FloatingPoint & ElementaryFunctions>(_: T.Type) {
    let gen = Gen.sized { size in Gen.choose((T(-1).nextUp, T(size))) }
    property(String(describing: T.self) + ".logOnePlus") <-
      forAllNoShrink(gen.proliferate) { (xs: [T]) in
        let expected = xs.map { T.log(onePlus: $0) }
        let actual   = map(xs) { T.log(onePlus: $0) }
        return try? #require(actual ~~~ expected)
    }
}

// @inline(never)
private func sinTest<T: Arbitrary & Similar & ElementaryFunctions>(_: T.Type) {
    property(String(describing: T.self) + ".sin") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { T.sin($0) }
        let actual   = map(xs) { T.sin($0) }
        return try? #require(actual ~~~ expected)
    }
}

// @inline(never)
private func cosTest<T: Arbitrary & Similar & ElementaryFunctions>(_: T.Type) {
    property(String(describing: T.self) + ".cos") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { T.cos($0) }
        let actual   = map(xs) { T.cos($0) }
        return try? #require(actual ~~~ expected)
    }
}

// @inline(never)
private func tanTest<T: Arbitrary & Similar & FloatingPoint & ElementaryFunctions>(_: T.Type) {
    let gen = T.arbitrary.suchThat { !($0 ~~~ 0) }
    property(String(describing: T.self) + ".tan") <-
      forAllNoShrink(gen.proliferate) { (xs: [T]) in
        let expected = xs.map { T.tan($0) }
        let actual   = map(xs) { T.tan($0) }
        return try? #require(actual ~~~ expected)
    }
}

// @inline(never)
private func asinTest<T: Arbitrary & Similar & RandomType & FloatingPoint & ElementaryFunctions>(_: T.Type) {
    let gen = Gen.choose((T(-1), T(1)))
    property(String(describing: T.self) + ".asin") <-
      forAllNoShrink(gen.proliferate) { (xs: [T]) in
        let expected = xs.map { T.asin($0) }
        let actual   = map(xs) { T.asin($0) }
        return try? #require(actual ~~~ expected)
    }
}

// @inline(never)
private func acosTest<T: Arbitrary & Similar & RandomType & FloatingPoint & ElementaryFunctions>(_: T.Type) {
    let gen = Gen.choose((T(-1), T(1)))
    property(String(describing: T.self) + ".acos") <-
      forAllNoShrink(gen.proliferate) { (xs: [T]) in
        let expected = xs.map { T.acos($0) }
        let actual   = map(xs) { T.acos($0) }
        return try? #require(actual ~~~ expected)
    }
}

// @inline(never)
private func atanTest<T: Arbitrary & Similar & FloatingPoint & ElementaryFunctions>(_: T.Type) {
    property(String(describing: T.self) + ".atan") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { T.atan($0) }
        let actual   = map(xs) { T.atan($0) }
        return try? #require(actual ~~~ expected)
    }
}

// @inline(never)
private func sinhTest<T: Arbitrary & Similar & ElementaryFunctions>(_: T.Type) {
    property(String(describing: T.self) + ".sinh") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { T.sinh($0) }
        let actual   = map(xs) { T.sinh($0) }
        return try? #require(actual ~~~ expected)
    }
}

// @inline(never)
private func coshTest<T: Arbitrary & Similar & ElementaryFunctions>(_: T.Type) {
    property(String(describing: T.self) + ".cosh") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { T.cosh($0) }
        let actual   = map(xs) { T.cosh($0) }
        return try? #require(actual ~~~ expected)
    }
}

// @inline(never)
private func tanhTest<T: Arbitrary & Similar & ElementaryFunctions>(_: T.Type) {
    property(String(describing: T.self) + ".tanh") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { T.tanh($0) }
        let actual   = map(xs) { T.tanh($0) }
        return try? #require(actual ~~~ expected)
    }
}

// @inline(never)
private func asinhTest<T: Arbitrary & Similar & ElementaryFunctions>(_: T.Type) {
    property(String(describing: T.self) + ".asinh") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { T.asinh($0) }
        let actual   = map(xs) { T.asinh($0) }
        return try? #require(actual ~~~ expected)
    }
}

// @inline(never)
private func acoshTest<T: Arbitrary & Similar & RandomType & FloatingPoint & ElementaryFunctions>(_: T.Type) {
    let gen = Gen.sized { size in Gen.choose((T(1), T(size))) }
    property(String(describing: T.self) + ".acosh") <-
      forAllNoShrink(gen.proliferate) { (xs: [T]) in
        let expected = xs.map { T.acosh($0) }
        let actual   = map(xs) { T.acosh($0) }
        return try? #require(actual ~~~ expected)
    }
}

// @inline(never)
private func atanhTest<T: Arbitrary & Similar & RandomType & FloatingPoint & ElementaryFunctions>(_: T.Type) {
    let gen = Gen.choose((T(-1), T(1)))
    property(String(describing: T.self) + ".atanh") <-
      forAllNoShrink(gen.proliferate) { (xs: [T]) in
        let expected = xs.map { T.atanh($0) }
        let actual   = map(xs) { T.atanh($0) }
        return try? #require(actual ~~~ expected)
    }
}

// @inline(never)
private func atan2Test<T: Arbitrary & Similar & RealFunctions>(_: T.Type) {
    property(String(describing: T.self) + "atan2") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink([T].arbitrary) { (ys: [T]) in
        let expected = zip(xs, ys).map { x, y in T.atan2(y: y, x: x) }
        let actual   = zipWith(xs, ys) { x, y in T.atan2(y: y, x: x) }
        return try? #require(actual ~~~ expected)
      }}
}

// @inline(never)
private func erfTest<T: Arbitrary & Similar & RealFunctions>(_: T.Type) {
    property(String(describing: T.self) + ".erf") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { T.erf($0) }
        let actual   = map(xs) { T.erf($0) }
        return try? #require(actual ~~~ expected)
    }
}

// @inline(never)
private func erfcTest<T: Arbitrary & Similar & RealFunctions>(_: T.Type) {
    property(String(describing: T.self) + ".erfc") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { T.erfc($0) }
        let actual   = map(xs) { T.erfc($0) }
        return try? #require(actual ~~~ expected)
    }
}

// @inline(never)
private func gammaTest<T: Arbitrary & Similar & RealFunctions>(_: T.Type) {
    property(String(describing: T.self) + ".gamma") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { T.gamma($0) }
        let actual   = map(xs) { T.gamma($0) }
        return try? #require(actual ~~~ expected)
    }
}

// @inline(never)
private func logGammaTest<T: Arbitrary & Similar & RealFunctions>(_: T.Type) {
    property(String(describing: T.self) + ".logGamma") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { T.logGamma($0) }
        let actual   = map(xs) { T.logGamma($0) }
        return try? #require(actual ~~~ expected)
    }
}

// @inline(never)
private func hypotTest<T: Arbitrary & Similar & RealFunctions>(_: T.Type) {
    property(String(describing: T.self) + "hypot") <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
      forAllNoShrink([T].arbitrary) { (ys: [T]) in
        let expected = zip(xs, ys).map { x, y in T.hypot(x, y) }
        let actual   = zipWith(xs, ys) { x, y in T.hypot(x, y) }
        return try? #require(actual ~~~ expected)
      }}
}
