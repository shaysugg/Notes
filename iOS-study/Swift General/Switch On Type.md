When enums are not efficient and we want to use protocols or types.
We can check the type in switch cases with `case let foo as Foo` 
```Swift
protocol Action {}

struct FirstAction: Action {}
struct SecondAction: Action {}

func decideBasedOn(action: Action) {
	switch action {
	case let action as FirstAction:
	//...
	case let action as SecondAction:
	//...
	}
}
```