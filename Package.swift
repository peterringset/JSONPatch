// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.
import PackageDescription

let package = Package(
    name: "JSONPatch",
    platforms: [
        .iOS(.v8), .macOS(.v10_10)
    ],
    products: [
        .library(
            name: "JSONPatch",
            targets: ["JSONPatch"]),
    ],
    targets: [
        .target(
            name: "JSONPatch",
            dependencies: [],
            path: "JSONPatch"),
        .testTarget(
            name: "JSONPatchTests",
            dependencies: ["JSONPatch"],
            path: "JSONPatchTests"),
    ]
)
