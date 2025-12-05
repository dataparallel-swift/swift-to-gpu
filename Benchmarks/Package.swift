// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import Foundation
import PackageDescription

let disableJemalloc = ProcessInfo.processInfo.environment["BENCHMARK_DISABLE_JEMALLOC"].isSet
if !disableJemalloc {
    // swiftlint:disable:next logger_over_print
    print("Set BENCHMARK_DISABLE_JEMALLOC=true to get accurate data from package-benchmark!")
}

let package = Package(
    name: "swift-to-gpu-benchmarks",
    platforms: [.macOS("15")],
    traits: [
        "CPU",
        "PTX",
    ],
    dependencies: [
        .package(
            path: "..",
            traits: [
                .trait(name: "CPU", condition: .when(traits: ["CPU"])),
                .trait(name: "PTX", condition: .when(traits: ["PTX"])),
            ]
        ),
        .package(url: "https://github.com/apple/swift-numerics", from: "1.0.0"),
        .package(url: "https://github.com/ordo-one/package-benchmark", from: "1.4.0"),
        .package(url: "https://github.com/dataparallel-swift/swift-cuda.git", from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "BenchmarkFunctions",
            dependencies: [
                .target(name: "BenchmarkFunctionsC", condition: .when(traits: ["PTX"])),
                .product(name: "SwiftToGPU", package: "swift-to-gpu"),
                .product(name: "Numerics", package: "swift-numerics"),
            ],
            swiftSettings: [
                .unsafeFlags([
                    "-O",
                    "-num-threads", "1",
                    "-Xllvm", "--swift-to-ptx-verbose",
                    "-Xllvm", "-time-passes",
                ], .when(traits: ["PTX"])),
            ]
        ),
        .target(
            name: "BenchmarkFunctionsC",
            dependencies: [
                .product(name: "CUDA", package: "swift-cuda", condition: .when(traits: ["PTX"])),
            ],
            cSettings: [
                .define("PTX", .when(traits: ["PTX"])),
            ]
        ),
        .executableTarget(
            name: "SaxpyBenchmark",
            dependencies: [
                "BenchmarkFunctions",
                .product(name: "Benchmark", package: "package-benchmark"),
            ],
            path: "Benchmarks/SaxpyBenchmark",
            swiftSettings: [
                .unsafeFlags([
                    // "-Rpass-missed=specialize"
                ]),
            ],
            plugins: [
                .plugin(name: "BenchmarkPlugin", package: "package-benchmark"),
            ]
        ),
        .executableTarget(
            name: "BlackScholesBenchmark",
            dependencies: [
                "BenchmarkFunctions",
                .product(name: "Benchmark", package: "package-benchmark"),
            ],
            path: "Benchmarks/BlackScholesBenchmark",
            swiftSettings: [
                .unsafeFlags([
                    // "-Rpass-missed=specialize"
                ]),
            ],
            plugins: [
                .plugin(name: "BenchmarkPlugin", package: "package-benchmark"),
            ]
        ),
    ]
)

private extension String? {
    var isSet: Bool {
        if let value = self {
            return value.isEmpty || value == "1" || value.lowercased() == "true"
        }
        return false
    }
}
