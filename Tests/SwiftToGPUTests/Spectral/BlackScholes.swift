// Copyright (c) 2025 PassiveLogic, Inc.

import Numerics
import SwiftCheck
import SwiftToGPU
import Testing

// swiftlint:disable identifier_name

@Suite("BlackScholes") struct BlackScholesTests {
    #if arch(arm64)
    @Test func blackscholes16() { blackscholesTest(Float16.self) }
    #endif
    #if PTX
    @Test(.bug(id: "86b6an9y0")) func blackscholes32() { withKnownIssue { blackscholesTest(Float32.self) } }
    #endif
    #if CPU
    @Test func blackscholes32() { blackscholesTest(Float32.self) }
    #endif
    @Test func blackscholes64() { blackscholesTest(Float64.self) }
}

private func blackscholesTest<T: Arbitrary & Similar & RandomType & BinaryFloatingPoint & ElementaryFunctions>(_: T.Type) {
    let riskfree: T = 0.02
    let volatility: T = 0.30
    property(String(describing: T.self) + ".blackscholes") <-
        forAllNoShrink(Gen<Int>.choose((1, 4096))) { n in
            forAllNoShrink(
                Gen<T>.choose((0, 30)).proliferate(withSize: n),
                Gen<T>.choose((1, 100)).proliferate(withSize: n),
                Gen<T>.choose((0.25, 10)).proliferate(withSize: n)
            ) { price, strike, years in
                let expected = (0 ..< n).map { i in blackscholes(
                    riskfree: riskfree,
                    volatility: volatility,
                    price: price[i],
                    strike: strike[i],
                    years: years[i]
                ) }
                let actual = generate(count: n) { i in blackscholes(
                    riskfree: riskfree,
                    volatility: volatility,
                    price: price[i],
                    strike: strike[i],
                    years: years[i]
                ) }

                let calls: ()? = try? #require(expected.map { $0.call } ~~~ actual.map { $0.call })
                let puts: ()? = try? #require(expected.map { $0.put } ~~~ actual.map { $0.put })
                return calls != nil && puts != nil
            }
        }
}

// Polynomial approximation of cumulative normal distribution function
private func cnd<A: BinaryFloatingPoint & ElementaryFunctions>(_ d: A) -> A {
    let A1: A = 0.319381530
    let A2: A = -0.356563782
    let A3: A = 1.781477937
    let A4: A = -1.821255978
    let A5: A = 1.330274429
    let RSQRT2PI: A = 0.39894228040143267793994605993438

    let K = 1.0 / (1.0 + 0.2316419 * abs(d))

    let H4 = A4 + K * A5
    let H3 = A3 + K * H4
    let H2 = A2 + K * H3
    let H1 = A1 + K * H2

    let cnd = RSQRT2PI * A.exp(-0.5 * d * d) * (K * H1)

    if d > 0 {
        return 1.0 - cnd
    }
    else {
        return cnd
    }
}

// Black-Scholes model for both call and put options
// https://en.wikipedia.org/wiki/Black–Scholes_model
//
private func blackscholes<A: BinaryFloatingPoint & ElementaryFunctions>(
    riskfree r: A,
    volatility v: A,
    price s: A,
    strike x: A,
    years t: A
) -> (call: A, put: A) {
    let v_sqrtT = v * A.sqrt(t)
    let d1 = (A.log(s / x) + (r + 0.5 * v * v) * t) / v_sqrtT
    let d2 = d1 - v_sqrtT
    let cnd_d1 = cnd(d1)
    let cnd_d2 = cnd(d2)

    let x_expRT = x * A.exp(-r * t)

    return (
        call: s * cnd_d1 - x_expRT * cnd_d2,
        put: x_expRT * (1.0 - cnd_d2) - s * (1.0 - cnd_d1)
    )
}
