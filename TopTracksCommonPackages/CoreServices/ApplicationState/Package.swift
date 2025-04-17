// swift-tools-version: 6.1

import PackageDescription

let package = Package(
    name: "ApplicationState",
    platforms: [
      .macOS("15.4"),
      .iOS("18.4"),
      .tvOS("18.4")],
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
