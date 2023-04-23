// swift-tools-version: 5.8

import PackageDescription

let package = Package(
    name: "Model",
    platforms: [
      .macOS("13.3"),
      .iOS("16.4"),
      .tvOS("16.4")],
    products: [
        .library(
            name: "Model",
            targets: ["Model"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "Model",
            dependencies: [],
            resources: [.copy("Persistence/Stations.xcdatamodeld")]),
        .testTarget(
            name: "ModelTests",
            dependencies: ["Model"]),
    ]
)
