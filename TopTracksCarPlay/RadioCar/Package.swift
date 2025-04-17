// swift-tools-version: 6.1

import PackageDescription

let package = Package(
    name: "RadioCar",
    platforms: [
      .iOS("18.4"),
      .macOS("15.4")],
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
