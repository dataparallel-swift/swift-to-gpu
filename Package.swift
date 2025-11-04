// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "swift-to-gpu",
    platforms: [.macOS("13.3")],
    products: [
        .library(name: "SwiftToGPU", targets: ["SwiftToGPU"]),
    ],
    traits: [
        "CPU",
        "PTX",
    ],
    dependencies: [
        .package(path: "Backends/BackendInterface"),
        .package(path: "Backends/PTXBackend"),
        .package(path: "Backends/CPUBackend"),
    ],
    targets: [
        .target(
            name: "SwiftToGPU",
            dependencies: [
                .product(name: "BackendInterface", package: "BackendInterface"),
                .product(name: "CPUBackend", package: "CPUBackend", condition: .when(traits: ["CPU"])),
                .product(name: "PTXBackend", package: "PTXBackend", condition: .when(traits: ["PTX"])),
            ]
        ),
    ]
)
