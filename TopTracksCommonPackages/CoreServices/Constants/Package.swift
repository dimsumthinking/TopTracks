// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "Constants",
    platforms: [
      .macOS("26"),
      .iOS("26"),
      .tvOS("26")],
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
