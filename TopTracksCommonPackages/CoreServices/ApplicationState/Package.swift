// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "ApplicationState",
    platforms: [
      .macOS("26"),
      .iOS("26"),
      .tvOS("26")],
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
