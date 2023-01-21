// swift-tools-version: 5.7

import PackageDescription

let package = Package(
  name: "NetworkMonitor",
  platforms: [
    .iOS("16.0"),
    .macOS("13.0")],
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
