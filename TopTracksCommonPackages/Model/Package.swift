// swift-tools-version: 5.9

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
            dependencies: []),
        .testTarget(
            name: "ModelTests",
            dependencies: ["Model"]),
    ]
)
