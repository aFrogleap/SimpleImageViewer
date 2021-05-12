// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "SimpleImageViewer",
    products: [
       .library(name: "SimpleImageViewer", targets: ["SimpleImageViewer"]),
    ],
    dependencies : [
    ],
    targets: [
       .target(name: "SimpleImageViewer", dependencies: [], path: "ImageViewer"),
    ]
)
