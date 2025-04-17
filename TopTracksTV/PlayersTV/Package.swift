// swift-tools-version: 6.1

import PackageDescription

let package = Package(
    name: "PlayersTV",
    platforms: [
      .macOS("15.4"),
      .iOS("18.4"),
      .tvOS("18.4")],
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
            dependencies: ["Model", "ApplicationState", "Constants"]),
        .testTarget(
            name: "PlayersTVTests",
            dependencies: ["PlayersTV"]),
    ]
)
