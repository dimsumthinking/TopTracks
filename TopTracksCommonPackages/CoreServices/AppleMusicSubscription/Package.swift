// swift-tools-version: 6.1

import PackageDescription

let package = Package(
    name: "AppleMusicSubscription",
    platforms: [
      .iOS("18.4"),
      .macOS("15.4")
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
