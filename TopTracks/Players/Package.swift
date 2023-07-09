// swift-tools-version: 5.8

import PackageDescription

let package = Package(
    name: "Players",
    platforms: [
      .macOS("14.0"),
      .iOS("17.0")],
    products: [
        .library(
            name: "Players",
            targets: ["Players"]),
    ],
    dependencies: [
      .package(path: "../../TopTracksCommonPackages/Model"),
      .package(path: "../../TopTracksCommonPackages/CoreServices/ApplicationState"),
      .package(path: "../../TopTracksCommonPackages/CoreServices/Constants"),
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
