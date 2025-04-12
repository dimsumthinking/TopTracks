// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "PlaylistSongPreview",
    platforms: [
      .macOS("15.0"),
      .iOS("18.0")],
    products: [
        .library(
            name: "PlaylistSongPreview",
            targets: ["PlaylistSongPreview"]),
    ],
    dependencies: [
      .package(path: "../Constants"),
      .package(path: "../ApplicationState"),
      .package(path: "../../Model")
    ],
    targets: [
        .target(
            name: "PlaylistSongPreview",
        dependencies: ["Constants", "ApplicationState", "Model"]),
        .testTarget(
            name: "PlaylistSongPreviewTests",
            dependencies: ["PlaylistSongPreview"]),
    ]
)
