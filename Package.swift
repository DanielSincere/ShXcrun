// swift-tools-version: 5.8

import PackageDescription

let package = Package(
  name: "ShXcrun",
  platforms: [
    .macOS(.v13)
  ],
  products: [
    .library(
      name: "ShXcrun",
      targets: ["ShXcrun"]),
  ],
  dependencies: [
    .package(url: "https://github.com/FullQueueDeveloper/Sh.git", from: "1.3.0"),
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
