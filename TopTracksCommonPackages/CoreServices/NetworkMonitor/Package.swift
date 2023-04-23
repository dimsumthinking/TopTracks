// swift-tools-version: 5.8

import PackageDescription

let package = Package(
  name: "NetworkMonitor",
  platforms: [
    .iOS("16.3"),
    .macOS("13.4")],
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
