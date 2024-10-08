// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Log",
    platforms: [
        .iOS(.v16), .macOS(.v12)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Log",
            targets: ["Log"]),
    ],
    dependencies: [
        .package(url: "https://github.com/manuelselch/Redux", .upToNextMajor(from: "1.2.14"))
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Log",
            dependencies: [
                .product(name: "Redux", package: "Redux")
            ],
            path: "Sources"
        ),
        .testTarget(
            name: "LogTests",
            dependencies: ["Log"]),
    ]
)
