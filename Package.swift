// swift-tools-version: 5.7.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AudioKit",
    platforms: [
        .macOS(.v13)
    ],
    products: [
        .library(
            name: "AudioKit",
            targets: ["AudioKit"]),
    ],
    dependencies: [
        .package(
            url: "https://github.com/multixlr/CoreKit.git",
            branch: "main"
        )
    ],
    targets: [
        .target(
            name: "AudioKit",
            dependencies: [
                .product(name: "CoreKit", package: "CoreKit")
            ]
        ),
        .testTarget(
            name: "AudioKitTests",
            dependencies: ["AudioKit"]),
    ]
)
