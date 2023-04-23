// swift-tools-version: 5.8

import PackageDescription

let package = Package(
    name: "PlaylistSearchShared",
    platforms: [
      .macOS("13.3"),
      .iOS("16.4"),
      .tvOS("16.4")],
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
