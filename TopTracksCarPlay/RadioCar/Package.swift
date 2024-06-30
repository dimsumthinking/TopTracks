// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "RadioCar",
    platforms: [
      .iOS("18.0"),
      .macOS("15.0")],
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
        dependencies: ["Model", "ApplicationState"],
            swiftSettings: [.swiftLanguageVersion(.v6)]),
        .testTarget(
            name: "RadioCarTests",
            dependencies: ["RadioCar"]),
    ]
)
