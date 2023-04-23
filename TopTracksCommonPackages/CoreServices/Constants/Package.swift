// swift-tools-version: 5.8

import PackageDescription

let package = Package(
    name: "Constants",
    platforms: [
      .macOS("13.3"),
      .iOS("16.4")],
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
