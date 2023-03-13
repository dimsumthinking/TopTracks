// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "Constants",
    platforms: [
      .macOS("13.0"),
      .iOS("16.0")],
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
