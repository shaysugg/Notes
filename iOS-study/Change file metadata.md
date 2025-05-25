```swift
var attributes = NSMetadataItem(url: URL(fileURLWithPath: "/path/to/file")
if let metadata = attributes {
    metadata.setValue(newValue, forKey: kMDItemDisplayName as String)
    metadata.setValue(newValue, forKey: NSMetadataItemDisplayNameKey)
    // I've tried both of them from above (different keys), they both does not work at all
}
```
https://stackoverflow.com/questions/54720082/swift-how-to-modify-file-metadata-like-kmditemdisplayname