// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "ApplicationState",
    platforms: [
      .macOS("15.0"),
      .iOS("18.0"),
      .tvOS("18.0")],
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
            dependencies: ["Model", "Constants"],
            swiftSettings: [.swiftLanguageVersion(.v6)]),
        .testTarget(
            name: "ApplicationStateTests",
            dependencies: ["ApplicationState"]),
    ]
)
