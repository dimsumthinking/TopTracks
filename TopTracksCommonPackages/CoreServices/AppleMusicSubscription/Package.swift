// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "AppleMusicSubscription",
    platforms: [
      .iOS("18.0"),
      .macOS("15.0")
    ],
    products: [
        .library(
            name: "AppleMusicSubscription",
            targets: ["AppleMusicSubscription"]),
    ],
    targets: [
        .target(
            name: "AppleMusicSubscription",
            dependencies: [],
            swiftSettings: [.swiftLanguageVersion(.v6)]),
        .testTarget(
            name: "AppleMusicSubscriptionTests",
            dependencies: ["AppleMusicSubscription"]),
    ]
)
