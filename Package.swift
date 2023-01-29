// swift-tools-version: 5.7

import PackageDescription

let package = Package(
  name: "ShXcrun",
  platforms: [
    .macOS(.v12)
  ],
  products: [
    .library(
      name: "ShXcrun",
      targets: ["ShXcrun"]),
  ],
  dependencies: [
    .package(url: "https://github.com/FullQueueDeveloper/Sh.git", from: "1.2.0-alpha"),
  ],
  targets: [
    .target(
      name: "ShXcrun",
      dependencies: ["Sh"]),
    .testTarget(
      name: "ShXcrunTests",
      dependencies: ["ShXcrun", "Sh"]),
  ]
)
