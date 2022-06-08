* Swift Charts 
```swift
Chart(data) { task in
	BarMark(x:, y:)
	//or
	LineMark(x:, y:) 
}
```
## Navigation Views
### Navigation Stack
Destinations are now Data Driven:
```swift
//assume item is Foo type
NavigationStack {
	NavigationLink(value: item) { Label() }
}
.navigationDestination(for: Foo.self) { item in
//return coresponding view ...
}
```
NavigationStack could use `path` parameter to save stack state in an array.
  
### Navigation Split View
>great for value based navigations
```swift
NavigationSplitView {
	//list of bar leading items
} detail: {
	//trailing view for each of items.
}
```
### UIScene API
* windows (mostly for macos)
* MenuBarExtra 