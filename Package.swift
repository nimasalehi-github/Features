// swift-tools-version:5.7
import PackageDescription

let package = Package(
    name: "Features",
    platforms: [
        .iOS(.v15) // ✅ Xcode 14 compatible target
    ],
    products: [
        .library(
            name: "Features",
            targets: ["Features"]
        )
    ],
    dependencies: [
        .package(path: "../Core") // اتصال به پکیج Core
    ],
    targets: [
        .target(
            name: "Features",
            dependencies: ["Core"],
            path: "Sources/Features"
        ),
        .testTarget(
            name: "FeaturesTests",
            dependencies: ["Features"]
        )
    ]
)
