// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "Players",
    platforms: [
      .macOS("15.0"),
      .iOS("18.0")],
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
            dependencies: ["Model", "ApplicationState", "Constants"],
            swiftSettings: [.swiftLanguageVersion(.v6)]),
        .testTarget(
            name: "PlayersTests",
            dependencies: ["Players"]),
    ]
)
