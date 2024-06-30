// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "RadioTV",
    platforms: [
      .macOS("15.0"),
      .iOS("18.0"),
      .tvOS("18.0")],
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
            dependencies: ["Model", "ApplicationState", "Constants",  "PlayersTV"],
            swiftSettings: [.swiftLanguageVersion(.v6)]),
        .testTarget(
            name: "RadioTVTests",
            dependencies: ["RadioTV"]),
    ]
)
