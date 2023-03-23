// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "StationUpdaters",
    platforms: [
      .macOS("13.0"),
      .iOS("16.0")],
    products: [
        .library(
            name: "StationUpdaters",
            targets: ["StationUpdaters"]),
    ],
    dependencies: [
      .package(path: "../Model"),
      .package(path: "../CoreServices/ApplicationState"),
      .package(path: "../CoreServices/PlaylistSongPreview")
    ],
    targets: [
        .target(
            name: "StationUpdaters",
            dependencies: ["Model", "ApplicationState", "PlaylistSongPreview"]),
        .testTarget(
            name: "StationUpdatersTests",
            dependencies: ["StationUpdaters"]),
    ]
)
