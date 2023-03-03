// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "PlaylistCreation",
    platforms: [
      .macOS("13.0"),
      .iOS("16.0")],
    products: [
        .library(
            name: "PlaylistCreation",
            targets: ["PlaylistCreation"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "PlaylistCreation",
            dependencies: []),
        .testTarget(
            name: "PlaylistCreationTests",
            dependencies: ["PlaylistCreation"]),
    ]
)
