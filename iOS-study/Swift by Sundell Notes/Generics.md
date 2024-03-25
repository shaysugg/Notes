## Function conditional conformence
Keep in mind that It's possible to write the conditional generic conformance on the function levels instead of the entire extension.
```Swift
extension Sequence /*where Element == Renderable*/ {
    func render() -> UIImage where Element == Renderable {
        ...
    }
}
```
## Conditions on underlying associated types
Assume this protocol
```Swift
protocol Group {
    associatedtype Member
    var members: [Member] { get }
    init(members: [Member])
}
```
let's say we define this functionality for it
```Swift
extension Group {
    func combined(with other: Self) -> Self {
        Self(members: members + other.members)
    }
}
```
However it's required to both `Groups` have the same type, which is not always necessary, what it's important is their associated types exactly to be the same.
By using generics like that we can have a more robust function
```Swift
extension Group {
    func combined<T: Group>(
        with other: T
    ) -> Self where T.Member == Member {
        Self(members: members + other.members)
    }
}
```
## Commonly used protocols techniques
### Inheritance
```Swift
protocol User {
    var id: UUID { get }
    var name: String { get }
}

extension AnonymousUser: User {}
extension Member: User {}
extension Admin: User {}
protocol AuthenticatedUser: User {
    var accessToken: AccessToken { get }
}

extension Member: AuthenticatedUser {}
extension Admin: AuthenticatedUser {}
```
### Specializations
```Swift
protocol Component {
    associatedtype Container
    func add(to container: Container)
}

protocol ViewComponent: Component where Container: UIView {
    associatedtype View: UIView
    var view: View { get }
}
```
### Compositions
```Swift
typealias Codable = Decodable & Encodable
```
## (Untitled)
[Description](https://www.swiftbysundell.com/articles/designing-reusable-swift-libraries/#packaging-up-a-generic-concept)
```Swift
extension TaggedCollection: Codable where Element: Codable {}
```
## Closures: Worthwhile alternatives to protocols
Closures should be considered as a an alternatives to protocols that brings type complexities, doesn't contains values and most of the time performing one action. These protocols most of the time are used  as a Type erasures.
`Usecase`s in clean architecture can be a good example.
Also for a more complex example check: [Generic wrapper types](https://www.swiftbysundell.com/articles/different-flavors-of-type-erasure-in-swift/#generic-wrapper-types)
## Type Erasures
Most of the time protocols are used as a type erasure. The problem that we can encounter occassionally with them is when they have associated types. In those cases we can't address them directly
```Swift
protocol Request {
    associatedtype Response
	//...
}

class RequestQueue {
    // Error: protocol 'Request' can only be used as a generic
    // constraint because it has Self or associated type requirements
    func add(_ request: Request,
             handler: @escaping Request.Handler) {
        //...
    }
}
```
### Modern Solution
* The modern solution that provided by language: Using [any and some](Embrace Swift Generics)
### Other Solutions
#### Generic Contraint
```Swift
class RequestQueue {
    func add<R: Request>(_ request: R,
                         handler: @escaping R.Handler) {
        //...
    }
}
```
#### Generic Wrapper Types
Previous solution has some downsides. 
* we can't restore the request as a `Request`property or`[Request]`. 
* It makes the reusability harder since we need to write generic constraint for each function that want to use
```Swift
// This will let us wrap a Request protocol implementation in a
// generic has the same Response and Error types as the protocol.
struct AnyRequest<Response, Error: Swift.Error> {
    typealias Handler = (Result<Response, Error>) -> Void

    let perform: (@escaping Handler) -> Void
    let handler: Handler
}
```
#### Closures
Instead of defining the request type which only does one thing we can use closure as an abstract definition of that functionality.
## Defaults for associated Types
```Swift
protocol Identifiable {
    associatedtype RawIdentifier: Codable = String

    var id: Identifier<Self> { get }
}
```