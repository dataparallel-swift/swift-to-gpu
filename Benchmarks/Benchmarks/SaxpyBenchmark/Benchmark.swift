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
import Randy

let benchmarks: @Sendable () -> Void = {
    var gen = UniformRandomNumberGenerator()
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

    // swiftlint:disable:next large_tuple
    func setup<A: Randomizable>(_: A.Type, _ n: Int) -> (A, [A], [A]) {
        let alpha = A.random(using: &gen)
        let xs = Array<A>.random(count: n, using: &gen)
        let ys = Array<A>.random(count: n, using: &gen)
        return (alpha, xs, ys)
    }

    func bench<Input, Output>(_ function: @escaping ((Input) -> Output)) -> (Benchmark, Input) -> Void {
        return { _, input in
            // for _ in benchmark.scaledIterations {
            blackHole(function(input))
            // }
        }
    }

    // We need to generate the benchmark data anew in the setup function,
    // otherwise the benchmark framework will generate all data before any
    // benchmarking starts (which consumes a lot of memory...)
    for (size, scaling) in configs {
        // swiftformat:disable wrap wrapArguments wrapSingleLineComments
        #if arch(arm64)
        // Benchmark("saxpy/cuda/f16/\(size)",             configuration: config(scaling), closure: bench(saxpy_cuda_f16),         setup: { setup(Float16.self, size) })
        Benchmark("saxpy/ptx/f16/\(size)", configuration: config(scaling), closure: bench(saxpy_ptx_f16), setup: { setup(Float16.self, size) })
        Benchmark("saxpy/cpu/f16/\(size)", configuration: config(scaling), closure: bench(saxpy_cpu_f16), setup: { setup(Float16.self, size) })
        // Benchmark("saxpy/cpu_generic/f16/\(size)",      configuration: config(scaling), closure: bench(saxpy_cpu_generic),      setup: { setup(Float16.self, size) })
        Benchmark("saxpy/cpu_generic_safe/f16/\(size)", configuration: config(scaling), closure: bench(saxpy_cpu_generic_safe), setup: { setup(Float16.self, size) })
        // Benchmark("saxpy/cpu_specialised/f16/\(size)",  configuration: config(scaling), closure: bench(saxpy_cpu_specialised),  setup: { setup(Float16.self, size) })
        #endif

        #if PTX
        Benchmark("saxpy/cuda/f32/\(size)", configuration: config(scaling), closure: bench(saxpy_cuda_f32), setup: { setup(Float32.self, size) })
        #endif
        Benchmark("saxpy/ptx/f32/\(size)", configuration: config(scaling), closure: bench(saxpy_ptx_f32), setup: { setup(Float32.self, size) })
        Benchmark("saxpy/cpu/f32/\(size)", configuration: config(scaling), closure: bench(saxpy_cpu_f32), setup: { setup(Float32.self, size) })
        // Benchmark("saxpy/cpu_generic/f32/\(size)",      configuration: config(scaling), closure: bench(saxpy_cpu_generic),      setup: { setup(Float32.self, size) })
        Benchmark("saxpy/cpu_generic_safe/f32/\(size)", configuration: config(scaling), closure: bench(saxpy_cpu_generic_safe), setup: { setup(Float32.self, size) })
        // Benchmark("saxpy/cpu_specialised/f32/\(size)",  configuration: config(scaling), closure: bench(saxpy_cpu_specialised),  setup: { setup(Float32.self, size) })

        #if PTX
        Benchmark("saxpy/cuda/f64/\(size)", configuration: config(scaling), closure: bench(saxpy_cuda_f64), setup: { setup(Float64.self, size) })
        #endif
        Benchmark("saxpy/ptx/f64/\(size)", configuration: config(scaling), closure: bench(saxpy_ptx_f64), setup: { setup(Float64.self, size) })
        Benchmark("saxpy/cpu/f64/\(size)", configuration: config(scaling), closure: bench(saxpy_cpu_f64), setup: { setup(Float64.self, size) })
        // Benchmark("saxpy/cpu_generic/f64/\(size)",      configuration: config(scaling), closure: bench(saxpy_cpu_generic),      setup: { setup(Float64.self, size) })
        Benchmark("saxpy/cpu_generic_safe/f64/\(size)", configuration: config(scaling), closure: bench(saxpy_cpu_generic_safe), setup: { setup(Float64.self, size) })
        // Benchmark("saxpy/cpu_specialised/f64/\(size)",  configuration: config(scaling), closure: bench(saxpy_cpu_specialised),  setup: { setup(Float64.self, size) })
    }
}
