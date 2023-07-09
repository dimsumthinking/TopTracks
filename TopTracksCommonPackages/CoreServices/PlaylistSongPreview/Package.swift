// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "PlaylistSongPreview",
    platforms: [
      .macOS("14.0"),
      .iOS("17.0")],
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
