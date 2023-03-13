// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "CoreServices",
    platforms: [
      .macOS("13.0"),
      .iOS("16.0")],
    products: [
        .library(
            name: "CoreServices",
            targets: ["CoreServices"]),
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
            name: "CoreServices",
            dependencies: ["AppleMusicAuthorization",
                          "AppleMusicSubscription",
                          "NetworkMonitor",
                          "Constants",
                          "PlaylistSongPreview",
                          "ApplicationState"]),
        .testTarget(
            name: "CoreServicesTests",
            dependencies: ["CoreServices"]),
    ]
)
