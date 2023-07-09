// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "StationUpdaters",
    platforms: [
      .macOS("14.0"),
      .iOS("17.0")],
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
