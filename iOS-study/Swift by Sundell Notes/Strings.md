## Access characters
Strings are `BidirectionalCollection & RangeReplaceableCollection`s. They are not conformed to `RandomAccessCollection`. So It's not possible to access a character of string like `string[4]`
The preferred way of accessing characters of string is like:
```Swift
let secondIndex = string.index(after: string.startIndex)
let thirdIndex = string.index(string.startIndex, offsetBy: 2)
let lastIndex = string.index(before: string.endIndex)
```
### Why strings are not `RandomAccessCollection`
Assume a string and a `utf8` version of it
```Swift
"Café".count // 4
"Café".utf8.count // 5

"👨‍👩‍👧‍👦".count // 1
"👨‍👩‍👧‍👦".utf8.count // 25
```
Since this may cause confusions, swift doesn't provide accessing to characters using indexes.
## Ignoring special characters
If you want to ignore all the special characters is a string you use a `#` at the beginning and the end of the string.
```Swift
let regex = try NSRegularExpression(
    pattern: #"(([A-Z])|(\d))\w+"#
)
```
## Set of characters
If you looking for a particular character sets you can use `CharacterSet`
```Swift
CharacterSet.letters.inverted
```
## StringProtocol
A generic type that both `Substring`s and `String`s are conformed to. may be considered in writing more generalized code.
## Character Category
``` Swift
let character: Character = "A"

character.isLetter // true
character.isNumber // false
character.isUppercase // true
character.isSymbol // false
character.isCurrencySymbol // false
character.isASCII // true
```
## Converting Between String and Data
```Swift
// String -> Data
let data = Data("Hello, world!".utf8)

// Data -> String
let string = String(decoding: data, as: UTF8.self)
```
## String Based Enums
```Swift
extension Building {
    // This enum has custom raw values that are used when decoding
    // a value, for example from JSON.
    enum Kind: String {
        case castle = "C"
        case town = "T"
        case barracks = "B"
        case goldMine = "G"
        case camp = "CA"
        case blacksmith = "BL"
    }

    var animation: Animation {
        return Animation(
            // When used in string interpolation, the full case name is still used.
            // For 'castle' this will be 'buildings/castle'.
            name: "buildings/\(kind)",
            frameCount: frameCount,
            frameDuration: frameDuration
        )
    }
}
```
