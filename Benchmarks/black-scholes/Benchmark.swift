import Benchmark
import BenchmarkFunctions
import Randy

let benchmarks : @Sendable () -> Void = {
    var gen = UniformRandomNumberGenerator()
    let configs : [(Int, BenchmarkScalingFactor)] = [
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
        (10_000_000, .one)
    ]

    func config(_ scalingFactor: BenchmarkScalingFactor) -> Benchmark.Configuration
    {
        .init(
            metrics: [.wallClock], // , .cpuTotal, .cpuSystem, .cpuUser],
            warmupIterations: 3,
            scalingFactor: scalingFactor,
            maxDuration: .seconds(10)
        )
    }

    func setup<A: BinaryFloatingPoint & RandomizableWithDistribution>(_ proxy: A.Type, _ n: Int) -> (A, A, [A], [A], [A])
    {
        let riskfree   : A = 0.02
        let volatility : A = 0.30
        let price  = Array<A>.random(count: n, in: RandomDistribution(.uniform(min: 5, max: 30)), using: &gen)
        let strike = Array<A>.random(count: n, in: RandomDistribution(.uniform(min: 1, max: 100)), using: &gen)
        let time   = Array<A>.random(count: n, in: RandomDistribution(.uniform(min: 0.25, max: 10)), using: &gen)
        return (riskfree, volatility, price, strike, time)
    }

    func bench<Input, Output>(_ function: @escaping ((Input) -> Output)) -> (Benchmark, Input) -> Void {
        return { benchmark, input in
            // for _ in benchmark.scaledIterations {
                blackHole(function(input))
            // }
        }
    }

    for (size, scaling) in configs {
        Benchmark.init("blackscholes_ptx_f16/\(size)",              configuration: config(scaling), closure: bench(blackscholes_ptx_f16),          setup: { setup(Float16.self, size) })
        Benchmark.init("blackscholes_cpu_f16/\(size)",              configuration: config(scaling), closure: bench(blackscholes_cpu_f16),          setup: { setup(Float16.self, size) })
        Benchmark.init("blackscholes_cpu_f16_generic_safe/\(size)", configuration: config(scaling), closure: bench(blackscholes_cpu_generic_safe), setup: { setup(Float16.self, size) })

        Benchmark.init("blackscholes_cuda_f32/\(size)",             configuration: config(scaling), closure: bench(blackscholes_cuda_f32),         setup: { setup(Float32.self, size) })
        Benchmark.init("blackscholes_ptx_f32/\(size)",              configuration: config(scaling), closure: bench(blackscholes_ptx_f32),          setup: { setup(Float32.self, size) })
        Benchmark.init("blackscholes_cpu_f32/\(size)",              configuration: config(scaling), closure: bench(blackscholes_cpu_f32),          setup: { setup(Float32.self, size) })
        Benchmark.init("blackscholes_cpu_f32_generic_safe/\(size)", configuration: config(scaling), closure: bench(blackscholes_cpu_generic_safe), setup: { setup(Float32.self, size) })

        Benchmark.init("blackscholes_ptx_f64/\(size)",              configuration: config(scaling), closure: bench(blackscholes_ptx_f64),          setup: { setup(Float64.self, size) })
        Benchmark.init("blackscholes_cpu_f64/\(size)",              configuration: config(scaling), closure: bench(blackscholes_cpu_f64),          setup: { setup(Float64.self, size) })
        Benchmark.init("blackscholes_cpu_f64_generic_safe/\(size)", configuration: config(scaling), closure: bench(blackscholes_cpu_generic_safe), setup: { setup(Float64.self, size) })
    }
}

