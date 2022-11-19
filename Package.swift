// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CombineUtility",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(name: "CombineUtility", targets: ["CombineUtility"])
    ],
    dependencies: [
        .package(url: "https://github.com/Quick/Quick", .upToNextMajor(from: "5.0.0")),
        .package(url: "https://github.com/Quick/Nimble", .upToNextMajor(from: "10.0.0"))
    ],
    targets: [
        .target(name: "CombineUtility",
                path: "CombineUtility"),
        .testTarget(
            name: "CombineUtilityTests",
            dependencies: ["CombineUtility",
                           "Nimble",
                           "Quick"],
            path: "CombineUtilityTests"),
    ]
)
