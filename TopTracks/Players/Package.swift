// swift-tools-version: 5.8

import PackageDescription

let package = Package(
    name: "Players",
    platforms: [
      .macOS("13.0"),
      .iOS("16.0")],
    products: [
        .library(
            name: "Players",
            targets: ["Players"]),
    ],
    dependencies: [
      .package(path: "../Model"),
      .package(path: "../CoreServices/ApplicationState"),
      .package(path: "../CoreServices/Constants"),
      .package(path: "../StationUpdaters")
    ],
    targets: [
        .target(
            name: "Players",
            dependencies: ["Model", "ApplicationState", "Constants", "StationUpdaters"]),
        .testTarget(
            name: "PlayersTests",
            dependencies: ["Players"]),
    ]
)
