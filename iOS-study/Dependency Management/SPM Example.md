```swift
let package = Package(
    name: "SPMStudyCore",
    products: [
        .library(
            name: "VideoChat",
            targets: ["VideoChatModule"]),
        .library(
            name: "VoiceChat",
            targets: ["VoiceChatModule"]),
        .library(
            name: "TextChat",
            targets: ["TextChatModule"]),
        .library(
            name: "CompleteChat",
            targets: ["VideoChatModule", "VoiceChatModule", "TextChatModule"]),
    ],
    dependencies: [
        .package(path: "../ThirdParties/GifSearcher")
    ],
    targets: [
        .target(
            name: "VideoChatModule",
            dependencies: ["CHNetwork"]
        ),
        .target(
            name: "VoiceChatModule",
            dependencies: ["CHNetwork", "CHCompression"]
        ),
        .target(
            name: "TextChatModule",
            dependencies: ["CHNetwork", "GifSearcher", "CHEncryption"]
        ),
        .target(
            name: "CHEncryption"),
        .target(
            name: "CHCompression"),
        .target(
            name: "CHNetwork"),
        .testTarget(
            name: "SPMStudyCoreTests",
            dependencies: []),
    ]
)
```
### Description
Above is a demonstration of chat SDK that contains multiple modules and produces multiple products.
Three main products are:
1) Text Chat
2) Video Chat
3) Voice Chat
*Products define the executables and libraries a package produces, making them visible to other packages.*

Each of these three products has its own main target + other targets that acts as utilities
*Targets are the basic building blocks of a package, defining a module or a test suite.
Targets can depend on other targets in this package and products from dependencies.*
Targets somehow equivalents to modules 
Targets that are exist in this library are
1) Text Chat (Target)
2) Video Chat (Target)
3) Voice Chat (Target)
4) Encryption
5) Compression
6) Networking
Also there is a dependency to a gif library
GifSearcher

The overall structure of this library is going to be
**product: Text Chat**
targets:
    Text Chat (Target)
    dependencies: GifSearcher
    Encryption
    Networking
**product: Voice Chat**
targets:
    Voice Chat (Target)
    Encryption
    Compression
    Encryption
**product: Video Chat**
targets:
    Video Chat (Target)
    Compression
    Encryption