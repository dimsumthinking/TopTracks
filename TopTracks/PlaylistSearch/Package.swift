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
      .package(path: "../PlaylistCreation")
    ],
    targets: [
        .target(
            name: "PlaylistSearch",
            dependencies: ["PlaylistCreation"]),
        .testTarget(
            name: "PlaylistSearchTests",
            dependencies: ["PlaylistSearch"]),
    ]
)
