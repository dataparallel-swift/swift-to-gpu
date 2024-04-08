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
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-log.git", "1.4.0" ..< "2.0.0"),
        .package(url: "https://github.com/apple/swift-nio.git", "2.42.0" ..< "3.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .systemLibrary(
            name: "CUDA",
            path: "Sources/CUDA",
            pkgConfig: "cuda-11.4"),
        .target(
            name: "SwiftToPTX",
            dependencies: [
                "CUDA",
                .product(name: "Logging", package: "swift-log"),
                .product(name: "NIOConcurrencyHelpers", package: "swift-nio"),
            ],
            path: "Sources/swift-to-ptx"),
    ]
)
