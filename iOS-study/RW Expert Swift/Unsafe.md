## Pointer vs. reference
they’re similar in concept, but a reference is more abstract and many of its operations is handled by standard library.
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
For the alignment, it makes sense that it is 8 to ensure that intValue is not misaligned. As for stride, it has a value of 16 to maintain the alignment and to reserve enough space for the struct. It can’t be 9, nor can it be 8.

now lets see memory layout of this example (only order of properties have changed)
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