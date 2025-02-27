// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "JSONPatch",
    platforms: [
        .iOS(.v16), .macOS(.v13),
    ],
    products: [
        .library(
            name: "JSONPatch",
            targets: ["JSONPatch"])
    ],
    targets: [
        .target(
            name: "JSONPatch"),
        .testTarget(
            name: "JSONPatchTests",
            dependencies: ["JSONPatch"]
        ),
    ]
)
