// Copyright (c) 2026 The swift-to-gpu authors. All rights reserved.
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
import SwiftToGPU

let benchmarks: @Sendable () -> Void = {
    func config(_ scalingFactor: BenchmarkScalingFactor) -> Benchmark.Configuration {
        .init(
            metrics: [.wallClock],
            warmupIterations: 1,
            scalingFactor: scalingFactor,
            maxDuration: .seconds(5)
        )
    }

    let configs: [(Int, BenchmarkScalingFactor)] = [
        (100, .kilo),
        (1000, .kilo),
        (10_000, .kilo),
        (25_000, .kilo),
        (50_000, .kilo),
        (75_000, .kilo),
        (100_000, .kilo),
        (250_000, .kilo),
        (500_000, .kilo),
        (750_000, .kilo),
        (1_000_000, .kilo),
        (2_500_000, .kilo),
        (5_000_000, .kilo),
        (7_500_000, .kilo),
        (10_000_000, .kilo),
    ]

    for (iterations, scalingFactor) in configs {
        Benchmark("kernelLaunchSync/\(iterations)", configuration: config(scalingFactor)) { benchmark throws in
            for _ in benchmark.scaledIterations {
                try parallel_for(iterations: iterations) { _ in }.sync()
            }
        }
    }
}
