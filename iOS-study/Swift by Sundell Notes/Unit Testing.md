## Two Important Refactoring Techniques
Two important techniques for refactoring a non-testable code
* Pure functions
* Dependency Injection
[Article](https://www.swiftbysundell.com/articles/refactoring-swift-code-for-testability)
## Functions Instead of Singleton
Assume an implementation of User loader which has singleton dependencies to `NetworkManager`, `UserCache`.
```Swift
struct UserLoader {
    func loadUser(
        withID id: User.ID,
        then handler: @escaping (Result<User, Error>) -> Void
    ) {
        if let user = UserCache.shared.user(withID: id) {
            return handler(.success(user))
        }
        NetworkManager.shared.loadData(from: .user(id: id)) { 
                UserCache.shared.insert(user)
    }
}
```
One of the easiest way of make this class testable is to replace the dependencies to singleton with functionality of those singleton.
See also: [[Functional Dependency Injection]]
```Swift 
struct UserLoader {
	@DebugOverridable
    var networking = NetworkManager.shared.loadData
    @DebugOverridable
    var cacheInsertion = UserCache.shared.insert
    @DebugOverridable
    var cacheRetrieval = UserCache.shared.user
}
```
We use `@DebugOverridable` to make sure we can only override those vars in tests and debug builds.
## Writing Tests for SwiftUI views
**Don't**
Extract the logic into other classes like viewModels, models, controllers and etc.