// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftyRRule",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "SwiftyRRule",
            targets: ["SwiftyRRule"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "SwiftyRRule",
            resources: [
                        .copy("lib/nlp.js"),
                        .copy("lib/rrule.js")
                        ]
        ),
        .target(
                    name: "SwiftyRRule-Demo",
                    dependencies: [
                        "SwiftyRRule"              // ✅ 依赖上面声明的 product
                    ],
                    path: "Examples/SwiftyRRule-Demo"
                ),

    ]
)
