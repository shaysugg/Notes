There are two types of macros
* **Freestanding macros:** appear on their own, without being attached to a declaration. Example: `#function`
* **Attached macros**: ==Modifies== the declaration that they're attached to. Example 
```swift
OptionSet<Int>
struct SundaeToppings {
    private enum Options: Int {
        case nuts
        case cherry
        case fudge
    }
}
```
## Macro Declaration
Macro implementations and declarations are separate from each others. You implement macros in a specific module and then you declare this in the domain that you want to use like;
### Freestanding Example
```swift
@freestanding(expression)

public macro fourCharacterCode(_ string: String) -> UInt32 = #externalMacro(module: "Macro", type: "FourCharacterCode")
```
### Attached Example
```swift
@attached(member)
@attached(extension, conformances: OptionSet)
public macro OptionSet<RawType>() =
        #externalMacro(module: "SwiftMacros", type: "OptionSetMacro")
```
This is an attached macro.
* `@attached(member)`, indicates that the macro adds new members to the type you apply it to.
* `@attached(extension, conformances: OptionSet)`, tells you that `@OptionSet` adds conformance to the `OptionSet` protocol.
### Full list of roles
- **@freestanding(expression)**  
    _Creates a piece of code that returns a value_
- **@freestanding(declaration)**  
    _Creates one or more declarations_
- **@attached(peer)**  
    _Adds new declarations alongside the declaration it’s applied to_
- **@attached(accessor)**  
    _Adds accessors to a property_
- **@attached(memberAttribute)**  
    _Adds attributes to the declarations in the type/extension it’s applied to_
- **@attached(member)**  
    _Adds new declarations inside the type/extension it’s applied to_
- **@attached(conformance)**  
    _Adds conformances to the type/extension it’s applied to_
## AST
Stands for abstract syntax tree. The compiler will use that to provide safe code manipulation for macro authors. It also can prioritize nested macro expansions.
![[macro_ast.png]]
* Check [AST Explorer](https://swift-ast-explorer.com/) for play around and demonstration of AST blocks
## Implementing a Macro
For create a new macro run `swift package init --type macro`. This will provide more robust starting structure.
For setting up the macro manually proceed base on [Implementing a Macro](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/macros/#Implementing-a-Macro)
### SwiftSyntax
Is a dependency that should exist in macros implementations. It's for interacting with swift code in a structured way, using AST.