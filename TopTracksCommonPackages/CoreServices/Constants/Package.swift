// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "Constants",
    platforms: [
      .macOS("14.0"),
      .iOS("17.0")],
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
