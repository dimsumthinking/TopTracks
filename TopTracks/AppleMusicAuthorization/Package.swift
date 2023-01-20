// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "AppleMusicAuthorization",
    platforms: [
      .iOS("16.0"),
      .macOS("13.0")
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
            dependencies: []),
        .testTarget(
            name: "AppleMusicAuthorizationTests",
            dependencies: ["AppleMusicAuthorization"]),
    ]
)
