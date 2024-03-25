## Sorting Collections
### Using Operators
```Swift
mySequence.sorted(by: >)
//better syntax compare to
mySequence.sorted { $0 > $1 }
```
### Sort based on `keypath`s Util
```Swift
extension Sequence {

  func sorted<T: Comparable>(
    by keyPath: KeyPath<Element, T>,
    using: (T, T) -> Bool = (<)
  ) -> [Element] {
    sorted { a, b in
      a[keyPath: keyPath] < b[keyPath: keyPath]
    }
  }
}

todos.sorted(by: \.name)
```
## Array Slices
```Swift
let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
let firstFive = numbers[..<5]
```
the firstFive has the `ArraySlice` type. That's a reference to the original array without needing to copy the whole array. 
More on slice Memory Managements: [[Sequence and Collections#Slice Memory Management]]
### Using `prefix` and `suffix`
It's preferred to use `prefix` instead of `..<5` mainly because if there is not at least five items we have an out of range index error.
```Swift
items.prefix(5)
```
### `drop`s
drops also return slices
### `split` and `components`
```Swift
let lines = text.components(separatedBy: "\n")
let lines = text.split(separator: "\n")
```
* `split` returns `Substring` but `components` returns `[Strings]`. Note that substring is more memory efficient because it act as slice for arrays.
* `split` API have more options compare to `components`
```Swift
text.split(
    separator: "\n",
    maxSplits: 5,
    omittingEmptySubsequences: true
)
```

## `allSatisfy`
Querying based on a `keypath`
```Swift
items.allSatisfy(\.isSold)
```
## Iterate Lazily
By using swift sequences we can construct objects when our iteration reaches to them. Avoiding loading all of them. Loading upfront can happen we storing them in an array for example.
[# Swift sequences: The art of being lazy](https://www.swiftbysundell.com/articles/swift-sequences-the-art-of-being-lazy/)

## Set
>One of the key characteristics of a `Set` is that it stores its members based on hash value rather than by index (like `Array` does). In other words, it sacrifices guaranteed member order to gain constant (`O(1)`) lookup time.
### Comparing datasets
* `set1.isDisjoint(with: set2)`: set1 doesn't share any members with set2
* `set1.isSubset(of: set2)`
* `set1.intersection(set2)` common elements set1 and set2 have

## Result Convenience APIs
* Initializing with throwable closure`Result { try decoder.decode(Model.self, from: data) }
* Get its result with try `try result.get()`
* Mapping functions `dataResult.map {}`

//TODO Different asserts