// swift-tools-version: 6.1
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
        .executable(name: "bzip",
                    targets: [
                        "bzip"
                    ],
                   ),
        .library(name: "bzip2",
                 type: .dynamic,
                 targets: ["bzip2"]
                ),
    ],
    dependencies: [
        .package(url: "git@github.com:Deplorean/z.git", from: "1.3.1"),
    ],
    targets: [
        .executableTarget(name: "bzip",
                          dependencies: [
                            .byNameItem(name: "bzip2", condition: .none),
                          ],
                          sources: [
                            //"bzlib.c",
                            "bzip2.c",
                          ],
                         ),
        .target(
            name: "bzip2",
            dependencies: [
                .byNameItem(name: "z", condition: .none),
            ],
            sources: [
                "bzlib.c",
                //"bzip2.c",
                //"bzip2recover.c",
                "decompress.c",
                "compress.c",
                "randtable.c",
                "crctable.c",
                "huffman.c",
                "blocksort.c",
            ],
            publicHeadersPath: "include",
            cSettings: [
                .headerSearchPath("include"),
            ],
        ),
    ],
    //cLanguageStandard: .gnu11,
    //cxxLanguageStandard: .gnucxx17
)
