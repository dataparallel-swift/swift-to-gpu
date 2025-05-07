// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import Foundation
import PackageDescription

let libraryType: Product.Library.LibraryType? = (ProcessInfo.processInfo.environment["BUILD_STATIC_LIBRARIES"] == "true") ? .static : nil

let package = Package(
    name: "swift-to-ptx",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(name: "SwiftToPTX", type: libraryType, targets: ["SwiftToPTX"])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-atomics.git", from: "1.2.0"),
        .package(url: "https://github.com/apple/swift-log.git", "1.4.0" ..< "2.0.0"),
        .package(url: "https://github.com/apple/swift-nio.git", "2.42.0" ..< "3.0.0"),
        .package(url: "https://github.com/apple/swift-numerics", from: "1.0.0"),
        .package(url: "https://github.com/swiftlang/swift-testing.git", revision: "6.0.3"),
        .package(url: "https://github.com/typelift/SwiftCheck.git", from: "0.8.1"),
        .package(url: "https://github.com/ordo-one/package-benchmark", .upToNextMajor(from: "1.4.0")),
        .package(url: "git@gitlab.com:PassiveLogic/Experiments/swift-tracy.git", revision: "main"),
        .package(url: "git@gitlab.com:PassiveLogic/Randy.git", from: "0.4.0"),
        .package(url: "git@gitlab.com:PassiveLogic/compiler/swift-cuda.git", branch: "main"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "SwiftToPTX_cbits",
            dependencies: [
                .product(name: "CUDA", package: "swift-cuda")
            ],
            path: "Sources/swift-to-ptx-cbits"
        ),
        .target(
            name: "SwiftToPTX",
            dependencies: [
                "SwiftToPTX_cbits",
                .product(name: "CUDA", package: "swift-cuda"),
                .product(name: "Atomics", package: "swift-atomics"),
                .product(name: "Logging", package: "swift-log"),
                .product(name: "Tracy", package: "swift-tracy"),
                .product(name: "NIOConcurrencyHelpers", package: "swift-nio"),
            ],
            path: "Sources/swift-to-ptx"
        ),

        // Tests
        .executableTarget(
            name: "swift-to-ptx-nofib",
            dependencies: [
                "SwiftCheck",
                "SwiftToPTX",
                .product(name: "Numerics", package: "swift-numerics"),
                .product(name: "Testing", package: "swift-testing")
            ],
            path: "Tests/nofib",
            swiftSettings: [
                .unsafeFlags([
                    // "-Ounchecked",               // https://app.clickup.com/t/86b4gq63t
                    // "-Xllvm", "-time-passes"     // https://app.clickup.com/t/86b4gq4x2
                ])
            ]
        ),

        // Benchmarks
        .target(
            name: "BenchmarkFunctions",
            dependencies: [
                "SwiftToPTX",
                "BenchmarkFunctions_cbits",
                .product(name: "Numerics", package: "swift-numerics")
            ],
            path: "Benchmarks/benchmark-functions",
            swiftSettings: [
                .unsafeFlags([
                    "-O",
                    "-num-threads", "1",
                    "-Xllvm", "--swift-to-ptx-verbose",
                    "-Xllvm", "-time-passes"
                ])
            ]
        ),
        .target(
            name: "BenchmarkFunctions_cbits",
            dependencies: [
                "SwiftToPTX_cbits",
                .product(name: "CUDA", package: "swift-cuda")
            ],
            path: "Benchmarks/benchmark-functions-cbits"
        ),
        .executableTarget(
            name: "bench-saxpy",
            dependencies: [
                "Randy",
                "BenchmarkFunctions",
                .product(name: "Benchmark", package: "package-benchmark")
            ],
            path: "Benchmarks/saxpy",
            swiftSettings: [
                .unsafeFlags([
                    // "-Rpass-missed=specialize"
                ])
            ],
            plugins: [
                .plugin(name: "BenchmarkPlugin", package: "package-benchmark"),
            ]
        ),
        .executableTarget(
            name: "bench-blackscholes",
            dependencies: [
                "Randy",
                "BenchmarkFunctions",
                .product(name: "Benchmark", package: "package-benchmark")
            ],
            path: "Benchmarks/black-scholes",
            swiftSettings: [
                .unsafeFlags([
                    // "-Rpass-missed=specialize"
                ])
            ],
            plugins: [
                .plugin(name: "BenchmarkPlugin", package: "package-benchmark"),
            ]
        )
    ]
)
