// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import Foundation
import PackageDescription

let libraryType = ProcessInfo.processInfo.environment["BUILD_STATIC_LIBRARIES"].isSet ? Product.Library.LibraryType.static : nil
let enableTracy = ProcessInfo.processInfo.environment["SWIFT_TRACY_ENABLE"].isSet

var cSettings: [CSetting] = []

if enableTracy {
    cSettings += [
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
        .package(path: "../BackendInterface"),
        .package(url: "https://github.com/apple/swift-log.git", "1.6.3" ..< "2.0.0"),
        .package(url: "https://github.com/apple/swift-nio.git", "2.42.0" ..< "3.0.0"),
        .package(url: "https://github.com/typelift/SwiftCheck.git", from: "0.8.1"),
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
            cSettings: cSettings
        ),
        .target(
            name: "PTXBackend",
            dependencies: [
                "PTXBackendC",
                .product(name: "BackendInterface", package: "BackendInterface"),
                .product(name: "CUDA", package: "swift-cuda"),
                .product(name: "Logging", package: "swift-log"),
                .product(name: "Tracy", package: "swift-tracy"),
                .product(name: "NIOConcurrencyHelpers", package: "swift-nio"),
            ],
            swiftSettings: [.swiftLanguageMode(.v5)]
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
