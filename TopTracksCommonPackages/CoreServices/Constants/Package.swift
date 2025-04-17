// swift-tools-version: 6.1

import PackageDescription

let package = Package(
    name: "Constants",
    platforms: [
      .macOS("15.4"),
      .iOS("18.4"),
      .tvOS("18.4")],
    products: [
        .library(
            name: "Constants",
            targets: ["Constants"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "Constants",
            dependencies: []),
        .testTarget(
            name: "ConstantsTests",
            dependencies: ["Constants"]),
    ]
)
