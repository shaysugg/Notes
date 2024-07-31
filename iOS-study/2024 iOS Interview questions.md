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
* With what functions we can compare the characters at the beginning or the end of  two strings?
* What's the requirement for a type to being used as an element of a set? And how you add that behavior to a type?
* What are the unique operations that you can have with two sets?
* What are some advance operations with switch cases? like switch cases with tuples, conditional cases, pack multiple cases with or.
* Explain different types of closures in Swift.
* How lazy property works? Is there any potential issues when we access it from multiple threads?
* Explain different types of methods
* What are subscripts? What ability they add to an object?
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
* What's happened when you make an array lazy. Explain it with an example?
* Explain recoverable errors and none-recoverable errors in swift?
* Explain function injections as an alternative to protocol oriented polymorphism?
* How can you specialized generics types in functions, extensions and more?
* Can you use a protocol with an associated type as a type? What are some solutions to address the challenges it may bring?
* What are the `keypath`s? Explain with an example its usage? (sort based on keypath)
* What is the difference between using calling `[..<5]` or `prefix(5)` on an array?
* How a string can be divided to multiple strings based on a separator? If there are multiple ways explain their differences.
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
## TDD
* What is TDD? Explain it's common steps.
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
* How you handle errors that you get from `URLSessions`?
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
* 
---
TODO: Architectures
TODO: ARKIT
TODO: More on codable techniques? (ignoring invalid values in array, default values)
TODO: Swift Document keypath and the others