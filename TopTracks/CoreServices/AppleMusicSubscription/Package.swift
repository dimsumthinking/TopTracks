// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "AppleMusicSubscription",
    platforms: [
      .iOS("16.0"),
      .macOS("13.0")
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
