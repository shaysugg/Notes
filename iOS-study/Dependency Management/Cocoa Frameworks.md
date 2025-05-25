## Articles
[iOS universal framework](http://arsenkin.com/ios-universal-framework.html)
[Deep dive into Swift frameworks](https://theswiftdev.com/deep-dive-into-swift-frameworks/)
[Distributing closed-source frameworks with SPM](https://danielsaidi.com/blog/2021/02/15/distributing-closed-source-frameworks-with-spm)
## Concepts
Package: Contains products and target and dependencies
Products:
* Made out of one or several target.
* You add dependencies to the products' of a package in the client project.
Targets:
* Blocks of the code in your package
* Each directory under Sources directory is corresponding to a target 
* They are equivalent to module. It means in the client code they are imported
* Targets can depend on **other targets** or the **dependencies of the package**
[[SPM elements concepts.canvas]]
## Building a close source framework
1) Create a `xcframework`
2) If you're developing with swift there is no need for adding header files. Just add your swift files and mark the methods and objects that are going to be used by clients as `public`
3) Save this script at the root of the project and run it for producing the `xcframework`.
```bash
#!/bin/bash

# We store xcfraamework at a directory called build
# So before everything let's clear it first
rm -rf build/*

# Replace <Framework-Name>, <Platform> and <BinaryName>
xcodebuild archive \
-scheme <Framework-Name> \
-destination "generic/platform=<Platform>" \
-archivePath build/<BinaryName> \
SKIP_INSTALL=NO \
BUILD_LIBRARY_FOR_DISTRIBUTION=YES

# Repeat the above command fo the platforms that the framework is going to support. <Platform> can be iOS, iOS, iOS-Simulator, tvOS, watchOS, ...
#...
  
# This will gather all the frameworks that you produced into one xcframework
xcodebuild -create-xcframework \
-framework build/<BinaryName>.xcarchive/Products/Library/Frameworks/<Framework-Name>.framework
# Reapeat -framework option for other platforms if you have
../
-output build/<Framework-Name>.xcframework
```
## Distribution
### SPM
For installing in projects
	* You can drag the produced framework into the `<Your Target>->Frameworks, libraries, and Embedded content`
	* You can also distribute it with SPM. Add it to the package manifest like;
```swift
let package = Package(
    name: "BinaryStudyPackage",
    products: [
	//...
        .library(name: "BinaryStudy", targets: ["BinaryStudy"])
    ],
    targets: [
        .binaryTarget(name: "BinaryStudy", path: "Sources/BinaryStudy.xcframework"),
        //...
    ]
)
// Note that we moved the xcframework and to the sources and added its relative path here 
// For refrencing it as a URL check https://github.com/KeyboardKit/KeyboardKitPro/blob/master/Package.swift
```

TODO: Apparently There are some issues with shipping an app with `xcframeworks` to the appstore.

### `cocoapods`
Only one `.podspec` file is required to be created at root directory of the project
You this template should be enough to make it work. Just make sure to address the path of the `xcframework` in the`s.vendored_frameworks`.
```swift
Pod::Spec.new do |s|
s.name = 'BinaryStudyPackage'
s.version = '1.0.0'
s.summary = 'for study'
s.homepage = 'https://www.google.com'
  
s.author = "MeeeeeOrg"
s.license = "LICENSE.txt"

s.ios.deployment_target = '14.0'
s.osx.deployment_target = '11.0'

s.source = { :git => 'https://github.com/shaysugg/BinaryStudy.git' }
s.vendored_frameworks = 'Sources/BinaryStudy.xcframework' //path to framework
end
```
For adding more details check:
https://guides.cocoapods.org/syntax/podspec.html

other resources
https://stackoverflow.com/a/64782335
https://medium.com/plus-minus-one/distribute-your-xcframework-how-to-create-a-xcframework-cde8cdff00eb
