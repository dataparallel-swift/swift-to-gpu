// Copyright (c) 2025 PassiveLogic, Inc.

import PTXBackend
import SwiftCheck
import Testing

@Suite("SAXPY") struct SAXPY {
    @Test("Float16") func test_float16() { prop_saxpy(Float16.self) }
    @Test("Float32") func test_float32() { prop_saxpy(Float32.self) }
    @Test("Float64") func test_float64() { prop_saxpy(Float64.self) }
}

private func prop_saxpy<T: Arbitrary & Similar & Numeric>(_: T.Type) {
    property(String(describing: T.self) + ".saxpy") <-
      forAllNoShrink(Gen<Int>.choose((0, 8192))) { n in
      forAllNoShrink(T.arbitrary) { alpha in
      forAllNoShrink(T.arbitrary.proliferate(withSize: n)) { (xs: [T]) in
      forAllNoShrink(T.arbitrary.proliferate(withSize: n)) { (ys: [T]) in
        let expected = zip(xs, ys).map { x, y in alpha * x + y }

        // XXX: The following zipWith implementation is currently failing to
        // compile in release mode (only) with the error:
        //
        // > <unknown>:0: note: ptxas exited with code 255 :
        // > ptxas fatal   : Unresolved extern function '$s10SwiftToPTX8izipWith__4into6stream_ySayxG_Sayq_GSayq0_GzAA6StreamVq0_Si_xq_tq1_YKXEtq1_YKs5ErrorR1_r2_lFySiq1_YKXEfU_Sd_S2ds5NeverOTG5'
        //
        // So it looks like we are emitting only a single copy into the project,
        // rather than into every use site? We have set this project to always
        // compile with optimisations (otherwise the transformation won't happen
        // at all) so not sure what is different in debug+opt vs. release mode.
        //
        // This problem also occurs when compiling the test suite as an
        // executable target (so, it is not limited to something to do with the
        // test framework) so we may have to actually fix this at some point.
        //
        // https://app.clickup.com/t/86b6bad4n
        //
        // TLM 2025-10-06: The above issue is fixed by enabling cross-module
        // optimisation on everything (all APIs) with the -enable-cmo-everything
        // flag. This is only necessary in release mode (in fact, will cause
        // problems with swift-pm if enabled in debug).
        //
        // TLM 2025-10-07: Encountered other problems when enabling the above
        // flag, including PTX translation not working at all in some instances
        // (which I suppose is what allowed compilation to succeed) so disabling
        // again and reverting to the generate-based implementation.
        //
        // let actual = zipWith(xs, ys) { x, y in alpha * x + y }
        let actual = generate(count: n) { i in alpha * xs[i] + ys[i] }

        return try? #require(expected ~~~ actual)
      }}}}
}
