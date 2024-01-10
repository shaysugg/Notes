## The Good old OOP way
Assume this example
```Swift
struct ProductViewModel {
    let manager = ProductManager()
    func load() async throws -> String {
        try await manager.load()
        //other vm stuff ...
    }
    func save(product: String) async throws {
        try await manager.save(product: product)
        //other vm stuff ...
    }
}

struct ProductManager {
    func load() async throws -> String {
        "product"
    }
    func save(product: String) async throws {
        print("saving \(product) ...")
    }
}
```
On way of testing is allowing the manager to get injected underneath of an abstraction definition. which allows us to inject a mock version instead of a real one in our tests.
```Swift
struct ProductViewModelTestable {
    let manager: ProductManagerProtocol
    func load() async throws -> String {
        try await manager.load()
        //other vm stuff ...
    }

    func save(product: String) async throws {
        try await manager.save(product: product)
        //other vm stuff ...
    }
}

protocol ProductManagerProtocol {
    func load() async throws -> String
    func save(product: String) async throws
}

extension ProductManager: ProductManagerProtocol {}
```
However if we want to avoid unnecessary protocol definitions, We can consider injecting the functionalities instead of the object that does those functions.
This is can be a good approach for the objects that is depended only on a small functionality of a another object.
## Injecting functions
```Swift
struct ProductViewModelFunctionInjectable {
   let loadProducts: () async throws -> String
   let saveProducts: (String) async throws -> Void

	init(
	loadProducts: () async throws -> String,
	saveProducts: (String) async throws -> Void) {
		self.loadProducts = loadProducts
		self.saveProducts = saveProducts
	}
	
    func load() async throws -> String {
        try await actions.loadProducts()
        //other vm stuff ...
    }

    func save(product: String) async throws {
        try await actions.saveProducts(product)
        //other vm stuff ...
    }
}
```
One thing that we may face is list of the required functions may increased and bring complexity to the object `init()`. while we should always consider to replace the functions with an object if the dependencies become too much there are some techniques to make the code more organized.
### Defining `typealias`
We can define `typealiases` for frequently used function signatures. to eliminated the long function signatures.
```Swift
typealias Loading<T> = () async throws -> T
typealias AsyncAction<T> = (T) async throws -> Void
```
### Defining Object Actions
For grouping functions and giving them default implementations we can define `Action`s structs which grouping those functions as an extensions to those objects.
We can also define multiple default implementations for those actions.
```Swift
extension ProductViewModelFunctionInjectable {
    struct Actions {
        let loadProducts: Loading<String>
        let saveProducts: AsyncAction<String>
    }
}

extension ProductViewModelFunctionInjectable.Actions {
    init() {
        loadProducts = { "" }
        saveProducts = { _ in  }
    }

    init(productManage: ProductManager) {
        loadProducts = productManage.load
        saveProducts = productManage.save
    }
}
```
You can see these `Action`s is somehow equivalent to `Protocol`s that we use for those objects, but in a more functional way.