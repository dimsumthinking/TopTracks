// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "Model",
    platforms: [
      .macOS("15.0"),
      .iOS("18.0"),
      .tvOS("18.0")],
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
