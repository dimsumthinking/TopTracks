// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "Radio",
    platforms: [
      .macOS("13.0"),
      .iOS("16.0")],
    products: [
        .library(
            name: "Radio",
            targets: ["Radio"]),
    ],
    dependencies: [
      .package(path: "../Model"),
      .package(path: "../CoreServices/ApplicationState"),
      .package(path: "../CoreServices/Constants")
    ],
    targets: [
        .target(
            name: "Radio",
            dependencies: ["Model", "ApplicationState", "Constants"]),
        .testTarget(
            name: "RadioTests",
            dependencies: ["Radio"]),
    ]
)
