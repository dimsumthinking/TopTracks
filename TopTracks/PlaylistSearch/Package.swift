// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "PlaylistSearch",
    platforms: [
      .macOS("13.0"),
      .iOS("16.0")],
    products: [
        .library(
            name: "PlaylistSearch",
            targets: ["PlaylistSearch"]),
    ],
    dependencies: [
      .package(path: "../Model"),
      .package(path: "../CoreServices/Constants"),
      .package(path: "../CoreServices/ApplicationState"),
      .package(path: "../CoreServices/PlaylistSongPreview")
    ],
    targets: [
        .target(
            name: "PlaylistSearch",
            dependencies: ["Model", "Constants", "ApplicationState", "PlaylistSongPreview"]),
        .testTarget(
            name: "PlaylistSearchTests",
            dependencies: ["PlaylistSearch"]),
    ]
)
