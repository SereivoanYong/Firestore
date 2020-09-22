// swift-tools-version:5.3
import PackageDescription

let package = Package(
  name: "Firestore",
  platforms: [
    .iOS(.v9)
  ],
  products: [
    .library(name: "Firestore", targets: ["Firestore"])
  ],
  targets: [
    .target(name: "Firestore")
  ]
)
