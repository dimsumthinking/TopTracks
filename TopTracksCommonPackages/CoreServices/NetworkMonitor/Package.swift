// swift-tools-version: 5.9

import PackageDescription

let package = Package(
  name: "NetworkMonitor",
  platforms: [
    .iOS("17.0"),
    .macOS("14.0")],
  products: [
    .library(
      name: "NetworkMonitor",
      targets: ["NetworkMonitor"]),
  ],
  targets: [
    .target(
      name: "NetworkMonitor",
      dependencies: []),
    .testTarget(
      name: "NetworkMonitorTests",
      dependencies: ["NetworkMonitor"]),
  ]
)
