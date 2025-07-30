import Randy
import SwiftToPTX
import Testing

@Suite("Array") struct ArrayTestSuite {
    @Test("copy") func test_copy() {
        let n = Int.random(in: 1...2048, using: &generator)
        let xs = [Double].random(count: n, using: &generator)
        var ys = [Double](unsafeUninitializedCapacity: xs.count)
        parallel_for(iterations: ys.count) { i in
            ys[i] = xs[i]
        }.sync()
        #expect(xs == ys)
    }

    // @Test("offset") func test_offset() {
    //     let n = Int.random(in: 1...2048, using: &generator)
    //     let xs = [Double].random(count: n, using: &generator)
    //     var ys = [Double](unsafeUninitializedCapacity: xs.count + 1) { buffer, count in
    //         buffer[0] = 0
    //         count = xs.count + 1
    //     }
    //     parallel_for(iterations: ys.count) { i in
    //         ys[i + 1] = xs[i]
    //     }.sync()
    //     #expect(xs[0...] == ys[1...])
    // }

    // TODO: why is this crashing?
    // @Test("finite_difference") func test_fininite_difference() {
    //     let n = Int.random(in: 1...2048, using: &generator)
    //     let xs = [Double].random(count: n, using: &generator)
    //     test_ptx_vs_cpu(
    //         input: xs, fn_ptx: parallel_finite_difference, fn_cpu: finite_difference
    //     )
    // }

    @Test("adjacent_difference") func test_adj_diff() {
        let n = Int.random(in: 1...2048, using: &generator)
        let xs = [Double].random(count: n, using: &generator)
        test_ptx_vs_cpu(
            input: xs, fn_ptx: parallel_adjacent_difference, fn_cpu: adjacent_difference
        )
    }
}

// MARK: finite difference
private func finite_difference(_ xs: [Double]) -> [Double] {
    return xs.enumerated().compactMap {
        let (i, x) = $0
        guard i != xs.startIndex else { return nil }
        return x - xs[i - 1]
    }
}
private func parallel_finite_difference(_ xs: [Double]) -> [Double] {
    var dxs = [Double](unsafeUninitializedCapacity: xs.count - 1)
    parallel_for(iterations: dxs.count) { i in
        dxs[i] = xs[i + 1] - xs[i]
    }.sync()
    return dxs
}

// MARK: adjacent difference
private func parallel_adjacent_difference(_ xs: [Double]) -> [Double] {
    return imap(xs) { i, x in
        if i == 0 {
            return x
        }
        return x - xs[i - 1]
    }
}
private func adjacent_difference(_ xs: [Double]) -> [Double] {
    return xs.enumerated().map {
        let (i, x) = $0
        guard i != 0 else {
            return x
        }
        return x - xs[i - 1]
    }
}

// MARK: test helpers
@inline(__always)
private func test_ptx_vs_cpu(
    input xs: [Double], fn_ptx: ([Double]) -> [Double], fn_cpu: ([Double]) -> [Double]
) {
    let result = fn_ptx(xs)
    let expected = fn_cpu(xs)
    #expect(result == expected)
}
