// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import Foundation
import PackageDescription

let enableTracy = ProcessInfo.processInfo.environment["SWIFT_TRACY_ENABLE"].isSet

var cSettings: [CSetting] = [
    .define("PTX", .when(traits: ["PTX"])),
]

if enableTracy {
    cSettings += [
        .define("TRACY_ENABLE"),
        .define("TRACY_DELAYED_INIT"),
        .define("TRACY_MANUAL_LIFETIME"),
    ]
}

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
        .package(url: "https://github.com/apple/swift-atomics.git", from: "1.2.0"),
        .package(url: "https://github.com/apple/swift-log.git", "1.6.3" ..< "2.0.0"),
        .package(url: "https://github.com/apple/swift-nio.git", "2.42.0" ..< "3.0.0"),
        .package(url: "https://github.com/apple/swift-numerics", from: "1.0.0"),
        .package(url: "https://github.com/dataparallel-swift/swift-cuda.git", from: "1.0.0"),
        .package(url: "https://github.com/dataparallel-swift/swift-mimalloc.git", revision: "1.0.0", traits: ["CUDA"]),
        .package(url: "https://github.com/dataparallel-swift/swift-tracy.git", revision: "1.0.0"),
        .package(url: "https://github.com/typelift/SwiftCheck.git", from: "0.8.1"),
    ],
    targets: [
        .target(
            name: "SwiftToGPU",
            dependencies: [
                "BackendInterface",
                .target(name: "CPUBackend", condition: .when(traits: ["CPU"])),
                .target(name: "PTXBackend", condition: .when(traits: ["PTX"])),
                .product(name: "Atomics", package: "swift-atomics"),
            ]
        ),
        .target(
            name: "BackendInterface",
            path: "Sources/Backend/Interface"
        ),

        // CPU Backend
        .target(
            name: "CPUBackend",
            dependencies: [
                .target(name: "BackendInterface", condition: .when(traits: ["CPU"])),
            ],
            path: "Sources/Backend/CPU"
        ),

        // NVIDIA GPU Backend
        .target(
            name: "PTXBackendC",
            dependencies: [
                .product(name: "TracyC", package: "swift-tracy", condition: .when(traits: ["PTX"])),
                .product(name: "swift-mimalloc", package: "swift-mimalloc", condition: .when(traits: ["PTX"])),
            ],
            path: "Sources/Backend/PTX/C",
            publicHeadersPath: ".",
            cSettings: cSettings
        ),
        .target(
            name: "PTXBackend",
            dependencies: [
                .target(name: "BackendInterface", condition: .when(traits: ["PTX"])),
                .target(name: "PTXBackendC", condition: .when(traits: ["PTX"])),
                .product(name: "CUDA", package: "swift-cuda", condition: .when(traits: ["PTX"])),
                .product(name: "Logging", package: "swift-log", condition: .when(traits: ["PTX"])),
                .product(name: "Tracy", package: "swift-tracy", condition: .when(traits: ["PTX"])),
                .product(name: "NIOConcurrencyHelpers", package: "swift-nio", condition: .when(traits: ["PTX"])),
            ],
            path: "Sources/Backend/PTX/Swift",
            swiftSettings: [.swiftLanguageMode(.v5)]
        ),

        // Test suite
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

private extension String? {
    var isSet: Bool {
        if let value = self {
            return value.isEmpty || value == "1" || value.lowercased() == "true"
        }
        return false
    }
}
