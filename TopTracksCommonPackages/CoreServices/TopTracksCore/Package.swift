// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "TopTracksCore",
    platforms: [
      .macOS("15.0"),
      .iOS("18.0")],
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
                          "ApplicationState"],
            swiftSettings: [.swiftLanguageVersion(.v6)]),
        .testTarget(
            name: "TopTracksCoreTests",
            dependencies: ["TopTracksCore"]),
    ]
)
