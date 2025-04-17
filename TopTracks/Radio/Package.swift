// swift-tools-version: 6.1

import PackageDescription

let package = Package(
    name: "Radio",
    platforms: [
      .macOS("15.4"),
      .iOS("18.4")],
    products: [
        .library(
            name: "Radio",
            targets: ["Radio"]),
    ],
    dependencies: [
      .package(path: "../../TopTracksCommonPackages/Model"),
      .package(path: "../../TopTracksCommonPackages/CoreServices/ApplicationState"),
      .package(path: "../../TopTracksCommonPackages/CoreServices/Constants"),
    ],
    targets: [
        .target(
            name: "Radio",
            dependencies: ["Model", "ApplicationState", "Constants" ]),
        .testTarget(
            name: "RadioTests",
            dependencies: ["Radio"]),
    ]
)
