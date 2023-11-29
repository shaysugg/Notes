## Pointer vs. reference
they’re similar in concept, but a reference is more abstract and many of its operations is handled by standard library.
If you are using a pointer then you need to allocate and initialize the object it points at. If you loose that pointer and you didn’t clear out this object, you can never reach it again. And if you delete the object and keep the pointer, you’ll come across a variety of undefined behaviors if you try to use that pointer again. but when using references most of this behaviors handled by the standard library.
## Memory layout
3 basic concepts of memory layouting:
- **Size**: This refers to the number of bytes it takes to store a value of this type. A size of four means this type requires four bytes of storage.
- **Alignment**: For a simple explanation, the address must be divisible by the alignment value. A value of two means this type can’t be stored on a pointer of odd value. You’ll learn more about this shortly.
- **Stride**: This refers to how many bytes to increment on your pointer to read the next object.
We can get memory layout information of a type like this:
```Swift
MemoryLayout<Int>.size // returns 8 (on 64-bit)
MemoryLayout<Int>.alignment // returns 8 (on 64-bit)
MemoryLayout<Int>.stride // returns 8 (on 64-bit)
```
### Trivial types
You can copy a trivial type bit for bit with no indirection or reference-counting operations.
`Int`, `Float`, `Double` and `Bool` are all trivial types. `Structs` or `enums` that contain those value types and don’t contain any reference types are also considered trivial types.
let's see how memory layout gonna be for this example
```Swift
struct IntBoolStruct {
  var intValue: Int
  var boolValue: Bool
}

MemoryLayout<IntBoolStruct>.size // returns 9
MemoryLayout<IntBoolStruct>.alignment // returns 8
MemoryLayout<IntBoolStruct>.stride // returns 16
```
![](memory-layout1.png)
* For the **alignment**, it makes sense that it is 8 to ensure that intValue is not misaligned.
**(It usually equal to the alignment of the biggest size of a type you have in your data structure.)**
* As for **stride**, it has a value of 16 to maintain the alignment and to reserve enough space for the struct. It can’t be 9, nor can it be 8. 

Now lets see memory layout of this example (only order of properties have changed)
```Swift
struct BoolIntStruct {
  var boolValue: Bool
  var intValue: Int
}

MemoryLayout<BoolIntStruct>.size // returns 16 🤔
MemoryLayout<BoolIntStruct>.alignment // returns 8
MemoryLayout<BoolIntStruct>.stride // returns 16
```
**For the struct to be aligned, all the properties inside it must also be aligned.** To have the boolean property stored before the integer, this means that a seven-bit padding is required right after the boolean to allow the integer to be properly aligned. This causes the padding to be considered in the size of the struct directly.
![](memory-layout2.png)
### Reference types
When you have a pointer of such a type, you’re pointing to a **reference** of that value and not the value itself.
``` Swift
class IntBoolClass {
  var intValue: Int = 0
  var boolValue: Bool = false
}

MemoryLayout<IntBoolClass>.size // returns 8
MemoryLayout<IntBoolClass>.alignment // returns 8
MemoryLayout<IntBoolClass>.stride // returns 8

class EmptyClass {}

MemoryLayout<EmptyClass>.size // returns 8
MemoryLayout<EmptyClass>.alignment // returns 8
MemoryLayout<EmptyClass>.stride // returns 8
```
## Pointer types
* `UnsafeRawPointer` : basic raw pointer that doesn’t know any information of the type. (can’t work on reference or non-trivial)
* `UnsafePointer<Type>` : this one knows the type of the object that it points.
these are the pointers when you want to work with arrays
* `UnsafeRawBufferPointer`
* `UnsafeBufferPointer<Type>`
all of the above pointers are read-only. the read-and-write form of them are:
• `UnsafeMutableRawPointer`
• `UnsafeMutablePointer<Type>`
• `UnsafeMutableRawBufferPointer`
• `UnsafeMutableBufferPointer<Type>`
### Loading Data to a Raw Pointer Example
```Swift
let int16bytesPointer = UnsafeMutableRawPointer.allocate(
  byteCount: 2,
  alignment: 2)

defer {
  int16bytesPointer.deallocate()
}
int16bytesPointer.storeBytes(of: 0x1122, as: UInt16.self)
```
### Buffer Raw Pointer Example
```Swift
let size = MemoryLayout<UInt>.size // 8
let alignment = MemoryLayout<UInt>.alignment // 8

let bytesPointer = UnsafeMutableRawPointer.allocate(
  byteCount: size,
  alignment: alignment)

defer { bytesPointer.deallocate() }

bytesPointer.storeBytes(of: 0x0102030405060708, as: UInt.self)

let bufferPointer = UnsafeRawBufferPointer(
  start: bytesPointer,
  count: 8)

for (offset, byte) in bufferPointer.enumerated() {
  print("byte \(offset): \(byte)")
}
```
## Memory Binding
Specifying an area in memory as a value of a specific type. To rebind from one type to another type safely, both types should be **related** and **layout compatible**. here are some related concepts to memory binding.
### Punning
part of memory is bound to a type, then you bind it to a different and unrelated type. (bad thing, unexpected behaviours)
### Related types
-   Both types are identical or one is a typealias of the other. Somewhat logical, isn’t it?
-   One type may be a tuple, a struct or an enum that contains the other type.
-   One type may be an existential (a protocol) that conforming types will contain the other type.
-   Both types are classes, and one is a subclass of the other.
### Layout Compatibility
two types are mutually layout compatible means they have the same size and alignment or contain the same number of layout compatible types.
### Strict aliasing
If you have two pointers of value types or class types, they both must be related. This means that changing the value of one pointer changes the other pointer in the same way. (both pointers are aliases to each other)
## Safe Rebinding
### `bindMemory`
```Swift
let typedPointer = rawPointer.bindMemory(
  to: UInt16.self,
  capacity: count)
```
### `withMemoryRebound`
```Swift
typedPointer1.withMemoryRebound(
  to: Bool.self,
  capacity: count * size) {
  (boolPointer: UnsafeMutablePointer<Bool>) in
  print(boolPointer.pointee) // DON'T pass the pointer out of this closure
}
```
### `assumingMemoryBound`
This did not rebind the memory to those types. It relied on the precondition that the memory is already bound to this type. And, of course, if the memory wasn’t already bound to that type, an undefined behavior will occur.
```Swift
let assumedP1 = rawPtr
  .assumingMemoryBound(to: UInt16.self)
```

## Overflow operations
``` Swift
UInt8.max + 1 //Error
UInt8.max &+ 1 // 0
//& means overflow operation
```