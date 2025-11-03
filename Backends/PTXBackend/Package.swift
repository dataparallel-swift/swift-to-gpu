// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import Foundation
import PackageDescription

let libraryType     = ProcessInfo.processInfo.environment["BUILD_STATIC_LIBRARIES"].isSet ? Product.Library.LibraryType.static : nil
let disableJemalloc = ProcessInfo.processInfo.environment["BENCHMARK_DISABLE_JEMALLOC"].isSet
let enableTracy     = ProcessInfo.processInfo.environment["SWIFT_TRACY_ENABLE"].isSet

if !disableJemalloc {
    // swiftlint:disable:next logger_over_print
    print("Set BENCHMARK_DISABLE_JEMALLOC=true to get accurate data from package-benchmark!")
}

var _cSettings: [CSetting] = []

if enableTracy {
    _cSettings += [
        .define("TRACY_ENABLE"),
        .define("TRACY_DELAYED_INIT"),
        .define("TRACY_MANUAL_LIFETIME"),
    ]
}

let package = Package(
    name: "swift-ptx-backend",
    platforms: [.macOS("13.3")],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(name: "PTXBackend", type: libraryType, targets: ["PTXBackend"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-atomics.git", from: "1.2.0"),
        .package(url: "https://github.com/apple/swift-log.git", "1.6.3" ..< "2.0.0"),
        .package(url: "https://github.com/apple/swift-nio.git", "2.42.0" ..< "3.0.0"),
        .package(url: "https://github.com/apple/swift-numerics", from: "1.0.0"),
        .package(url: "https://github.com/typelift/SwiftCheck.git", from: "0.8.1"),
        .package(url: "https://github.com/ordo-one/package-benchmark", .upToNextMajor(from: "1.4.0")),
        .package(url: "git@gitlab.com:PassiveLogic/Randy.git", from: "0.7.0"),
        .package(url: "git@gitlab.com:PassiveLogic/compiler/swift-cuda.git", from: "0.2.0"),
        .package(url: "git@gitlab.com:PassiveLogic/compiler/swift-tracy.git", revision: "60ac56c594ee"),
        .package(url: "git@gitlab.com:PassiveLogic/compiler/swift-mimalloc.git", revision: "0.1"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "PTXBackendC",
            dependencies: [
                .product(name: "TracyC", package: "swift-tracy"),
                .product(name: "swift-mimalloc", package: "swift-mimalloc"),
            ],
            publicHeadersPath: ".",
            cSettings: _cSettings
        ),
        .target(
            name: "PTXBackend",
            dependencies: [
                "PTXBackendC",
                .product(name: "CUDA", package: "swift-cuda"),
                .product(name: "Atomics", package: "swift-atomics"),
                .product(name: "Logging", package: "swift-log"),
                .product(name: "Tracy", package: "swift-tracy"),
                .product(name: "NIOConcurrencyHelpers", package: "swift-nio"),
            ]
        ),

        // Tests
        .testTarget(
            name: "PTXBackendTests",
            dependencies: [
                "SwiftCheck",
                "PTXBackend",
                .product(name: "Numerics", package: "swift-numerics"),
            ],
            exclude: [
                "Imaginary/README.md",
                "Issues/README.md",
                "Language/README.md",
                "Prelude/README.md",
                "Real/README.md",
                "Spectral/README.md",
            ],
            swiftSettings: [
                .unsafeFlags([
                    "-O",
                    "-Xllvm", "--swift-to-ptx-verbose",
                    // Disable unsafe floating point optimisations which may
                    // give different numerical results in tests
                    "-Xllvm", "--swift-to-ptx-allow-fp-arcp=false",
                    "-Xllvm", "--swift-to-ptx-allow-fp-contract=false",
                    "-Xllvm", "--swift-to-ptx-allow-fp-afn=false",
                    "-Xllvm", "--swift-to-ptx-allow-fp-reassoc=false",
                    // "-num-threads", "1",
                    // "-Xllvm", "-time-passes"     // https://app.clickup.com/t/86b4gq4x2
                    // "-Ounchecked",               // https://app.clickup.com/t/86b4gq63t
                ]),
            ]
        ),

        // Benchmarks
        .target(
            name: "BenchmarkFunctions",
            dependencies: [
                "PTXBackend",
                "BenchmarkFunctionsC",
                .product(name: "Numerics", package: "swift-numerics"),
            ],
            path: "Benchmarks/BenchmarkFunctions",
            swiftSettings: [
                .unsafeFlags([
                    "-O",
                    "-num-threads", "1",
                    "-Xllvm", "--swift-to-ptx-verbose",
                    "-Xllvm", "-time-passes",
                ]),
            ]
        ),
        .target(
            name: "BenchmarkFunctionsC",
            dependencies: [
                "PTXBackendC",
                .product(name: "CUDA", package: "swift-cuda"),
            ],
            path: "Benchmarks/BenchmarkFunctionsC"
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

private extension String? {
  var isSet: Bool {
    if let value = self {
      return value.isEmpty || value == "1" || value.lowercased() == "true"
    }
    return false
  }
}
