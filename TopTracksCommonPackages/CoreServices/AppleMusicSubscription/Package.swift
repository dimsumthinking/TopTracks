// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "AppleMusicSubscription",
    platforms: [
      .iOS("17.0"),
      .macOS("14.0")
    ],
    products: [
        .library(
            name: "AppleMusicSubscription",
            targets: ["AppleMusicSubscription"]),
    ],
    targets: [
        .target(
            name: "AppleMusicSubscription",
            dependencies: []),
        .testTarget(
            name: "AppleMusicSubscriptionTests",
            dependencies: ["AppleMusicSubscription"]),
    ]
)
