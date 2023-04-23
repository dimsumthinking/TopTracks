// swift-tools-version: 5.8

import PackageDescription

let package = Package(
    name: "AppleMusicAuthorization",
    platforms: [
      .iOS("16.4"),
      .macOS("13.3")
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
