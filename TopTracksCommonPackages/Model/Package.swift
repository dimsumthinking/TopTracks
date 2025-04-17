// swift-tools-version: 6.1

import PackageDescription

let package = Package(
    name: "Model",
    platforms: [
      .macOS("15.4"),
      .iOS("18.4"),
      .tvOS("18.4")],
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
