// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "swift-cpu-backend",
    products: [
        .library(name: "CPUBackend", targets: ["CPUBackend"]),
    ],
    dependencies: [
        .package(path: "../BackendInterface"),
    ],
    targets: [
        .target(
            name: "CPUBackend",
            dependencies: [
                .product(name: "BackendInterface", package: "BackendInterface"),
            ]
        ),
    ]
)
