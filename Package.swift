// swift-tools-version: 6.0.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "bzip2",
    platforms: [
        .macOS(.v15),
        .visionOS(.v2),
        .iOS(.v15),
    ],
    products: [
        .executable(
            name: "bzip2",
            targets: ["bzip2"]
        ),
        .executable(
            name: "bzip2recover",
            targets: ["bzip2recover"]
        ),
        .library(
            name: "bzlib",
            type: .dynamic,
            targets: ["bzlib"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/Deplorean/z.git", from: "1.3.1")
    ],
    targets: [
        .executableTarget(
            name: "bzip2",
            dependencies: [
                "bzlib"
            ],
            sources: ["bzip2.c"]
        ),
        .executableTarget(
            name: "bzip2recover",
            dependencies: [
                "bzlib"
            ],
            path: "Sources/bzip2",
            sources: ["bzip2recover.c"]
        ),
        .target(
            name: "bzlib",
            dependencies: [
                .byNameItem(name: "z", condition: .none)
            ],
            path: "Sources/bzip2",
            exclude: [
                "bzip2.c"
            ],
            sources: [
                "bzlib.c",
                //"bzip2recover.c",
                "decompress.c",
                "compress.c",
                "randtable.c",
                "crctable.c",
                "huffman.c",
                "blocksort.c"
            ]
        )
    ]
)
