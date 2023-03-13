// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "PlaylistSongPreview",
    platforms: [
      .macOS("13.0"),
      .iOS("16.0")],
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
            dependencies: ["Constants"] ),
        .testTarget(
            name: "PlaylistSongPreviewTests",
            dependencies: ["PlaylistSongPreview"]),
    ]
)
