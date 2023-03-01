// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "Model",
    platforms: [
      .macOS("13.0"),
      .iOS("16.0")],
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
            dependencies: []),
        .testTarget(
            name: "ModelTests",
            dependencies: ["Model"]),
    ]
)
