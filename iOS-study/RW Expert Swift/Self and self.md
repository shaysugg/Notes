* `self` is usually a **reference** to the object whose scope you’re currently in.
* In **class and static methods**, `self` has the value of the **current type, not an instance.**
* `Self` is always an alias to the concrete type of the scope it appears in.
* **meta-types**: the type that holds self in class and static methods.

## Examples
1) we declare a **meta-type** variable called `type`. The meta-type can hold not only the `Networker` type itself but also all of its **subclasses**, such as `WebsocketNetworker`. In the case of protocols, a meta-type of a protocol (YourProtocol.Type) can hold the protocol type as well as all concrete types conforming to that protocol.
``` Swift
class WebsocketNetworker: Networker {
  class func whoAmI() -> Networker.Type {
	return self
}

let type: Networker.Type = WebsocketNetworker.whoAmI()
```
2) assigning a meta-type
```Swift
let networkerType: Networker.Type = Networker.self
```
3) self in a class functions is value of the type
``` Swift
class Networker {
  class func whoAmI() {
    print(self)
  }
}
Networker.whoAmI()
```
4) `self` of `Self`
``` Swift
extension Request {
  func whoAmI() {
    print(Self.self)
  }
}
TextRequest().whoAmI() // "TextRequest"
```