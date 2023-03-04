By conforming to the `Comparable` protocol we can create ranges. (`Int` and `Float` already conformed to it)
``` Swift
enum Number: Comparable {
  case zero, one, two, three, four
}

let shortForm = Number.one ..< .three
```

## Looping over a range
By conforming to Strideable.

```Swift
extension Number: Strideable {
  public func distance(to other: Number) -> Int {
    other.rawValue - rawValue
  }

  public func advanced(by n: Int) -> Number {
    Number(rawValue: (rawValue + n) % 4)!
  }
  
	public typealias Stride = Int
}


for i in Number.one ..< .three {
	print(i) 
}
```