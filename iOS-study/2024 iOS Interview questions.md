## Swift Language
[[Swift Programming Language]]
* What's the difference between `Double` and `Float`?
* How can you specialize error handlings on `do try catch`?
* If we have a cleanup process after throwing an error how we can achieve it?
* In Swift can we compare tuples? If it is so, can you explain how?
* One side ranges relation with finite collections?
* What are the ways of embedding special characters in strings?
* Can we access a character of string with an integer index? If we can't can you explain why with an example? And what's the correct way of accessing characters in strings?
* What's the substring? what advantage using it has?
* With what functions we can compare the characters at the beginning or the end of  two strings? ==X==
* What's the requirement for a type to being used as an element of a set? And how you add that behavior to a type?
* What are the unique operations that you can have with two sets? ==X==
* What are some advance operations with switch cases? like switch cases with tuples, conditional cases, pack multiple cases with or.
* Explain different types of closures in Swift.
* How lazy property works? Is there any potential issues when we access it from multiple threads?
* Explain different types of methods
* What are subscripts? What ability they add to an object? ==X==
* Can you explain how initializers work in structs and enums?
* Can you explain different initializers that exist in classes and what are their usages?
* How you can inherit all of the superclass designated initializers? How it's possible to inherit all of the convenience initializers?
* Can extensions override an existing functionality?
* What are the opaque and boxed types? What difference they have with generic types?
* What is a reference cycle? What options can be used to resolve it? explain it with examples.
## Combine
* Explain Publisher, Subscriber, Subscription and each role they have in enabling the transmission of values over the time.
	* Explain these concept with a custom publisher emits random numbers over the time. [[Custom Publisher]], [[Custom Subscriber]]
* What is a Future? What benefits it has that will make it a good candidate to call an API service?
* Explain different kind of subjects in combine. Before subscription if some values have been sent to these subjects what they behavior will be when you subscribe to them?
* Explain these combine operations with examples
	* `collect`, `flatMap`, `debounce`, `throttle`, `output`, `replaceEmpty`, `share`, `debugging tools`, `catch`
* Explain `multicast` operator, what differences it has with `share`
* How can we use combine publishers directly in SwiftUI views?
* Explain briefly what KVO is and how you can work with it in combine?
* What are the differences between `subscribe(on:)` , `receive(on:)` when we apply them on a publisher?
* Can you explain what a scheduler is in combine? What's the difference between `Runloop.main` and `DispatchQueue.main` schedulers
* What's the `autoconnect()` that's being used with Timers?
* What benefits custom publisher operators have? How do you define one?
* What's use cases `Defferd` has?
* How you can test a code that works with combine?
## Standard Library
* Why we have abstract protocols like `Decodable` and `Encodable`?
* Explain different containers that exist in custom decoding and encoding.
* In which cases we can achieve a polymorphism when we're decoding with enums. Explain it with an example
* How do you ignore values with certain keys in json parsings?
* Explain a polymorphism in json parsings with an example?
* How optional type is defined in Swift?
* What `rethrows` keyword does?
* What are the fundamental types in swift? Explain each group with examples.
* How data types like `Int` an `String` defined and implemented?
* What are the differences between classes and structs?
* Can you tell 4 expectation that you think developers want from the APIs that you design?
* What are the different access levels in swift?
* What are the literals?
* Explain this modern Swift features briefly. Literals, dynamic member lookups, property wrappers
* What's you strategy to version your apps and APIs?
* What is the dynamic dispatch and static dispatch? 
* When you add a functionality implementation by extension, is it going to be dynamic dispatched or statically?
* Explain some protocol declaration capabilities, such as conditional conformance, multiple conformance, synthesized protocol conformance.
* How can you have generics behaviors in protocols.
* How can we create ranges with new types in swift? How we can iterate through them? 
* Explain differences between `Self` and `self`?
* Briefly explain the hierarchy of sequences and collections in Swift.
* Explain sequences and the different ways you can implement them in Swift.
* What are the collections? Explain different types of them. `Collection`, `BidirectionalCollection`, `RandomAccessCollection`, `MutableCollection`, `RangeReplaceableCollection`
* What's happening when you make an array lazy. Explain it with an example?
* Explain recoverable errors and none-recoverable errors in swift?
* Explain function injections as an alternative to protocol oriented polymorphism?
* How can you specialized generics types in functions, extensions and more?
* Can you use a protocol with an associated type as a type? What are some solutions to address the challenges it may bring?
* What are the `keypath`s? Explain with an example its usage? (sort based on keypath)
* What is the difference between using calling `[..<5]` or `prefix(5)` on an array?
* How a string can be divided to multiple strings based on a separator? If there are multiple ways explain their differences.
* What are macros? How many macro types we have?
* Can you explain overall steps that you take to write a macro?
## SwiftUI
[[iOS-study/Swift by Sundell Notes/SwiftUI]]
* What are the `preferenceKey`s. Explain their usages with an example.
* How can we prioritize view expansion when we put them in a stack?
* Explain the difference between `ZStack` and `.overly` or `.background()`
* Explain different keywords that are being used with swiftUI state managements.
* What potential issues computed properties may cause when they are being used in swiftUI views?
* What different approaches we can take to customize a View? (3)
* How UIKit views can be used with SwiftUI? Explain the state managements process.
* What usage coordinators have in SwiftUI?
* How UIKit views can be used with SwiftUI? What's the best practice for its state management?
* How we can use app delegates function within SwiftUI?
* What are the ViewBuilders? (Function Builders)
* Why it's a best practice to avoid AnyView? What are some alternatives for its usages?
* How view cycles are being handled in SwiftUI? what are the differences between functions?
* Explain viewModifiers unique features (state management) with an example. (validator)
* Explain navigation patterns that you've used with SwiftUI?
## TDD
* What is TDD? Explain its common steps.
* For which part of the code you should write tests and for each part you should not?
* What are some features of a good test? Explain with an example? 
* How can you test async code? (async await, combine ,expectations)
* What are some features of expectations in XCTests?
* Explain different types of mocks?
* What is your strategy to write tests for legacy code?
* What are dependency maps? What dependencies are problematics?
* Explain functions instead of singleton approach in refactoring dependencies for tests?
* What are the problems with testing dates in XCTests? What are some solutions to address those?
* Explain the common pattern structure in writing tests?
* What are some approaches to mock the Networking logic?
* How do you use URLProtocol to mock the networking layer?
* Can you explain integration tests with an example?

## URLSession
* Can you tell us about the different network clients that you've worked with?
* Can you tell us about the custom network client that you've implemented? (Endpoints, validators,  request modifiers, network client, refresh token)
* Have you worked with `URLSessionDelegate`? If you have what functionality you've implemented with them? (Explain download manager)
* Explain different cache policies in URLSession?
* Explain different authentication methods that you've worked with. (JWT, OAuth, Basic)
* How do you handle errors that you get from `URLSessions`?
* How do you use URLProtocol to mock `URLSession`?
* How combine `share` can be useful when you use combine to do networking?
* How you recognize that the user is offline or not?
* How you can perform web sockets with `URLSession`?
* How can you manage sending files with form data?
## Modern Concurrency
* Briefly explain the difference between asynchronous and synchronous code?
* Can you point out to 3 GCD problems that the modern concurrency has fixed?
* Can explain some modern concurrency benefits? (cooperative thread pool, compile safe code, async await syntax, structured concurrency)
* What is async let and how it can be useful?
* What is Sendable? What form it has? when should we apply it?
* What are the structured or unstructured concurrency? How we can create them and what differences they have?
* What is the difference between `Task` and `Task.detached`
* How the task cancellation works? when we call `task.cancel()` what will happen?
* What are the different methods to check the task is canceled or not?
* What is the usage of task groups?
* What options you have based on the values that task groups accepts and produce?
* Explain data races with task group. Which parts of the task groups are not safe?
* What are the async sequences?
* How you can create async sequences?
* How you can send values to async sequence outside of their scope?
* What are the actors? What problem do they solve?
* What are `@noneisolated` methods.
* What effects it has when you change a class to actor to its clients? 
* What are global actors? How you can create them?
* What is the usage of `Task`? How it's lifetime will be managed?
* Why you call task sleep with `try`?
## Core Data
* How do you setup a core data in a new project?
	* `NSManagedObjectModel`, `NSPersistentContainer`, `NSManagedObjectContext`
*  How do you make a persistent container to store its data on memory only?
* What is you strategy to temporarily write something on core data in a way that if we save the viewContext it will not be saved?
* What are the batch operation? When they're useful? What drawbacks they may have?
* What are some strategies to update the app data when performing a batch request?
* How you can observe changes of `NSManagedObjectContext`?
* Explain what's the `NSFetchResultController` and what usages it has?
* How can we have objects that are unique with some properties?
* Explain fetch limits and number of objects when you perform fetching?
* How you can create multiple predicates?
* How can you dispatch a heavy work to background in core data? (2 methods)
* Is it core data functions thread safe? If they're not how you can prevent race conditions?
* How you can fetch a lots of items asynchronously ?
* Explain the usage of`performBackgroundTask`?
* Is it safe to share different `NSManajedObject` between different threads?
* In core data what are the `ValueTransformer`s and what usage they have?
* Explain different delete rules in core data relationships?
* Explain the lazy loadings of core data models and relationships?
* Briefly explain lightweight migration in core data?
## Architectures
Assume these architectures:
`MVC`, `MVVM`, `Elements`, `Redux`
* What components each of them have?
* What advantages and disadvantages each has?
* Explain how you can start simply from MVC and build more complex architectures.
* What technologies and frameworks can become handy in each architecture.
* Explain different dependency injection methods that you've used?
## Concurrency
* What were the main two tools to handle concurrency before async await?
* How do you work with threads?
* How do you capture self in dispatch queue closures?
* What are `DispatchWorkItem` and what benefits they have?
* What are the `DispatchGroupes`? What purpose they have?
* How you can run limit the number of tasks that dispatch group runs?
* What are the `Operation`s? what's the main reason to use them instead of dispatch queues?
* What's the simplest way to create a `Operation`?
* Can you run asynchronous code in `Operation` ? If not what customization is needed?
* What benefits using the operation queue has? (wait for completion,  pausing the queue, maximum number of parallel task, underlaying dispatch queue)
* How operation canceling works? Why?
* What tool you use to find and analyze potential concurrency problems?
* What are 3 common concurrency problems and how you can address them?
## ARKit
* What is the general architecture that you use with `RealityKit`? What components it has?
* How do you interact with different objects in systems?
* What difference rendering with `ARKit` have with `RealityKit`?
* How do you organize and reuse your code when used `ARKit`?
* What are some of `ARSceneViewDelegate` methods that you've commonly used ?
## CryptoKit
* For data that is stored on disk what protection levels are available?
* What types of hashing are exist? Can you explain their usages with examples?
* In `CryptoKit` how we can validate data without knowing the actual data? (HAMC)
* In `CryptoKit`  How we can encrypt and decrypt data?
* In `CryptoKit`  How we can validate data without knowing the key that has created the data?
* How we can build an end to end encryption in `CryptoKit`?
## Git
* In git logs how you can filter logs based on date? based on author? based on text in the commit message? based on the code that change contains a text?
* What types of merges do we have and what's the differences between them?
* What is cherry picking in git?
* How you can see the difference between two last commits?
* What is the difference between Rebase and merge?
* What is the interactive rebase? How you can change the history with interactive rebase?
* What is git stashing used for? how you can see the list of the stashes? how you can stash untracked changes?
* What are some strategies to undo changes?
* What are some caveats when you use git reset --hard?
* What's the difference between reset --hard and reset --softs?
* (practical) you have merged a feature and it's breaking the code and all your colleges are angry? How you can fix it in the most safe way?
* If you want to see all of the changes and perform resets based on changes what will you use?
* Can you explain the differences between git pull and git fetch?
* What git workflows you used in previous projects?
## Other
* How can you measure your build time with Xcode?
* Did you have experience with adding localizations to your app?
* What are mirrors? How you can mirror a property of a type?
## Design Patterns
For each of the below design patterns
`AbstractFactory`, `Adaptor`, `Builder`, `ChainOFResponsibility`, `Composite`, `Decorator`, `FactoryMethod`, `Visitor`, `Singleton`, `Observers`, `MulticastDelegate`
Explain the purpose and the overall structure that's needed to build it?

Not that much important for now:
`Bridge`, `Prototype`, `Proxy`, `Iterator`, `Template Method`, `Mediator`,`Strategy`, `StateMachiones`

---
TODO:NSPredicates
TODO: Instruments
TODO: ARKit raycasting


TODO: More on codable techniques? (ignoring invalid values in array, default values)
TODO: Swift Document keypath and the others