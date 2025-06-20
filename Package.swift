// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription
import CompilerPluginSupport

let package = Package(
    name: "toolkit",
    platforms: [
        .iOS(.v26),
        .macOS(.v26)
    ],
    products: [
        .library(name: "ABToolKit", targets: ["ABToolKit"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-syntax", from: "601.0.1")
    ],
    targets: [
        .macro(name: "ToolKitMacro", dependencies: [
            .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
            .product(name: "SwiftCompilerPlugin", package: "swift-syntax")
        ]),
        .target(name: "ABToolKit", dependencies: ["ToolKitMacro"]),
        .testTarget(name: "ABToolKitTest", dependencies: ["ABToolKit"]),
        .testTarget(name: "ToolKitMacroTest", dependencies: [
            "ToolKitMacro",
            .product(name: "SwiftSyntaxMacroExpansion", package: "swift-syntax")
        ])
    ]
)

