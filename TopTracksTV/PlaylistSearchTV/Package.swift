// swift-tools-version: 5.8

import PackageDescription

let package = Package(
    name: "PlaylistSearchTV",
    platforms: [
      .macOS("13.3"),
      .iOS("16.4")],
    products: [
        .library(
            name: "PlaylistSearchTV",
            targets: ["PlaylistSearchTV"]),
    ],
    dependencies: [
      .package(path: "../../TopTracksCommonPackages/PlaylistSearchShared"),
      .package(path: "../../TopTracksCommonPackages/Model"),
      .package(path: "../../TopTracksCommonPackages/CoreServices/Constants"),
      .package(path: "../../TopTracksCommonPackages/CoreServices/ApplicationState"),
      .package(path: "../../TopTracksCommonPackages/CoreServices/PlaylistSongPreview")
    ],
    targets: [
        .target(
            name: "PlaylistSearchTV",
            dependencies: ["Model", "Constants", "ApplicationState", "PlaylistSongPreview", "PlaylistSearchShared"]),
        .testTarget(
            name: "PlaylistSearchTVTests",
            dependencies: ["PlaylistSearchTV"]),
    ]
)
