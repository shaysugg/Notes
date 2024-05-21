## Types
- `Double` represents a 64-bit floating-point number.
- `Float` represents a 32-bit floating-point number.
In situations where either type would be appropriate, `Double` is preferred.

Use the `Int` type for all general-purpose integer constants and variables in your code, even if they’re known to be nonnegative
## Error Handling
Handle different types of errors
```swift
do {
    try makeASandwich()
    eatASandwich()
} catch SandwichError.outOfCleanDishes {
    washDishes()
} catch SandwichError.missingIngredients(let ingredients) {
    buyGroceries(ingredients)
}
```

## Operations
### Comparing tuples
Different values that exist in the two tuples are going to be compared by order.
```swift
(1, "zebra") < (2, "apple")   // true because 1 is less than 2; "zebra" and "apple" aren't compared
(3, "apple") < (3, "bird")    // true because 3 is equal to 3, and "apple" is less than "bird"
(4, "dog") == (4, "dog")      // true because 4 is equal to 4, and "dog" is equal to "dog"
```
### One side ranges
One side of ranges can be used as subscripts when ending and beginning of the collection that they're being used on is clear.
```swift
for name in names[2...] {
    print(name)
}

for name in names[...2] {
    print(name)
}
```
When they're not being used as subscript, They means negative or positive infinity.
## String
unicode scalars
```swift
let dollarSign = "\u{24}"        // $,  Unicode scalar U+0024
let blackHeart = "\u{2665}"      // ♥,  Unicode scalar U+2665
let sparklingHeart = "\u{1F496}" // 💖, Unicode scalar U+1F496
```
Using `'` and `"` in strings with `/`
```swift
let wiseWords = "\"Imagination is more important than knowledge\" - Einstein"
```
It's also possible to ignore all of the special characters by putting a `#` at the beginning of string literal
```swift
let threeMoreDoubleQuotationMarks = #"""
Here are three more double quotes: """
"""#
```
Swift’s `String` type is a _value type_.
### Characters and Indexing
Every instance of Swift’s `Character` type represents a single _extended grapheme cluster_. An extended grapheme cluster is a sequence of one or more Unicode scalars that (when combined) produce a single human-readable character.
```swift
let eAcute: Character = "\u{E9}" // é
let combinedEAcute: Character = "\u{65}\u{301}" // e followed by ́
//These are both a single character and represent é
```
These character format allows the string count to become what we naturally expect instead of being number of unicode scalars. Additionally it will effect the subscripting behaviors. It's not possible to directly access a character with a raw number. Instead It's required to use `String.Index`es.  For example
```swift
let greeting = "Guten Tag!"
greeting[greeting.startIndex]
// G
greeting[greeting.index(before: greeting.endIndex)]
// !
greeting[greeting.index(after: greeting.startIndex)]
// u
let index = greeting.index(greeting.startIndex, offsetBy: 7)
greeting[index]
// a
```
string indices can be useful for iterations
```swift
for index in greeting.indices {
    print("\(greeting[index]) ", terminator: "")
}
// Prints "G u t e n   T a g ! "
```
## Substring and String Memory graph
![[substring-and string-memory graph.png]]
### Comparing Strings
`hasPrefix(_:)` and `hasSuffix(_:)` are useful when we want to compare beginning and the end of two strings
## Collections
### Arrays
Assign a range
```swift
shoppingList[4...6] = ["Bananas", "Apples"]
```
### Sets
All set elements should be `Hashable`. A hash value is an `Int` value that’s the same for all objects that compare equally, such that if `a == b`, the hash value of `a` is equal to the hash value of `b`.
#### Conforming to `Hashable`
```swift
    static func == (lhs: GridPoint, rhs: GridPoint) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(x)
        hasher.combine(y)
    }
```
#### Set Operations
![[set-oprrations.png]]
## Dictionary
You can turn a dictionary keys or values to an array like:
```swift
let airportCodes = [String](airports.keys)
```
You can also use `sorted()` if you want to have the same order each time you create the array.
## Control Flows
* `stride()` quickly can make incremental sequences
* `repeat-while` equivalent to `do-while` in other languages
### switch on tuples
```swift
let anotherPoint = (2, 0)
switch anotherPoint {
case (let x, 0):
    print("on the x-axis with an x value of \(x)")
case (0, let y):
    print("on the y-axis with a y value of \(y)")
case let (x, y):
    print("somewhere else at (\(x), \(y))")
}
```
Note that not only tuple values can be checked here but also it's possible to ignore part of the values or access to those values with constant definition.
#### Where on switches
`where` is really useful for avoiding writing **nested if statements** inside switches which is make the readability difficult.
```swift
let yetAnotherPoint = (1, -1)
switch yetAnotherPoint {
case let (x, y) where x == y:
    print("(\(x), \(y)) is on the line x == y")
case let (x, y) where x == -y:
    print("(\(x), \(y)) is on the line x == -y")
case let (x, y):
    print("(\(x), \(y)) is just some arbitrary point")
}
```
#### Multiple OR in switch cases
By using comma separated definition in cases
```swift
switch someCharacter {
case "a", "e", "i", "o", "u":
    print("\(someCharacter) is a vowel")
case "b", "c", "d", "f", "g", "h", "j", "k", "l", "m",
    "n", "p", "q", "r", "s", "t", "v", "w", "x", "y", "z":
    print("\(someCharacter) is a consonant")
default:
    print("\(someCharacter) isn't a vowel or a consonant")
}
```
#### which break?
Assume we have a while loop with a switch inside if we write a break inside switch cases it may not be clear that we tried to break from loop or from the switch. In order to fix that we can use labeled statements
```swift
gameloop: while true {
   switch something {
	   case somethingElse:
		   // break ???
		   break gameloop //more clear way
   }
}
```
### Check API Availability
```swift
//if #available(<#platform name#> <#version#>, <#...#>, *)
if #available(macOS 10.12, *)
```
## Closures
**Global and nested functions** are actually special cases of **closures**! In fact closure has either one of these three forms.
- Global functions are closures that have a name and don’t capture any values.
- Nested functions are closures that have a name and can capture values from their enclosing function.    
- Closure expressions are unnamed closures written in a lightweight syntax that can capture values from their surrounding context.
### Complete syntax of closures expression
```swift
// { (<#parameters#>) -> <#return type#> in
//   <#statements#>
// }
```

* Closures are reference types
* `@escaping`closures:
>A closure is said to _escape_ a function when the closure is passed as an argument to the function, but is called after the function returns.
## Enums
* It's possible to write recursive enums
```swift
enum ArithmeticExpression {
    case number(Int)
    indirect case addition(ArithmeticExpression, ArithmeticExpression)
    indirect case multiplication(ArithmeticExpression, ArithmeticExpression)
}

let product = ArithmeticExpression.multiplication(sum, ArithmeticExpression.number(2))
```
indirect also can be applied on the enum declaration for allowing all the cases to have recursive values
## Properties
> If a property marked with the `lazy` modifier is accessed by multiple threads simultaneously and the property hasn’t yet been initialized, there’s no guarantee that the property will be initialized only once.
### didSet and willSet
```swift
class StepCounter {
    var totalSteps: Int = 0 {
        willSet(newTotalSteps) {
            print("About to set totalSteps to \(newTotalSteps)")
        }
        didSet {
            if totalSteps > oldValue  {
                print("Added \(totalSteps - oldValue) steps")
            }
        }
    }
}
let stepCounter = StepCounter()
stepCounter.totalSteps = 200
// About to set totalSteps to 200
// Added 200 steps
stepCounter.totalSteps = 360
// About to set totalSteps to 360
// Added 160 steps
stepCounter.totalSteps = 896
// About to set totalSteps to 896
// Added 536 steps
```