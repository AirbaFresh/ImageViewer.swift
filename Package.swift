// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "ImageViewer_swift",
	platforms: [
		.iOS(.v14)
	],
    products: [
        .library(
            name: "ImageViewer_swift",
            targets: ["ImageViewer_swift"])
	],
    dependencies: [
        .package(url: "https://github.com/SDWebImage/SDWebImage", .upToNextMajor(from: "5.11.0")),
        .package(url: "https://github.com/SDWebImage/SDWebImageSwiftUI", .upToNextMajor(from: "2.0.0")),
        .package(url: "https://github.com/onevcat/Kingfisher", .upToNextMajor(from: "2.0.0"))
    ],
	targets: [
		.target(
			name: "ImageViewer_swift",
			dependencies: ["SDWebImage", "SDWebImageSwiftUI", "Kingfisher"],
            path: "Sources/ImageViewer_swift")
	]
)
