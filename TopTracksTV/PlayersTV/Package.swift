// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "PlayersTV",
    platforms: [
      .macOS("15.0"),
      .iOS("18.0"),
      .tvOS("18.0")],
    products: [
        .library(
            name: "PlayersTV",
            targets: ["PlayersTV"]),
    ],
    dependencies: [
      .package(path: "../../TopTracksCommonPackages/Model"),
      .package(path: "../../TopTracksCommonPackages/CoreServices/ApplicationState"),
      .package(path: "../../TopTracksCommonPackages/CoreServices/Constants")
    ],
    targets: [
        .target(
            name: "PlayersTV",
            dependencies: ["Model", "ApplicationState", "Constants"],
            swiftSettings: [.swiftLanguageVersion(.v6)]),
        .testTarget(
            name: "PlayersTVTests",
            dependencies: ["PlayersTV"]),
    ]
)
