// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "PlayersTV",
    platforms: [
      .macOS("26"),
      .iOS("26"),
      .tvOS("26")],
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
