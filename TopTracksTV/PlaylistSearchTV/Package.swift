// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "PlaylistSearchTV",
    platforms: [
      .macOS("15.0"),
      .iOS("18.0"),
      .tvOS("18.0")],
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
            dependencies: ["Model", "Constants", "ApplicationState", "PlaylistSongPreview", "PlaylistSearchShared"],
            swiftSettings: [.swiftLanguageVersion(.v6)]),
        .testTarget(
            name: "PlaylistSearchTVTests",
            dependencies: ["PlaylistSearchTV"]),
    ]
)
