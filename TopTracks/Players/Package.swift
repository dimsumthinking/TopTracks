// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "Players",
    platforms: [
      .macOS("26"),
      .iOS("26")],
    products: [
        .library(
            name: "Players",
            targets: ["Players"]),
    ],
    dependencies: [
      .package(path: "../../TopTracksCommonPackages/Model"),
      .package(path: "../../TopTracksCommonPackages/CoreServices/ApplicationState"),
      .package(path: "../../TopTracksCommonPackages/CoreServices/Constants")
    ],
    targets: [
        .target(
            name: "Players",
            dependencies: ["Model", "ApplicationState", "Constants"]),
        .testTarget(
            name: "PlayersTests",
            dependencies: ["Players"]),
    ]
)
