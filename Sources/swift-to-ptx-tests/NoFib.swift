import Testing

@Suite("NoFib") struct NoFib {
    @Suite("Prelude") struct Prelude {
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
            @Test("Float16.significand") func test_significand() { prop_significand(Float16.self) }
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
}

