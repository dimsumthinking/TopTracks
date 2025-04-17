// swift-tools-version: 6.1

import PackageDescription

let package = Package(
    name: "RadioTV",
    platforms: [
      .macOS("15.4"),
      .iOS("18.4"),
      .tvOS("18.4")],
    products: [
        .library(
            name: "RadioTV",
            targets: ["RadioTV"]),
    ],
    dependencies: [
      .package(path: "../../TopTracksCommonPackages/Model"),
      .package(path: "../../TopTracksCommonPackages/CoreServices/ApplicationState"),
      .package(path: "../../TopTracksCommonPackages/CoreServices/Constants"),
      .package(path: "../PlayersTV")
    ],
    targets: [
        .target(
            name: "RadioTV",
            dependencies: ["Model", "ApplicationState", "Constants",  "PlayersTV"]),
        .testTarget(
            name: "RadioTVTests",
            dependencies: ["RadioTV"]),
    ]
)
