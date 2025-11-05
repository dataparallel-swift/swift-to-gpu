// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "swift-to-gpu",
    platforms: [.macOS("15")],
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
        .package(url: "https://github.com/apple/swift-atomics.git", from: "1.2.0"),
        .package(url: "https://github.com/apple/swift-numerics", from: "1.0.0"),
        .package(url: "https://github.com/typelift/SwiftCheck.git", from: "0.8.1"),
    ],
    targets: [
        .target(
            name: "SwiftToGPU",
            dependencies: [
                .product(name: "BackendInterface", package: "BackendInterface"),
                .product(name: "CPUBackend", package: "CPUBackend", condition: .when(traits: ["CPU"])),
                .product(name: "PTXBackend", package: "PTXBackend", condition: .when(traits: ["PTX"])),
                .product(name: "Atomics", package: "swift-atomics"),
            ]
        ),
        .testTarget(
            name: "SwiftToGPUTests",
            dependencies: [
                "SwiftToGPU",
                .product(name: "Numerics", package: "swift-numerics"),
                .product(name: "SwiftCheck", package: "SwiftCheck"),

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
                ], .when(traits: ["PTX"])),
            ]
        ),
    ]
)
