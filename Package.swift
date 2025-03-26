// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "DocToPDF",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15)
    ],
    products: [
        .library(
            name: "DocToPDF",
            targets: ["DOCXConverter"]),
    ],
    dependencies: [
        .package(url: "https://github.com/weichsel/ZIPFoundation.git", from: "0.9.0"),
    ],
    targets: [
        .target(
            name: "DOCXConverter",
            dependencies: ["ZIPFoundation"],
            path: "Sources/DOCXConverter"),
    ]
) 
