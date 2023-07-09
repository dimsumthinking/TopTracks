// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "AppleMusicAuthorization",
    platforms: [
      .iOS("17.0"),
      .macOS("14.0")
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
