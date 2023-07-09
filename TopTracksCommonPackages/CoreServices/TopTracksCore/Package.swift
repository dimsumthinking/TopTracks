// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "TopTracksCore",
    platforms: [
      .macOS("14.0"),
      .iOS("17.0")],
    products: [
        .library(
            name: "TopTracksCore",
            targets: ["TopTracksCore"]),
    ],
    dependencies: [
      .package(path: "../AppleMusicAuthorization"),
      .package(path: "../AppleMusicSubscription"),
      .package(path: "../NetworkMonitor"),
      .package(path: "../Constants"),
      .package(path: "../PlaylistSongPreview"),
      .package(path: "../ApplicationState")
    ],
    targets: [
        .target(
            name: "TopTracksCore",
            dependencies: ["AppleMusicAuthorization",
                          "AppleMusicSubscription",
                          "NetworkMonitor",
                          "Constants",
                          "PlaylistSongPreview",
                          "ApplicationState"]),
        .testTarget(
            name: "TopTracksCoreTests",
            dependencies: ["TopTracksCore"]),
    ]
)
