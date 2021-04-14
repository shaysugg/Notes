# Design Patterns

## MVC
### - Delegation Pattern
Apple frameworks use it a lot. *Ex: UICollectionView delegates - UICollectionView datasource.*

### - Strategy Pattern
 ![[Screen Shot 2021-02-19 at 9.27.40 PM.png]]
* instead of defining **objects** directly define their **purposes** and **strategies**.
* then each object that impeliments the same strategy in itself can be use.
* objects with the same strategy are interchangeable.

### - Singlation Pattern
```swift
class A {
static let shared = A()
}
```
* use it when more than one instance of class is not logical or one instance of a class mostly getting used. *Ex: FileManager.defaults, UserDefaults.standard*
* should be very careful when using it. *TODO: See John Sundell article about it*

### - Memento Pattern
![[Screen Shot 2021-02-19 at 9.42.45 PM.png]]
* **originator**: original object that we working with
* **memento**: transformed originator in a format that can be saved
* **care taker**: transform originator to memento for saving it and transform memento to originator for presenting it
* *Ex: JSON Decoding and Encoding*

### - Observer Pattern
![[Screen Shot 2021-02-19 at 9.48.33 PM.png]]
* *Ex: Combine Publishers, RXSwift Relays ...*

### - Builder Pattern
![[Screen Shot 2021-02-19 at 9.50.46 PM.png]]
* **director**: accepts inputs.
* **product**: a complex object.
* **builder**: has multiple steps and director uses it steps to build a product.
* When building an object requires **multiple steps** and can’t be achieved in just one step aka one init.

### - Factory Pattern
*  define a separate class for creating an object that has a complicated creation process.
*  for isolate object creation logic within its own init.


### - Adapter Pattern
![[Screen Shot 2021-02-24 at 8.29.39 PM.png]]
* in picture above legacy object can't get changed and confirm to the protocol. so wee use an adapter that uses legacy object and conform it to our protocol.
* **Wrappers**
* mostly use for third party libraries that we **can't change or modify** them so we write a wrapper around them to implement the exact functionality we need.
* It also great for preventing classes to use very underlying classes and instead only use an adaption of it that handle their needs. 

### - Iterator pattern
* conform an object to `IteratorProtocol` (`Sequence`) when it holds a **sequence of elements** and you want to use `for`, `map`, `filter`, ... on them
* you need to implement `makeIterator()` when you conforming to the protocol.
```swift
class A: Sequence {
	 private let array = [String]()  //holds sequence of elements
	 func makeIterator() -> some IteratorProtocol {
	 	array.makeIterator()
	 }
 }
```

### Prototype Pattern
* allows an object to copy itself.
* mostly used when we want to a **class** act as a **struct** and we can change its values without changing its reference values.

```swift
class C {

 var int: Int
 
 init(int: Int) {
 	self.int = int
 }
}

let c1 = C(int: 5)
let c2 = c1
c2.int = 10

print(c1.int) //prints 10 (but we don't want it)
``` 
if we want to not change the c1 values by changing c2 we need a **copy** of it. we can impeliment it like this:
```swift
      
//this can be used on any class!
protocol Copying: class {
 	init(\_ prototype: Self)
}

extension Copying {
 func copy() -> Self {
 	type(of: self).init(self)
 }
}


class C: Copying {

 required convenience init(\_ prototype: C) {
 self.init(int: prototype.int)
 }

 var int: Int

 init(int: Int) {
 	self.int = int
 }
}

let c1 = C(int: 5)
let c2 = c1.copy()
c2.int = 10

print(c1.int) //prints 5. (yay!)
```

### State pattern
![[Screen Shot 2021-03-18 at 8.15.20 PM.png]]
* **context** has different states
* **state protocol** in common properties that each **state** should have
* **concrete states** define how the context should act
* where logic of applying a state should be Implement? we can implement it either in **context or states itself** *(it's a lil bit tricky)*

### Multicast Delegate
![[Screen Shot 2021-03-30 at 1.38.45 PM.png]]
* use for one to many delegates
* **Object needing delegates** is a object that has multiple delegates
* **delegate protocol** defines what requirements concrete delegates should have
* **Conrete delegate**s are objects that implement the delegate.
* **Multicast delegate** is an object that holds all the delegates and invoke them.
* *this section is a hard to explain see original article more info.*

### Facade Pattern
![[Screen Shot 2021-03-30 at 1.58.22 PM.png]]
* **Fecade** provides an easy to use functions which makes interacting with complex dependecies much more simpler.
* ex: Fecade is a simple Content Loader which use complex Network API and Data Base API for fetching data.

### Flyweight Pattern
![[Screen Shot 2021-03-30 at 2.03.44 PM.png]]
* like singlation pattern but we have multiple singlations.
* ex: predefined swiftUI Colors