## Objective-C -> Swift
We need a bridge file for it. 
1) Create a .h file
2) Import what we want to use in our Swift code.
``` Objective-C
#import "ViewController.h"
```
3) Go to our `App target -> Build Settings -> Objective-C Bridging Header` and add the file path there. like: `$(SRCROOT)/path/to/bridge/Bridge-File.h`
## Swift -> Objective-C
Just add the `@objc` keyword before type.
```Swift
@objc extension Something {}
```
### List of Swift features that do not support bridging
- Structs
- Enums, unless they have an Int raw value type
- Tuples
- Global functions
- Type aliases
- Variadics (e.g. ... splat operator)
- Nested types
- Curried functions
- Some generic stuff
- Throwable functions
### Different Names in Objective-C
```Swift
@objc(colorForKind:) // convinient objective-c naming
static func color(for kind: FeedItemKind) -> UIColor {
	kind.color
})
```

## Improving Tips
### Swift enums
for make objective-c enums to looks more like swift enums replace `enum` to:
```Swift
NS_CLOSED_ENUM(NSInteger, MyEnumName) {
	//cases
}
```