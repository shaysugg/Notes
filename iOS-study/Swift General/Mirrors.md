Assume we have this protocol
```Swift
protocol Colors {
	var color1: UIColor { get set }
	var color2: UIColor { get set }
	var color3: UIColor { get set }
	var allColors: [UIColor] { get set }
}
```

 what if we want to `allColors` be automatically computed? we do something like this right?
 
```Swift
extensions Colors {
	var allColors: [UIColor] { [color1, color2, color3] }
}
```

**But what if we add a new color like color4 to the protocol? we need to refactor our extension.**

Instead of writing colors manually in the allColors array we can use Mirror API to reflect our code and see what variable our protocol has and which of them are `UIColor`.

```Swift
extensions Color {
	var allColors: [UIColor] {
		let mirror = Mirror(reflecting: self)
		return mirror.children.compactMap {$0.value as? UIColor} 
	} 
}
```

[Original Article](https://holyswift.app/the-trade-offs-of-using-mirror-api-to-do-code-reflection-in-swift)
