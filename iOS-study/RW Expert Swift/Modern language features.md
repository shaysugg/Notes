## Literals
> Literals are a great abstraction to let consumers initialize your types using typed literals, such as String, Bool, Array and many others.

Some examples can be: `ExpressibleByStringLiteral`, `ExpressibleByArrayLiteral`, `ExpressibleByDictionaryLiteral`
### Examples
#### ExpressibleByStringLiteral
checkout the example in [[Strings]]
#### ExpressibleByDictionaryLiteral
```Swift
public struct Headers {
	private let headers: [String: String]
}

extension Headers: ExpressibleByDictionaryLiteral {
	public init(dictionaryLiteral elements: (Header, String)...) {
    self.headers = Dictionary(uniqueKeysWithValues: elements.map { ($0.rawValue, $1) })
  }

  public enum Header: String {
    case accept = "Accept"
    case contentType = "Content-Type"
    case authorization = "Authorization"
    case language = "Accept-Language"
    // Additional headers
	} 
}
let request = HTTPRequest([.accept: "text/html",
                  .authorization:"Basicfreak4pc:b4n4n4ph0n3"])
//or 
let reauest: HttpRequest = [:]
```
## Dynamic member lookup
Useful when you wrap other objects but you want to give an indirect access to the wrapped object properties.
```Swift 
@dynamicMemberLookup
class SearchBar: UIControl {
  private var textField: UITextField

  subscript<T>(
    dynamicMember keyPath: WritableKeyPath<UITextField, T>
  ) -> T {
    get { textField[keyPath: keyPath] }
    set { textField[keyPath: keyPath] = newValue }
  }
}
  
let searchBar = SearchBar(...)
searchBar.isEnabled = true
searchBar.returnKeyType = .go
searchBar.keyboardType = .emailAddress
```
## Dynamic Callable
> `dynamicCallable`Allows you to dynamically call methods using an alternative syntax.

The initial intention of it probably was to interpolate with other languages.

```swift
let stored = cache.dynamicallyCall(withKeywordArguments: [
    "add": "New Item"
])
// equvalent to
let stored = cache(add: "New Item")
```
### Implementing `dynamicCallable`
```Swift
@dynamicCallable
class Storage {
    private var store: [String] = []
    
    func dynamicallyCall(withKeywordArguments args: KeyValuePairs<String, String>) -> Any? {
        for (key, value) in args {
            if key == "contains" {
                return store.contains(value)
            }else if key == "append" {
                store.append(value)
                return nil
            }
        }
        return nil
    }
}

let s = Storage()
s(contains: "Hello")
```
[Article about dynamicCallable](https://www.avanderlee.com/swift/dynamiccallable/)
## Property Wrappers
> provide a way to abstract the handling of the get/set accessor portions of properties.

It become useful when we want to reuse a same set and get logic on different properties.
### Example
Implementing a persistence mechanism with get and set of a property.
```Swift
@propertyWrapper
struct AppStorage<Value> {

  var wrappedValue: Value {
    get { defaults.object(forKey: key) as? Value ?? fallback }
    set { defaults.setValue(newValue, forKey: key) }
    }

  private let key: String
  private let defaults: UserDefaults
  private let fallback: Value

  init(wrappedValue fallback: Value,
       _ key: String,
       store: UserDefaults = .standard) {
    self.key = key
    self.defaults = store
    self.fallback = fallback
    if defaults.object(forKey: key) == nil {
      self.wrappedValue = fallback
    }
}}

@AppStorage("counter") var counter = 4
```
### Projected values
Provides an additional value to the wrapped property that can be accessed using `$`.
Usage(?)
Example: 
```Swift
class Counter {
	@Published var count = 0
}
let counter = Counter()
counter.$count // Projected Value
```
Example of defining a projected value similar to `@Published`
```Swift
@propertyWrapper
struct MyPublished<Value> {
  var wrappedValue: Value {
    get { storage.value }
    set { storage.send(newValue) }
  }
  
  var projectedValue: AnyPublisher<Value, Never> {
    storage.eraseToAnyPublisher()
  }

  private let storage: CurrentValueSubject<Value, Never>
  init(wrappedValue: Value) {
    self.storage = CurrentValueSubject(wrappedValue)
  }
}
```