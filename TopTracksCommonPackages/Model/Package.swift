// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "Model",
    platforms: [
      .macOS("26"),
      .iOS("26"),
      .tvOS("26")],
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
