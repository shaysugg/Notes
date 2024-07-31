## PreferenceKey
This is a protocol that requires a value and a reducer. By implementing this protocol we can have our own key.
* Values can be send by using `.preference(key:,value:)`
* Values can be consumed by using `.onPreferenceChange(_ key, perform)`
In this example we are syncing the width of views that are in `someView` based on the maximum width.
```Swift
struct ButtonWidthPreferenceKey: PreferenceKey {
	static let defaultValue: CGFloat = 0
	static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
		value = max(value, nextValue())
	}
}

var body: some View {
	someView()
		.background(GeometryReader { geometry in
			Color.clear.preference(
				key: ButtonWidthPreferenceKey.self,
				value: geometry.size.width
			)
		})
	//...
		.onPreferenceChange(ButtonWidthPreferenceKey.self) {    
				buttonWidth = $0
		}
}
```
[Practical example](https://www.swiftbysundell.com/articles/swiftui-layout-system-guide-part-2/#geometry-preferences-and-layout-dependencies)
## Layout Priority
```Swift
ImagePlaceholder().layoutPriority(-1)
```
Tells the swiftUI how to respect the view demanded size. In the above example the ImagePlaceHolder is the one that affects the most when It's in a view tree that has large amount of items.
## `ZStack` and `overlay` and `background`
`ZStack`s are useful for arranging views on top of each other but their expansion is based on the maximum size of their elements. For instance if we have a `LinearGradient` and a `Text`, since `LinearGradient` by default takes as much as space that's possible our z stack will also fill the entire available space.
But sometimes we may only want to fix the expansion and position of one element base on a specific view. we can use `.background` or `.overlay` for that.
## State management
* `@StateObject`, `@ObservedObject`, `@State`, `@Environment`, `@EnvironmentObject`
* Use binding instead of closures
* Environment keys required a value at compile time while EnvironmentObject values will check at runtime and if they were not provided the application will crash.
```Swift 
struct ThemeEnvironmentKey: EnvironmentKey {
    static var defaultValue = Theme.default
}

extension EnvironmentValues {
    var theme: Theme {
        get { self[ThemeEnvironmentKey.self] }
        set { self[ThemeEnvironmentKey.self] = newValue }
    }
}
```
## Computed properties
Computed properties should be avoided in the views that have the possibility of re-rendering based on state changes. Either they should be computed in other places before coming to the view or if it's possible the computation should happen only once in the view initialization.
## Observe a combine publisher
This adaptor class can become handy when we want to observe a single publisher events in a view
```swift
@dynamicMemberLookup
final class Observable<Value>: ObservableObject {
    @Published private(set) var value: Value
    private var cancellable: AnyCancellable?

    init<T: Publisher>(
        value: Value,
        publisher: T
    ) where T.Output == Value, T.Failure == Never {
        self.value = value
        self.cancellable = publisher.assign(to: \.value, on: self)
    }

    subscript<T>(dynamicMember keyPath: KeyPath<Value, T>) -> T {
        value[keyPath: keyPath]
    }
}
```
[Full Article](https://www.swiftbysundell.com/tips/building-an-observable-type-for-swiftui-views/)
## Dismiss
Instead of passing a binding of presentation to a presented view we can use environment value `dismiss`
```swift
struct MessageDetailsView: View {
    var message: Message
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack {
            //...
            Button("Dismiss") {
                dismiss()
            }
        }
    }
}
```
## NotificationCenter
Notification Center worth wile to observe in swiftUI views since sometimes we can understand valuable information by observing it. for instance in swiftUI apps instead of watch app cycle in a custom defined App delegates we can check app entered background or not by observing `UIApplication.didEnterBackgroundNotification` 
Any Combine publisher can be observed by `.onReceive`[[Combine+SwiftUI]]. Also it's possible to develop our extension for better syntax and readability. In case of notifications it's possible to do something like this:
```swift
extension View {
    func onNotification(
        _ notificationName: Notification.Name,
        perform action: @escaping () -> Void
    ) -> some View {
        onReceive(NotificationCenter.default.publisher(
            for: notificationName
        )) { _ in
            action()
        }
    }

    func onAppEnteredBackground(
        perform action: @escaping () -> Void
    ) -> some View {
        onNotification(
            UIApplication.didEnterBackgroundNotification,
            perform: action
        )
    }
}
```
## View Styles
`ViewModifiers` are general ways we can use to style a view without considering its specific type. They also can contain states and have properties and lifecycles.
When it's come to specific type it's possible to extend that type and add a function which modifies it. for example
```swift
extension Button {
	func withSomeStyle() -> some View {} 
}
```
However there is a better option here and it's by using `ButtonStyle`. 
* We can apply the style on the tree hierarchy of views
* There is a configuration parameter that we can use to gain information and have a better customization.
```swift
struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
	    configuration.label
            .padding(10)
            .background {
            Capsule().fill(.red)
        }
    }
}
```
There are also styles for components, like: toggles, pickers, lists, progress views, labels ...
## UIKit interoperability
### View Representable
```swift
struct EventDetailsComponent: UIViewRepresentable {
    var state: State

    func makeUIView(context: Context) -> MyView {
        myView()
    }

    func updateUIView(_ view: MyView, context: Context) {
        //update my view with the state
    }
}
```
* Make sure to pass a view configuration in `updateUIView`. Avoid passing configurations in `makeUIView`. *SwiftUI may reuse underlying view as much as possible so we shouldn't assume that each time SwiftUI recreate the `UIViewReprestentable` the underlying view is initialized in `makeUIView`*
* always lazily create view in `makeUIView`
### Coordinator
Define a custom coordinator when it's necessary to ==capture an object when creating uiViews==. an example can be adding a target to a button which requires a class and a method of that class.
```swift
struct ButtonComponent: UIViewRepresentable {
// ...
	func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
	func makeUIView(context: Context) -> UIView {
        let button = EventSchedulingButton()
        button.addTarget(context.coordinator,
            action: #selector(Coordinator.callHandler),
            for: .touchUpInside
        )
        return button
    }
}

extension ButtonComponent {
    class Coordinator {
        var handler: (() -> Void)?

        @objc func callHandler() {
            handler?()
        }
    }
}
```
### View Controller Representable
If you are sharing a view model between a view and a `UIViewControllerRepresentable` that it's used internally you may want to pay attention to not calling a method or invoke an event multiple times.
### HostingViewController
HostingViewController is for embedding swiftUI views into UIViews.
```swift
private func makeHeader() -> UIHostingController<EventHeaderView> {
        let headerView = EventHeaderView(viewModel: viewModel)
        let headerVC = UIHostingController(rootView: headerView)
        headerVC.view.translatesAutoresizingMaskIntoConstraints = false
        return headerVC
    }
```
In order to have a synced state between the swiftUI view and the UIView it's better to make an ObservableObject viewModel. Then inject it to the both views. state observations happened automatically in swiftUI views with `@Published`, `ObservableObject`. In the UIView also it's possible to observe state changes by using `sink` on `@Publishe` projected value.
### App Delegate with SwiftUI
```swift
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {}

@main
struct MyApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        //...
    }
}
```
## Swift features that power SwiftUI
* returning opaque types with `some`
	* opaque types can be protocols with associate types or reference to Self
* Omitted return keyword 
* Function builders
* Property wrappers
### Swift 5.3
* Implicit self capturing
* Automatic ViewBuilder behavior on swiftUI `body`
	* In order to use if else and switches inside a computed property or function that returns `some view` we have to use explicitly  `@ViewBuilder` in the beginning of them.
* `switch` inside view builders
* Multiple trailing closures
* Typed-based program entry points. `@main`
## Avoiding ...
### Massive SwiftUI views
* Extension on views and ViewStyles.
* Encapsulating into a smaller views
* Moving some view logic out of the main view body. Using factories
### AnyView
view type is important for determine if a view needs to be recreated or not.* *For example to AnyView wrapped views will always look completely identical.* Avoid using AnyView as much as possible. instead considering
* `@ViewBuilder`: if we have conditional logic in view declaration.
* Use generic view type if the view has a generic content
## Lifecycle of views
we generally can't have any assumption in our code about when views are being created. we should use swiftUI methods that is provided for us
* `onAppear` and `task` instead of inside the view declaration.
* `onReceive` for setting up publishers
* providing correct setup in `UIViewPresentable` or `UIViewControllerPresentable` [[#View Representable]]
## Views that depend on optionals
```swift
private var profileView: some View {
	//instead of
	if let user = loginManager.loggedInUser {
	    ProfileView(user: user)
	}
	//we can use this
    loginManager.loggedInUser.map(ProfileView.init)
}
```
## Cool Example with modifier
```swift
struct Validation<Value>: ViewModifier {
    var value: Value
    var validator: (Value) -> Bool

    func body(content: Content) -> some View {
        // Here we use Group to perform type erasure, to give our
        // method a single return type, as applying the 'border'
        // modifier causes a different type to be returned:
        Group {
            if validator(value) {
                content.border(Color.green)
            } else {
                content
            }
        }
    }
}
```
```swift
TextField("Username", text: $username)
    .modifier(Validation(value: username) { name in
        name.count > 4
    })
```
## Bindable list item
```swift
struct TodoItem: Identifiable {
    let id: UUID
    var title: String
}

struct TodoList: View {
    @Binding var items: [TodoItem]
    
    var body: some View {
            VStack {
                List {
	                //here we're binding item title to a textfiels
	                //note that it's an element in an array
				    ForEach($items) { $item in
				        TextField("Title", text: $item.title)
				    }
				}
                TodoItemAddButton { newItem in
                    items.append(newItem)
                }
            }
        }
    }
}
```
## Multiple Views in content builder
If there is a generic content builder in our swiftUI view and we want it to be capable of accepting multiple views then we can define with `@ViewBuilder`.
```swift
struct OnboardingCarousel: View {
    var body: some View {
	    //we're passing multiple views here
        Carousel {
            WelcomeCard()
            GettingStartedCard()
            ExploreCard()
        }
    }
}
struct Carousel<Content: View>: View {
	var content: () -> Content
	//@ViewBuilder make it possible to pass multiple views, conditional statements and etc
	init(@ViewBuilder content: @escaping () -> Content) {
	    self.content = content
	}
}
```
## Alternative For Wrapping
we can use view extension for better syntax
```swift
struct Wrapper<Input: View, Output: View>: View {
    var content: Input
    var condition: () -> Bool

    var body: some View {
        if condition {
            content
        } else {
            content.background(Color.red)
        }
    }
}

extension View {
    func wrapper<T: View>(
        apply modifier: @escaping (Self) -> T
    ) -> some View {
        Wrapper(content: self, modifier: modifier)
    }
}

//example
Image(systemName: iconName)
	.foregroundColor(.white)
	.wrapper { $0.hidden() }
```
## Preview Tips
### Mock Bindings
If we define bindings as `.constant` the changes that ui elements may have on them is not going to be reflected. This extension will help us to fix that problem.
```swift
extension Binding {
    static func mock(_ value: Value) -> Self {
        var value = value
        return Binding(get: { value }, set: { value = $0 })
    }
}
```
### Useful Preview modifiers
```swift
.colorScheme(.dark)
.previewDevice("iPhone 11")
        .environment(\.sizeCategory, .accessibilityExtraExtraExtraLarge)
```

## SwiftUI debugging
```swift
extension View {
    func debugAction(_ closure: () -> Void) -> Self {
        #if DEBUG
        closure()
        #endif

        return self
    }
}

extension View {
    func debugModifier<T: View>(_ modifier: (Self) -> T) -> some View {
        #if DEBUG
        return modifier(self)
        #else
        return self
        #endif
    }
}
```