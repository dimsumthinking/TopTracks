// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "Constants",
    platforms: [
      .macOS("15.0"),
      .iOS("18.0"),
      .tvOS("18.0")],
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
            dependencies: [],
            swiftSettings: [.swiftLanguageVersion(.v6)]),
        .testTarget(
            name: "ConstantsTests",
            dependencies: ["Constants"]),
    ]
)
