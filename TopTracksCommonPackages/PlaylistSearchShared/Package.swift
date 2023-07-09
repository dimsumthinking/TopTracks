// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "PlaylistSearchShared",
    platforms: [
      .macOS("14.0"),
      .iOS("17.0"),
      .tvOS("17.0")],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "PlaylistSearchShared",
            targets: ["PlaylistSearchShared"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "PlaylistSearchShared"),
        .testTarget(
            name: "PlaylistSearchSharedTests",
            dependencies: ["PlaylistSearchShared"]),
    ]
)
