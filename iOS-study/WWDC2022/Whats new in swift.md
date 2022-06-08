## Swift Packages
* **Command Plugins:** conform to `CommandPlugin` and then implement the `Perform Command` function which define which tool we want to invoke.
* **Build Tool Plugin**

Concurrency
* `distributed actor`
* Async Algorithms
* Swift Concurrency view in instruments

## Language
* `if let something = something` now is `if let something`
* regex strings and RegexBuilders
* Protocol usage as generics or direct type
	* **generics**: `func<T: protocol>(a: T)`
		Something that conforms to Protocol
		Apparently is a preferred way (why?)
	* **direct types**: `func(a: any Protocol)`
		A **box** that contents conform to Protocol
		should be used with `any` keyword from now on
* Protocols Primary Associated Types `Protocol<Element>`
* `some` keyword instead of Generic Signature: 
	`func<T>(a: T)` -> `func(a: some T)`

[Original Video 🎥](https://developer.apple.com/videos/play/wwdc2022/110354/)