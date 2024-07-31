We can define KVO observation in our code like this.
```Swift
class TestObject: NSObject {
  @objc dynamic var integerProperty: Int = 0
}

let obj = TestObject()

let subscription = obj.publisher(for: \.integerProperty)
  .sink {
    print("integerProperty changes to \($0)")
  }

obj.integerProperty = 100
obj.integerProperty = 200
```

## Without Combine
```swift
class MyObjectToObserve: NSObject {
    @objc dynamic var myDate = NSDate(timeIntervalSince1970: 0) // 1970
    func updateDate() {
        myDate = myDate.addingTimeInterval(Double(2 << 30)) // Adds about 68 years.
    }
}

class MyObserver: NSObject {
    @objc var objectToObserve: MyObjectToObserve
    var observation: NSKeyValueObservation?


    init(object: MyObjectToObserve) {
        objectToObserve = object
        super.init()


        observation = observe(
            \.objectToObserve.myDate,
            options: [.old, .new]
        ) { object, change in
            print("myDate changed from: \(change.oldValue!), updated to: \(change.newValue!)")
        }
    }
}
```
You can also do KVO observing like;
```swift
class Something: NSObject {
addObserver(self, forKeyPath: #keyPath(PlayerViewController.player.currentItem.duration), options: [.new, .initial], context: &playerViewControllerKVOContext)
}
```
## Definition
>Key-value observing is a Cocoa programming pattern you use to notify objects about changes to properties of other objects. It’s useful for communicating changes between logically separated parts of your app—such as between models and views. You can only use key-value observing with classes that inherit from [`NSObject`](https://developer.apple.com/documentation/objectivec/nsobject).

[Docs](https://developer.apple.com/documentation/swift/using-key-value-observing-in-swift)
