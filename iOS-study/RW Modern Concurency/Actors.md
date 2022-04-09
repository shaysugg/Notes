# Actors
as mentioned in the taskgroups modifying objects through different threads can cause Data Races. on of the soulutions is define classes as actor

```swift
actor Foo {}
//istead of 
class Foo {}
```

## MainActor
if our custom actor has some related to UI properties, like variable with `@Published` property wrapper then we need to put a `@MainActor` property wrapper to make sure it would treat this variable on the `MainActor` not the class own actor and our UI can safely use it.

if we want to modifying it in the custom actor we have to use `MainActor.run {}` to make sure our changes would execute on the `MainActor`

```swift
actor FooViewModel: ObservableObject {
	@Published @MainActor var someData: String = ""

	func assignData() async {
	//some async work...
	//then
	MainActor.run {
		someData = "Some Data"
		}
	}

}

struct FooView: some View {
	@StateObject var viewModel = FooViewModel()

	var body: some View {
	Text(someData)
	}
}
```

*if we turn our class to an actor we probably gonna face some advance problems better checkout the book page 190 for seeing some tricks that we may use to fix them.*

## `nonsolated` Methods
if in our actors we have functions that don't modify the state of actor we can use them like `nonisolated func foo() {}`. this would act the function as a **default class function**  and some boost in our performance of the app.

## Sendable
in the swift concurrency topics it means: **safe to use in concurrent code**
* there is a Sendable protocols that some classes conforms to: like **Actors**
* there is an annotation `@Sendable` which makes closure sendable
```swift
@escaping @Sendable () async -> Void
```

🔥 The best practice in your own code is to require that any **closures** you run **asynchronously** be `@Sendable`, and that any **values** you use in **asynchronous** code adhere to the `Sendable` protocol.


