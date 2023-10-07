## Generating Low Level Swift Code
```Shell
swiftc -O -emit-silgen file.swift > file.rawsil
swiftc -O -emit-sil file.swift > file.sil
swiftc -O -emit-assembly file.swift > file.asm
```

## Implementing features from compiler to library
Swift pushes the implementation of as many features as possible from the compiler into the library. ==Optional is just a generic enumeration==. The truth is that most of the fundamental types are part of the standard library and not baked into the compiler. This includes Bool, Int, Double, String, Array, Set, Dictionary, Range and many more.

## ifelse Refactoring
Here we  write a ifelse function and try to make it better by using some of the Swift language features.
```Swift
func ifelse(condition: Bool,
            valueTrue: Int,
            valueFalse: Int) -> Int {
  if condition {
    return valueTrue
  } else {
    return valueFalse
  }
}
```
1) For a language construct that’s going to be used often, removing the argument labels makes sense. (using `_` ) 
```Swift
func ifelse(_ condition: Bool,
            _ valueTrue: Int,
            _ valueFalse: Int) -> Int {
  condition ? valueTrue : valueFalse
}
```
2) Use generics
``` Swift
func ifelse<V>(_ condition: Bool,
               _ valueTrue: V,
               _ valueFalse: V) -> V {
  condition ? valueTrue : valueFalse
}
```
3) Auto Closures:
 if we send functions as parameters we see **both** functions are always called.
 ```Swift
 func ifelse<V>(_ condition: Bool,
               _ valueTrue: @autoclosure () -> V,
               _ valueFalse: @autoclosure () -> V) -> V {
  condition ? valueTrue() : valueFalse()
}
```
`@autoclosure` removes the need of use `{}`

4) Handling Errors
``` Swift
func ifelse<V>(_ condition: Bool,
               _ valueTrue: @autoclosure () throws -> V,
             _ valueFalse: @autoclosure () throws -> V)
rethrows -> V {
condition ? try valueTrue() : try valueFalse()
}
```
`rethrow` helps to throw the passed function parameters errors. if they dont throw it's fine to write the higher level function without `try`. ([more about rethrow](https://www.avanderlee.com/swift/rethrows/))

## The Fundamental Types
* named types (protocols, enumerations, structures and classes)
* compound types (functions and tuples)

## Struct & Class Differences
### Difference 1: Automatic initialization
the compiler will declare an internal member-wise initializer for structures.
### Difference 2: Copy semantics
Classes = reference semantics
Structures = have value semantics.
```Swift
let structPointA = StructPoint(x: 0, y: 0)
var structPointB = structPointA
structPointB.x += 10
print(structPointA.x) // not affected, prints 0.0

let classPointA = ClassPoint(x: 0, y: 0)
let classPointB = classPointA
classPointB.x += 10
print(classPointA.x) // affected, prints 10.0
```
### Difference 3: Scope of mutation
### Difference 4: Heap versus stack
Stack allocations are orders of magnitude faster than heap allocations, this is where value types get their fast reputation.
![Heap VS Stack](attachments/heap-vs-stack.png)
### Difference 5: Lifetime and identity
Value types, such as structures and enumerations, generally live on the stack and are cheap to copy. Values don’t have the notion of a lifetime or intrinsic identity. References do have lifetimes, and because of that, you can define a deinit function for them. They also automatically have an identity because they reside at a specific place in memory you can use to identify them.

Note: It’s possible to give a value type identity by specifying a unique property attribute. The Identifiable protocol, which adds a Hashable (and Equatable) id property, does this. The SwiftUI framework defines property wrappers, such as @State, which among other things imbue lifetime into simple value types