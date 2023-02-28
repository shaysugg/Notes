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
