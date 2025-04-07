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
            name: "bz2",
            targets: ["bz2"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/Deplorean/z.git", branch: "main")
    ],
    targets: [
        .executableTarget(
            name: "bzip2",
            dependencies: [
                "bz2"
            ],
            sources: ["bzip2.c"],
            resources: [
                .process("bzip2.1"),
            ]
        ),
        .executableTarget(
            name: "bzip2recover",
            dependencies: [
                "bz2"
            ],
            path: "Sources/bzip2",
            sources: ["bzip2recover.c"]
        ),
        .target(
            name: "bz2",
            dependencies: [
                .byNameItem(name: "z", condition: .none)
            ],
            path: "Sources/bzip2",
            exclude: [
                "bzip2.c"
            ],
            sources: [
                "blocksort.c",
                "huffman.c",
                "crctable.c",
                "randtable.c",
                "compress.c",
                "decompress.c",
                "bzlib.c"
            ],
            resources: [
                .process("bzdiff"),
                .process("bzlib.h")
            ],
            cSettings: [
                .define("_LARGE_FILES"),
                .define("_FILE_OFFSET_BITS", to: "64"),
                .unsafeFlags(
                    [
                        "-Wall",
                        "-Winline"
                    ]
                )
            ]
        )
    ]
    //cLanguageStandard: .
)
