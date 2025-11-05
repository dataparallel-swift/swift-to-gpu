// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "swift-ptx-backend-benchmarks",
    platforms: [.macOS("15")],
    traits: [
        .default(enabledTraits: ["PTX"]),
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
        .package(url: "git@gitlab.com:PassiveLogic/Randy.git", from: "0.7.0"),
        .package(url: "git@gitlab.com:PassiveLogic/compiler/swift-cuda.git", from: "0.2.0"),
    ],
    targets: [
        .target(
            name: "BenchmarkFunctions",
            dependencies: [
                .target(name: "BenchmarkFunctionsC", condition: .when(traits: ["PTX"])),
                .product(name: "SwiftToGPU", package: "swift-to-ptx"),
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
                .product(name: "CUDA", package: "swift-cuda"),
            ]
        ),
        .executableTarget(
            name: "SaxpyBenchmark",
            dependencies: [
                "Randy",
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
                "Randy",
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
