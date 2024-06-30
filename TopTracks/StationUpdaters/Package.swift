// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "StationUpdaters",
    platforms: [
      .macOS("15.0"),
      .iOS("18.0")],
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
            dependencies: ["Model", "ApplicationState", "PlaylistSongPreview"],
            swiftSettings: [.swiftLanguageVersion(.v6)]),
        .testTarget(
            name: "StationUpdatersTests",
            dependencies: ["StationUpdaters"]),
    ]
)
