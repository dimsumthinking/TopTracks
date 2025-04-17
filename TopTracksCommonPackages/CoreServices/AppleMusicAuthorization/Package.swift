// swift-tools-version: 6.1

import PackageDescription

let package = Package(
    name: "AppleMusicAuthorization",
    platforms: [
      .iOS("18.4"),
      .macOS("15.4")
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
            dependencies: [] ),
        .testTarget(
            name: "AppleMusicAuthorizationTests",
            dependencies: ["AppleMusicAuthorization"]),
    ]
)
