// swift-tools-version: 6.1

import PackageDescription

let package = Package(
    name: "PlaylistSongPreview",
    platforms: [
      .macOS("15.4"),
      .iOS("18.4")],
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
