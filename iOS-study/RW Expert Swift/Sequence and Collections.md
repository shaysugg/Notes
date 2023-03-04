## Introduction
![Sequence and Collections](attachments/sequence-collection.png)

## Sequence
* **Sequence**: This is the most primitive type in the hierarchy that lets you iterate through a list of values. It makes **no guarantee about being able to revisit an item**. Although a conforming type could be a collection like an array, it could also be a stream of data from a network socket or a sequence of random numbers that never repeat. A type adopting Sequence can be immutable but must vend an associated mutable type that conforms to `IteratorProtocol`.
* **IteratorProtocol**: This behind-the-scenes protocol knows how to get the next element and returns nil when it’s done. It’s possible to use an iterator type directly, but usually, the compiler creates one for you when you use a `for` statement.
``` Swift
struct Countdown: Sequence {
  let start: Int
  func makeIterator() -> CountdownIterator {
    CountdownIterator(count: start)
  }
}

struct CountdownIterator: IteratorProtocol {
	var count: Int
	mutating func next() -> Int? {
	guard count>=0 else{
		return nil
    }
    defer { count -= 1 }
    return count
	} 
}
```
### More easier ways ...
*  Using AnySequence, AnyIterator. a **functional** implementation.
```Swift
let anotherCountdown5 = AnySequence<Int> { () -> AnyIterator<Int> in
  var count = 5
  return AnyIterator<Int> {
    defer { count -= 1}
    return count >= 0 ? count : nil
  }
}
```
* UnfoldFirstSequence and UnfoldSequence
``` Swift
//UnfoldFirstSequence
let countDownFrom5 = sequence(first: 5) { value in
  value-1 >= 0 ? value-1 : nil
}
//UnfoldSequence
let countDownFrom5State = sequence(state: 5) { (state: inout
Int) -> Int? in
  defer { state -= 1 }
  return state >= 0 ? state : nil
}
```
* stride
``` Swift
for value in stride(from: 5, through: 0, by: -1) {
  print(value)
}
```
## Collections
 **Collection**: All collections are sequences, but Collection adds a guarantee that you can **revisit items using an index type**. If you have an index, you can look up an element in constant time O(1).
``` Swift
struct FizzBuzz: Collection {
  typealias Index = Int

  var startIndex: Index { 1 }
  var endIndex: Index { 101 }
  func index(after i: Index) -> Index { i + 1 }
  
  subscript (index: Index) -> String {
  precondition(indices.contains(index), "out of 1-100")
  switch (index.isMultiple(of: 3), index.isMultiple(of: 5)) {
  case (false, false):
    return String(index)
  case (true, false):
    return "Fizz"
  case (false, true):
    return "Buzz"
  case (true, true):
    return "FizzBuzz"
  }

}
```
### BidirectionalCollection
This spices up a collection to allow you to **traverse** it both forward and backward by advancing the index appropriately.
``` Swift
extension FizzBuzz: BidirectionalCollection {
	func index(before i: Index) -> Index {
		return i - 1 
	}
}
```
### RandomAccessCollection
This allows a collection to **traverse** elements in any order in constant time. It lets you update the index and measure distances between indices in constant time.
``` Swift
extension FizzBuzz: RandomAccessCollection { }
```
when we make a collection a RandomAccessCollection, we need to implement a `index(_:offsetBy:)`. However, in this case, because you chose an `Int` to be your index type and because integers are `Strideable` and `Comparable`, you get the implementation for free.

### MutableCollection
This refines collections that let you mutate elements through an index. The mutation is all about **poking** individual elements. Importantly, it does not imply the ability to add and remove elements.
```Swift
subscript(position: Index) -> String {
  get {
	    //returns some string base on position
	}
	
  set {
		//we have a newValue variable in here
	    //change something base on position and newValue
	}
}
```
The subscript method makes a `RandomAccessCollection`, and the setter makes a `MutableCollection`.
### RangeReplaceableCollection 
These collections let you modify whole subranges at a time. This conformance lets you **delete**, insert **and** **append** elements.