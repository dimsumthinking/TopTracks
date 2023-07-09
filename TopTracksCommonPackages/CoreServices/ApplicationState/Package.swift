// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "ApplicationState",
    platforms: [
      .macOS("14.0"),
      .iOS("17.0")],
    products: [
        .library(
            name: "ApplicationState",
            targets: ["ApplicationState"]),
    ],
    dependencies: [
      .package(path: "../../Model"),
      .package(path: "../Constants")
    ],
    targets: [
        .target(
            name: "ApplicationState",
            dependencies: ["Model", "Constants"]),
        .testTarget(
            name: "ApplicationStateTests",
            dependencies: ["ApplicationState"]),
    ]
)
