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