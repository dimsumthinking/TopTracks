// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "RadioTV",
    platforms: [
      .macOS("26"),
      .iOS("26"),
      .tvOS("26")],
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
