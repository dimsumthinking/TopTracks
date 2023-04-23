// swift-tools-version: 5.8

import PackageDescription

let package = Package(
    name: "AppleMusicSubscription",
    platforms: [
      .iOS("16.4"),
      .macOS("13.3")
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
