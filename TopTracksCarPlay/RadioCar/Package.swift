// swift-tools-version: 5.8

import PackageDescription

let package = Package(
    name: "RadioCar",
    platforms: [
      .iOS("16.4"),
      .macOS("13.3")],
    products: [
        .library(
            name: "RadioCar",
            targets: ["RadioCar"]),
    ],
    targets: [
        .target(
            name: "RadioCar"),
        .testTarget(
            name: "RadioCarTests",
            dependencies: ["RadioCar"]),
    ]
)
