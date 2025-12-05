// Copyright (c) 2025 The swift-to-gpu authors. All rights reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import Benchmark
import BenchmarkFunctions

let benchmarks: @Sendable () -> Void = {
    var gen = SystemRandomNumberGenerator()
    let configs: [(Int, BenchmarkScalingFactor)] = [
        (100, .one),
        (1000, .one),
        (10_000, .one),
        (25_000, .one),
        (50_000, .one),
        (75_000, .one),
        (100_000, .one),
        (250_000, .one),
        (500_000, .one),
        (750_000, .one),
        (1_000_000, .one),
        (2_500_000, .one),
        (5_000_000, .one),
        (7_500_000, .one),
        (10_000_000, .one),
    ]

    func config(_ scalingFactor: BenchmarkScalingFactor) -> Benchmark.Configuration {
        .init(
            metrics: [.wallClock], // , .cpuTotal, .cpuSystem, .cpuUser],
            warmupIterations: 3,
            scalingFactor: scalingFactor,
            maxDuration: .seconds(10)
        )
    }

    func randomArray<Element: Randomizable, R: RandomNumberGenerator>(
        count: Int,
        in range: ClosedRange<Element>,
        using generator: inout R
    ) -> [Element] {
        (0 ..< count).map { _ in Element.sample(in: range, using: &generator) }
    }

    // swiftlint:disable:next large_tuple
    func setup<A: Randomizable & BinaryFloatingPoint>(_: A.Type, _ n: Int) -> (A, A, [A], [A], [A]) {
        let riskfree: A = 0.02
        let volatility: A = 0.30
        let price: [A] = randomArray(count: n, in: 5 ... 30, using: &gen)
        let strike: [A] = randomArray(count: n, in: 1 ... 100, using: &gen)
        let time: [A] = randomArray(count: n, in: 0.25 ... 10, using: &gen)
        return (riskfree, volatility, price, strike, time)
    }

    func bench<Input, Output>(_ function: @escaping ((Input) -> Output)) -> (Benchmark, Input) -> Void {
        return { _, input in
            // for _ in benchmark.scaledIterations {
            blackHole(function(input))
            // }
        }
    }

    for (size, scaling) in configs {
        // swiftformat:disable wrap wrapArguments
        #if arch(arm64)
        Benchmark("blackscholes/ptx/f16/\(size)", configuration: config(scaling), closure: bench(blackscholes_ptx_f16), setup: { setup(Float16.self, size) })
        Benchmark("blackscholes/cpu/f16/\(size)", configuration: config(scaling), closure: bench(blackscholes_cpu_f16), setup: { setup(Float16.self, size) })
        Benchmark("blackscholes/cpu_generic_safe/f16/\(size)", configuration: config(scaling), closure: bench(blackscholes_cpu_generic_safe), setup: { setup(Float16.self, size) })
        #endif

        #if PTX
        Benchmark("blackscholes/cuda/f32/\(size)", configuration: config(scaling), closure: bench(blackscholes_cuda_f32), setup: { setup(Float32.self, size) })
        #endif
        Benchmark("blackscholes/ptx/f32/\(size)", configuration: config(scaling), closure: bench(blackscholes_ptx_f32), setup: { setup(Float32.self, size) })
        Benchmark("blackscholes/cpu/f32/\(size)", configuration: config(scaling), closure: bench(blackscholes_cpu_f32), setup: { setup(Float32.self, size) })
        Benchmark("blackscholes/cpu_generic_safe/f32/\(size)", configuration: config(scaling), closure: bench(blackscholes_cpu_generic_safe), setup: { setup(Float32.self, size) })

        Benchmark("blackscholes/ptx/f64/\(size)", configuration: config(scaling), closure: bench(blackscholes_ptx_f64), setup: { setup(Float64.self, size) })
        Benchmark("blackscholes/cpu/f64/\(size)", configuration: config(scaling), closure: bench(blackscholes_cpu_f64), setup: { setup(Float64.self, size) })
        Benchmark("blackscholes/cpu_generic_safe/f64/\(size)", configuration: config(scaling), closure: bench(blackscholes_cpu_generic_safe), setup: { setup(Float64.self, size) })
    }
}

protocol Randomizable where Self: Comparable {
    static func sample<R: RandomNumberGenerator>(in range: ClosedRange<Self>, using generator: inout R) -> Self
}

extension BinaryFloatingPoint where RawSignificand: FixedWidthInteger {
    static func sample<R: RandomNumberGenerator>(in range: ClosedRange<Self>, using generator: inout R) -> Self {
        Self.random(in: range, using: &generator)
    }
}

#if arch(arm64)
@available(macOS 11.0, iOS 14.0, tvOS 14.0, watchOS 7.0, *)
extension Float16: Randomizable {}
#endif
extension Float32: Randomizable {}
extension Float64: Randomizable {}
