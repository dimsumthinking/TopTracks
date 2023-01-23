// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "MusicPlayer",
    platforms: [
      .iOS("16.0"),
      .macOS("13.0")],
    products: [
        .library(
            name: "MusicPlayer",
            targets: ["MusicPlayer"]),
    ],
    targets: [
        .target(
            name: "MusicPlayer",
            dependencies: []),
        .testTarget(
            name: "MusicPlayerTests",
            dependencies: ["MusicPlayer"]),
    ]
)
