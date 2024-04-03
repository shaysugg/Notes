Most of the times we define our UI logic in the body of a view which will be executing on the main queue however we may want to extract some of those views in the functions or variables. Note that they are not necessarily going to be execute on the main queue. The `View` defination syntax is:
```Swift
public protocol View {
    associatedtype Body : View
    @ViewBuilder @MainActor var body: Self.Body { get }
}
```
Note that the protocol doesn't have `@MainActor` Only the body does.
So @MainActor should be added manually before any function or variable which aim to build a view.
```Swift
struct MyView: View {
	@MainActor var myButton: some View {
	    VStack {
		Text("Hello")
		}
	}

	@MainActor func buildButton() -> some view {}
}
```