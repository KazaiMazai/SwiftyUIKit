// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftyUIKit",
    platforms: [
       .iOS(.v9)
    ],
    products: [
        .library(
            name: "SwiftyUIKit",
            targets: ["SwiftyUIKit"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "SwiftyUIKit",
            dependencies: []),
        .testTarget(
            name: "SwiftyUIKitTests",
            dependencies: ["SwiftyUIKit"]),
    ]
)
