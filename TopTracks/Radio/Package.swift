// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "Radio",
    platforms: [
      .macOS("14.0"),
      .iOS("17.0")],
    products: [
        .library(
            name: "Radio",
            targets: ["Radio"]),
    ],
    dependencies: [
      .package(path: "../../TopTracksCommonPackages/Model"),
      .package(path: "../../TopTracksCommonPackages/CoreServices/ApplicationState"),
      .package(path: "../../TopTracksCommonPackages/CoreServices/Constants")
    ],
    targets: [
        .target(
            name: "Radio",
            dependencies: ["Model", "ApplicationState", "Constants"]),
        .testTarget(
            name: "RadioTests",
            dependencies: ["Radio"]),
    ]
)
