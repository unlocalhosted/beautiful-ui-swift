// swift-tools-version: 6.3
import PackageDescription

let package = Package(
    name: "BeautifulUI",
    platforms: [
        .iOS(.v26),
        .macOS(.v26)
    ],
    products: [
        .library(name: "BeautifulUI", targets: ["BeautifulUI"]),
        .library(name: "BeautifulUICatalog", targets: ["BeautifulUICatalog"])
    ],
    targets: [
        .target(name: "BeautifulUI"),
        .target(name: "BeautifulUICatalog", dependencies: ["BeautifulUI"]),
        .testTarget(name: "BeautifulUITests", dependencies: ["BeautifulUI"])
    ]
)
