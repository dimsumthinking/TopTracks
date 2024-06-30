// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "Model",
    platforms: [
      .macOS("14.0"),
      .iOS("17.0"),
      .tvOS("17.0")],
    products: [
        .library(
            name: "Model",
            targets: ["Model"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "Model",
            dependencies: [],
            swiftSettings: [.swiftLanguageVersion(.v6)]),
        .testTarget(
            name: "ModelTests",
            dependencies: ["Model"]),
    ]
)
