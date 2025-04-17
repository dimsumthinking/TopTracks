// swift-tools-version: 6.1

import PackageDescription

let package = Package(
    name: "TopTracksCore",
    platforms: [
      .macOS("15.4"),
      .iOS("18.4"),
      .tvOS("18.4")],
    products: [
        .library(
            name: "TopTracksCore",
            targets: ["TopTracksCore"]),
    ],
    dependencies: [
      .package(path: "../AppleMusicAuthorization"),
      .package(path: "../AppleMusicSubscription"),
      .package(path: "../Constants"),
      .package(path: "../PlaylistSongPreview"),
      .package(path: "../ApplicationState")
    ],
    targets: [
        .target(
            name: "TopTracksCore",
            dependencies: ["AppleMusicAuthorization",
                          "AppleMusicSubscription",
                          "Constants",
                          "PlaylistSongPreview",
                          "ApplicationState"]),
        .testTarget(
            name: "TopTracksCoreTests",
            dependencies: ["TopTracksCore"]),
    ]
)
