// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "RadioTV",
    platforms: [
      .macOS("14.0"),
      .iOS("17.0")],
    products: [
        .library(
            name: "RadioTV",
            targets: ["RadioTV"]),
    ],
    dependencies: [
      .package(path: "../../TopTracksCommonPackages/Model"),
      .package(path: "../../TopTracksCommonPackages/CoreServices/ApplicationState"),
      .package(path: "../../TopTracksCommonPackages/CoreServices/Constants"),
      .package(path: "../../TopTracks/StationUpdaters"),
      .package(path: "../PlayersTV")
    ],
    targets: [
        .target(
            name: "RadioTV",
            dependencies: ["Model", "ApplicationState", "Constants", "StationUpdaters", "PlayersTV"]),
        .testTarget(
            name: "RadioTVTests",
            dependencies: ["RadioTV"]),
    ]
)
