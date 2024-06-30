// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "AppleMusicAuthorization",
    platforms: [
      .iOS("18.0"),
      .macOS("15.0")
    ],
    products: [
        .library(
            name: "AppleMusicAuthorization",
            targets: ["AppleMusicAuthorization"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "AppleMusicAuthorization",
            dependencies: [],
            swiftSettings: [.swiftLanguageVersion(.v6)] ),
        .testTarget(
            name: "AppleMusicAuthorizationTests",
            dependencies: ["AppleMusicAuthorization"]),
    ]
)
