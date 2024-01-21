// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RatingScreener",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "RatingScreener",
            targets: ["RatingScreener"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "RatingScreener",
            dependencies: [],
            resources: [.copy("Assets.xcassets")],
            swiftSettings: [.define("ASSETCATALOG_COMPILER_GENERATE_SWIFT_ASSET_SYMBOL_EXTENSIONS")]
        ),
        .testTarget(
            name: "RatingScreenerTests",
            dependencies: ["RatingScreener"]),
    ]
)
