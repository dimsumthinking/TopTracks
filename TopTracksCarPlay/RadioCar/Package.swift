// swift-tools-version: 5.8

import PackageDescription

let package = Package(
    name: "RadioCar",
    platforms: [
      .iOS("17.0"),
      .macOS("14.0")],
    products: [
        .library(
            name: "RadioCar",
            targets: ["RadioCar"]),
    ],
    dependencies: [
      .package(path: "../../TopTracksCommonPackages/Model"),
      .package(path: "../../TopTracksCommonPackages/CoreServices/ApplicationState")
    ],
    targets: [
        .target(
            name: "RadioCar",
        dependencies: ["Model", "ApplicationState"]),
        .testTarget(
            name: "RadioCarTests",
            dependencies: ["RadioCar"]),
    ]
)
