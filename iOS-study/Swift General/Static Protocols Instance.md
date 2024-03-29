# Static Protocols Instance
[Article](https://www.swiftbysundell.com/articles/using-static-protocol-apis-to-create-conforming-instances/)

Assume In a <mark>protocol</mark> we want to have some predefined objects that already conforms to that protocol and instead of creating an instance each time like `Example()` we want to refer them like `.example`

```swift
protcol Chef {
	func cook()
}

class PizzaChef: Chef {
  func coock() {
    print('cooking pizza 🍕') 
  }
}

class KebabChef: Chef {
  let hasGrilledTomato: Bool
  
  init(hasGrilledTomato: Bool) {
    this.hasGrilledTomato = hasGrilledTomato
  }
  
  func coock() {
  	print('cooking kebab 🐄')
    if hasGrilledTomato {print('also griling tomatos 🍅')}
  }
}
```

For having `PizzaChef` and `KebabChef` as an instance of `Chef` we need to:

```swift
extension Chef where Self == PizzaChef {
  static var pizzaCheff: Self { Self() }
}

extension Chef where Self == KebabChef {
  static func kebabChef(grilingTomatos: Bool) {
    KebabChef(hasGrilledTomato: grilingTomatos)
  }
}
```

then we can use them like this:

```swift
struct Kitchen	{
  let chef: Chef
}

let kitchen = Kitchen(chef: .pizzaCheff)
//or
let kitchen = Kitchen(chef: .kebabChef(grilingTomatos: true))
```

