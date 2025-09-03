// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "RadioCar",
    platforms: [
      .iOS("26"),
      .macOS("26")],
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
