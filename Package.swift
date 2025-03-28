// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import Foundation
import PackageDescription

let libraryType: Product.Library.LibraryType? = (ProcessInfo.processInfo.environment["BUILD_STATIC_LIBRARIES"] == "true") ? .static : nil

let package = Package(
    name: "swift-to-ptx",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(name: "CUDA", type: libraryType, targets: ["CUDA"]),
        .library(name: "SwiftToPTX", type: libraryType, targets: ["SwiftToPTX"]),
        .executable(name: "nvidia-device-query", targets: ["nvidia-device-query"]),
        .executable(name: "swift-to-ptx-tests", targets: ["swift-to-ptx-tests"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-atomics.git", from: "1.2.0"),
        .package(url: "https://github.com/apple/swift-log.git", "1.4.0" ..< "2.0.0"),
        .package(url: "https://github.com/apple/swift-nio.git", "2.42.0" ..< "3.0.0"),
        .package(url: "https://github.com/apple/swift-numerics", from: "1.0.0"),
        .package(url: "https://github.com/swiftlang/swift-testing.git", revision: "6.0.3"),
        .package(url: "https://github.com/typelift/SwiftCheck.git", from: "0.8.1"),
        .package(url: "git@gitlab.com:PassiveLogic/Randy.git", from: "0.3.0"),
        .package(url: "git@gitlab.com:PassiveLogic/Experiments/swift-tracy.git", revision: "main"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .systemLibrary(
            name: "CUDA",
            pkgConfig: "cuda-12.2"
        ),
        .target(
            name: "SwiftToPTX_cbits",
            dependencies: [
                "CUDA"
            ],
            path: "Sources/swift-to-ptx-cbits"
        ),
        .target(
            name: "SwiftToPTX",
            dependencies: [
                "CUDA",
                "SwiftToPTX_cbits",
                .product(name: "Atomics", package: "swift-atomics"),
                .product(name: "Logging", package: "swift-log"),
                .product(name: "Tracy", package: "swift-tracy"),
                .product(name: "NIOConcurrencyHelpers", package: "swift-nio"),
            ],
            path: "Sources/swift-to-ptx"
        ),
        .executableTarget(
            name: "nvidia-device-query",
            dependencies: ["CUDA"]
        ),
        .executableTarget(
            name: "swift-to-ptx-tests",
            dependencies: [
                "SwiftCheck",
                "SwiftToPTX",
                .product(name: "Numerics", package: "swift-numerics"),
                .product(name: "Testing", package: "swift-testing")
            ]
        )
    ]
)
