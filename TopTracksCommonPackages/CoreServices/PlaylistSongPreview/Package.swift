// swift-tools-version: 5.8

import PackageDescription

let package = Package(
    name: "PlaylistSongPreview",
    platforms: [
      .macOS("13.3"),
      .iOS("16.4")],
    products: [
        .library(
            name: "PlaylistSongPreview",
            targets: ["PlaylistSongPreview"]),
    ],
    dependencies: [
      .package(path: "../Constants")
    ],
    targets: [
        .target(
            name: "PlaylistSongPreview",
        dependencies: ["Constants"]),
        .testTarget(
            name: "PlaylistSongPreviewTests",
            dependencies: ["PlaylistSongPreview"]),
    ]
)
