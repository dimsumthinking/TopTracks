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
      .package(path: "../Constants")
    ],
    targets: [
        .target(
            name: "PlaylistSearch",
            dependencies: ["Constants"]),
        .testTarget(
            name: "PlaylistSearchTests",
            dependencies: ["PlaylistSearch"]),
    ]
)
