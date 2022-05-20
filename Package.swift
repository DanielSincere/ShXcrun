// swift-tools-version: 5.5

import PackageDescription

let package = Package(
    name: "ShXcrun",
    platforms: [
        .macOS(.v11)
    ],
    products: [
        .library(
            name: "ShXcrun",
            targets: ["ShXcrun"]),
    ],
    dependencies: [
        .package(url: "https://github.com/FullQueueDeveloper/Sh.git", from: "1.0.1"),
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
