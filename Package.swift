// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "swift-to-gpu",
    platforms: [.macOS(.v10_15)],
    products: [
        .library(name: "SwiftToGPU", targets: ["SwiftToGPU"]),
    ],
    traits: [
        "PTX",
    ],
    dependencies: [
        .package(path: "Backends/PTXBackend"),
    ],
    targets: [
        .target(
            name: "SwiftToGPU",
            dependencies: [
                .product(name: "PTXBackend", package: "PTXBackend", condition: .when(traits: ["PTX"])),
            ]
        ),
    ]
)
