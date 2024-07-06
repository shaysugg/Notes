## Types
- `Double` represents a 64-bit floating-point number.
- `Float` represents a 32-bit floating-point number.
In situations where either type would be appropriate, `Double` is preferred.

Use the `Int` type for all general-purpose integer constants and variables in your code, even if they’re known to be nonnegative
## Error Handling
* Handle different types of errors that are enumerations cases
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
* You can also use where on catch blocks for additional condition checking
```swift
//...
catch ComparisonError.bigger(let number) where number != 0 {
	//...
}
```
* Error handling based on types
```swift
catch let unexpected as UnexpectedError {
	// UnexpectedError is struct
	log(unexpected.reason)
} catch is UnexpectedError {
	
}
```
More on conditional error catching: [Article](https://sarunw.com/posts/different-ways-to-catch-throwing-errors-in-swift/)
### Clean up on errors
We can use defer to do necessary clean ups after throwing errors
``` swift
func processFile(filename: String) throws {
    if exists(filename) {
        let file = open(filename)
        defer {
            close(file)
        }
        while let line = try file.readline() {
            // Work with the file.
        }
        // close(file) is called here, at the end of the scope.
    }
}
```
## Operations
### Comparing tuples
Different values that exist in the two tuples are going to be compared by order.
```swift
(1, "zebra") < (2, "apple")   // true because 1 is less than 2; "zebra" and "apple" will not be compared
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
## Methods
* regular methods
* mutating methods (for enum and structs)
* static methods (type methods)
* class methods (type methods for class that allow subclasses to override them)
## Subscripts
`subscript` are ways to access a type properties by providing a parameter, the same way that array elements is accessed by and indexes or dictionary elements with keys.
```swift
struct TimesTable {
    let multiplier: Int
    subscript(index: Int) -> Int {
        return multiplier * index
    }
}
let threeTimesTable = TimesTable(multiplier: 3)
print("six times three is \(threeTimesTable[6])")
```
### Read-write subscripts
```swift
subscript(index: Int) -> Int {
    get {
        // Return an appropriate subscript value here.
    }
    set(newValue) {
        // Perform a suitable setting action here.
    }
}
```
* A type can have multiple subscripts
* subscripts can have any form of parameters. They also can have multiple parameters
* It's possible to have subscripts on types (static subscript)

## Initializers
### Structs and enums
* structs and enums can have custom initializer.
* If you define a custom initializer you will not have access to default (member wise) initializer.
* In an initializer for referring to other initializer you can use `self.init()`
### Classes
For classes we have three types of initializers
#### Designated initializers
`init(paramenters)`
These are the default initializers that we have in classes.
* They have to initialize all of the class properties.
* If the class is subclassed from another class they should call the `super.init` after their value initializations.
#### Convenience Initializers
`convenience init(parameters)`
* They should first, call to one of the same class initializers with `self.init()`
* The chain of initializers in convenience initializers should ultimately call a designated initializer.
* They can't call their super class initializers
#### Required Initializers
`required init(parameteres)`
* The required init should be implemented by all the subclasses of the current class
* It's not necessary to provide an implementation for required init as long as subclasses implementations are satisfy the initializer requirements
#### Example of class initializers
```swift
class Food {
    var name: String
    init(name: String) {
        self.name = name
    }
    convenience init() {
        self.init(name: "[Unnamed]")
    }
}

class RecipeIngredient: Food {
    var quantity: Int
    init(name: String, quantity: Int) {
        self.quantity = quantity
        super.init(name: name)
    }
    override convenience init(name: String) {
        self.init(name: name, quantity: 1)
    }
}
```
#### Inheritance initializers
>**Rule 1**
If your subclass doesn’t define any designated initializers, it automatically inherits all of its superclass designated initializers.
**Rule 2**
If your subclass provides an implementation of _all_ of its superclass designated initializers — either by inheriting them as per rule 1, or by providing a custom implementation as part of its definition — then it automatically inherits all of the superclass convenience initializers.
### Failable Initializers
enums and structs and classes all can have failable initializers.
```swift
class Product {
    let name: String
    init?(name: String) {
        if name.isEmpty { return nil }
        self.name = name
    }
}

class CartItem: Product {
    let quantity: Int
    init?(name: String, quantity: Int) {
        if quantity < 1 { return nil }
        self.quantity = quantity
        super.init(name: name)
    }
}
```
### Default value with closures
Instead of providing values for properties that need some calculation in initializers, it's possible to write the value with closures.
In the below example defining an init will remove the default init that compiler generates for our struct. we perform the calculation for `someProperty` in a closure and use default generated init for other properties instantiation 
```swift
struct SomeClass {
    let someProperty: Int = {
	    //... some calculation
        return someValue
    }()
    //...other properties
}
```
## Extensions
Extensions can add new functionality to a type, but they can’t override existing functionality.
## Protocols
* If you specify `{ get }` for a property of a protocol that means it should be gettable, also it has the option of being settable, whereas if you specify `{ get set }` that means it should be gettable and settable.
* If a method is being used in value types and it mutates states then you should define it with `mutating`, the implementations can decide to omit the mutating or not based on their context
* You can define initializers inside protocols, any class that conforms to it should implement that protocol `init` with `required`

Weird example of Associated types
```swift
protocol SuffixableContainer: Container {
    associatedtype Suffix: SuffixableContainer where Suffix.Item == Item
```

## Opaque and Boxed Types
* opaque types = `some`
* boxed types = `any` or protocol names
* Opaque types are kind of opposite of generic types (instead of being generic internally and specialized externally, they are specialized internally and exposed as generics externally)
### Example of Opaque Type benefits
* boxed type
```swift
func protoFlip<T: Shape>(_ shape: T) -> Shape {
	//
}

let protoFlippedTriangle = protoFlip(smallTriangle)
let sameThing = protoFlip(smallTriangle)
protoFlippedTriangle == sameThing  // Error
```

* opaque type
```swift
func protoFlip<T: Shape>(_ shape: T) -> some Shape {
	//
}

let protoFlippedTriangle = protoFlip(smallTriangle)
let sameThing = protoFlip(smallTriangle)
protoFlippedTriangle == sameThing // valid
//both has the same concreate type but it's unknwon
```

### Another example
```swift
protocol Container {
    associatedtype Item
}

extension Arry: Container {}

// Error: Protocol with associated types can't be used as a return type.
func makeProtocolContainer<T>(item: T) -> Container {
    return [item]
}


// Error: Not enough information to infer C.
func makeProtocolContainer<T, C: Container>(item: T) -> C {
    return [item]
}

//valid
func makeProtocolContainer<T>(item: T) -> some Container {
    return [item]
}
```
### Reference cycles examples
#### Both objects allowed to be nil
This scenario is best resolved with a weak reference.
```swift
class Person {
    let name: String
    var apartment: Apartment?
    deinit { print("\(name) is being deinitialized") }
}

class Apartment {
    let unit: String
    weak var tenant: Person?
    deinit { print("Apartment \(unit) is being deinitialized") }
}

var john: Person?
var unit4A: Apartment?

john = Person(name: "John Appleseed")
unit4A = Apartment(unit: "4A")

john!.apartment = unit4A
unit4A!.tenant = john

john = nil
// Prints "John Appleseed is being deinitialized"

unit4A = nil
// Prints "Apartment 4A is being deinitialized"
```
#### One is allowed to be nil the other not
This scenario is best resolved with an unowned reference.
```swift
class Customer {
    let name: String
    var card: CreditCard?

    deinit { print("\(name) is being deinitialized") }
}

//credeit card ALWAYS have to be related to a customer
class CreditCard {
    let number: UInt64
    unowned let customer: Customer
    deinit { print("Card #\(number) is being deinitialized") }
}

var john: Customer?
john = Customer(name: "John Appleseed")
john!.card = CreditCard(number: 1234_5678_9012_3456, customer: john!)

john = nil
// Prints "John Appleseed is being deinitialized"
// Prints "Card #1234567890123456 is being deinitialized"
```
#### Both are not allowed to be nil
It’s useful to combine an unowned property on one class with an implicitly unwrapped optional property on the other class.
```swift
class Country {
    let name: String
    var capitalCity: City!
}


class City {
    let name: String
    unowned let country: Country
}
```
*maybe more deeper look later?*
