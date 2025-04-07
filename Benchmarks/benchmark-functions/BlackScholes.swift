import Numerics
import SwiftToPTX
import BenchmarkFunctions_cbits

// Polynomial approximation of cumulative normal distribution function
func cnd<A: BinaryFloatingPoint & ElementaryFunctions>(_ d: A) -> A
{
    let A1 : A =  0.319381530
    let A2 : A = -0.356563782
    let A3 : A =  1.781477937
    let A4 : A = -1.821255978
    let A5 : A =  1.330274429
    let RSQRT2PI : A = 0.39894228040143267793994605993438

    let K  = 1.0 / (1.0 + 0.2316419 * abs(d))

    let H4 = A4 + K * A5
    let H3 = A3 + K * H4
    let H2 = A2 + K * H3
    let H1 = A1 + K * H2

    let cnd = RSQRT2PI * A.exp(-0.5 * d * d) * (K * H1)

    if (d > 0) {
        return 1.0 - cnd
    } else {
        return cnd
    }
}

// Black-Scholes model for both call and put options
// https://en.wikipedia.org/wiki/Black–Scholes_model
//
func blackscholes<A: BinaryFloatingPoint & ElementaryFunctions>(riskfree r: A, volatility v: A, price s: A, strike x: A, years t: A) -> (call: A, put: A)
{
  let v_sqrtT = v * A.sqrt(t)
  let d1      = (A.log(s / x) + (r + 0.5 * v * v) * t) / v_sqrtT;
  let d2      = d1 - v_sqrtT;
  let cnd_d1  = cnd(d1);
  let cnd_d2  = cnd(d2);

  let x_expRT = x * A.exp(-r * t)

  return ( call: s * cnd_d1 - x_expRT * cnd_d2
         , put:  x_expRT * (1.0 - cnd_d2) - s * (1.0 - cnd_d1)
         )
}


// MARK: CPU
// --------------------------------------------------------------------------------

public func blackscholes_cpu_f16(_ r: Float16, _ v: Float16, _ ps: [Float16], _ xs: [Float16], _ ts: [Float16]) -> [(call: Float16, put: Float16)]
{
    assert(ps.count == xs.count)
    assert(ps.count == ts.count)

    let n = ps.count
    return .init(unsafeUninitializedCapacity: n,
        initializingWith: { buffer, initializedCount in
            for i in 0..<n {
                buffer[i] = blackscholes(riskfree: r, volatility: v, price: ps[i], strike: xs[i], years: ts[i])
            }
            initializedCount = n
        }
    )
}

public func blackscholes_cpu_f32(_ r: Float32, _ v: Float32, _ ps: [Float32], _ xs: [Float32], _ ts: [Float32]) -> [(call: Float32, put: Float32)]
{
    assert(ps.count == xs.count)
    assert(ps.count == ts.count)

    let n = ps.count
    return .init(unsafeUninitializedCapacity: n,
        initializingWith: { buffer, initializedCount in
            for i in 0..<n {
                buffer[i] = blackscholes(riskfree: r, volatility: v, price: ps[i], strike: xs[i], years: ts[i])
            }
            initializedCount = n
        }
    )
}

public func blackscholes_cpu_f64(_ r: Float64, _ v: Float64, _ ps: [Float64], _ xs: [Float64], _ ts: [Float64]) -> [(call: Float64, put: Float64)]
{
    assert(ps.count == xs.count)
    assert(ps.count == ts.count)

    let n = ps.count
    return .init(unsafeUninitializedCapacity: n,
        initializingWith: { buffer, initializedCount in
            for i in 0..<n {
                buffer[i] = blackscholes(riskfree: r, volatility: v, price: ps[i], strike: xs[i], years: ts[i])
            }
            initializedCount = n
        }
    )
}

public func blackscholes_cpu_generic<A: BinaryFloatingPoint & ElementaryFunctions>(_ r: A, _ v: A, _ ps: [A], _ xs: [A], _ ts: [A]) -> [(call: A, put: A)]
{
    assert(ps.count == xs.count)
    assert(ps.count == ts.count)

    let n = ps.count
    return .init(unsafeUninitializedCapacity: n,
        initializingWith: { buffer, initializedCount in
            for i in 0..<n {
                buffer[i] = blackscholes(riskfree: r, volatility: v, price: ps[i], strike: xs[i], years: ts[i])
            }
            initializedCount = n
        }
    )
}

public func blackscholes_cpu_generic_safe<A: BinaryFloatingPoint & ElementaryFunctions>(_ r: A, _ v: A, _ ps: [A], _ xs: [A], _ ts: [A]) -> [(call: A, put: A)]
{
    assert(ps.count == xs.count)
    assert(ps.count == ts.count)

    let n = ps.count
    var result : [(call: A, put: A)] = []

    // result.reserveCapacaty(n)

    for i in 0..<n {
        result.append(blackscholes(riskfree: r, volatility: v, price: ps[i], strike: xs[i], years: ts[i]))
    }

    return result
}


// MARK: GPU
// --------------------------------------------------------------------------------

public func blackscholes_ptx_f16(_ r: Float16, _ v: Float16, _ ps: [Float16], _ xs: [Float16], _ ts: [Float16]) -> [(call: Float16, put: Float16)]
{
    assert(ps.count == xs.count)
    assert(ps.count == ts.count)

    return generate(count: ps.count) { i in
        blackscholes(riskfree: r, volatility: v, price: ps[i], strike: xs[i], years: ts[i])
    }
}


public func blackscholes_ptx_f32(_ r: Float32, _ v: Float32, _ ps: [Float32], _ xs: [Float32], _ ts: [Float32]) -> [(call: Float32, put: Float32)]
{
    assert(ps.count == xs.count)
    assert(ps.count == ts.count)

    return generate(count: ps.count) { i in
        blackscholes(riskfree: r, volatility: v, price: ps[i], strike: xs[i], years: ts[i])
    }
}

public func blackscholes_ptx_f64(_ r: Float64, _ v: Float64, _ ps: [Float64], _ xs: [Float64], _ ts: [Float64]) -> [(call: Float64, put: Float64)]
{
    assert(ps.count == xs.count)
    assert(ps.count == ts.count)

    return generate(count: ps.count) { i in
        blackscholes(riskfree: r, volatility: v, price: ps[i], strike: xs[i], years: ts[i])
    }
}


// MARK: CUDA
// --------------------------------------------------------------------------------

public func blackscholes_cuda_f32(_ r: Float32, _ v: Float32, _ ps: [Float32], _ xs: [Float32], _ ts: [Float32]) -> ([Float32], [Float32])
{
    assert(ps.count == xs.count)
    assert(ps.count == ts.count)

    let n = ps.count

    var call : [Float32] = []
    let put = Array<Float32>.init(
        unsafeUninitializedCapacity: n,
        initializingWith: { put_buffer, put_initializedCount in
            let tmp = Array<Float32>.init(
                unsafeUninitializedCapacity: n,
                initializingWith: { call_buffer, call_initializedCount in
                    BenchmarkFunctions_cbits.blackscholes_cuda_f32(r, v, ps, xs, ts, call_buffer.baseAddress, put_buffer.baseAddress, n)
                    call_initializedCount = n
                })
            put_initializedCount = n
            call = tmp
        })

    return (call, put)
}

