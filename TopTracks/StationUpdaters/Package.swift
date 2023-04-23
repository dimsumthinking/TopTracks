// swift-tools-version: 5.8

import PackageDescription

let package = Package(
    name: "StationUpdaters",
    platforms: [
      .macOS("13.3"),
      .iOS("16.4")],
    products: [
        .library(
            name: "StationUpdaters",
            targets: ["StationUpdaters"]),
    ],
    dependencies: [
      .package(path: "../../TopTracksCommonPackages/Model"),
      .package(path: "../../TopTracksCommonPackages/CoreServices/ApplicationState"),
      .package(path: "../../TopTracksCommonPackages/CoreServices/PlaylistSongPreview")
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
