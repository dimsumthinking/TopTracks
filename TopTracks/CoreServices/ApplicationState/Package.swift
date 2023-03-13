// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "ApplicationState",
    platforms: [
      .macOS("13.0"),
      .iOS("16.0")],
    products: [
        .library(
            name: "ApplicationState",
            targets: ["ApplicationState"]),
    ],
    dependencies: [
      .package(path: "../../Model")
    ],
    targets: [
        .target(
            name: "ApplicationState",
            dependencies: ["Model"]),
        .testTarget(
            name: "ApplicationStateTests",
            dependencies: ["ApplicationState"]),
    ]
)
