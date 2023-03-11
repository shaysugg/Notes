## String Ordering
``` Swift
let OwithDiaersis = "Ö"
let zee = "Z"

// default compare
OwithDiaersis > zee 

//compare with locale
OwithDiaersis.compare(
zee,
locale: Locale(identifier: "DE")) == .orderedAscending //true
```
## String Folding
``` Swift
let originalString = "He͜llò Wò̠rld!"

originalString.contains("Hello") // false

let foldedString = originalString.folding(
  options: [.caseInsensitive, .diacriticInsensitive],
  locale: .current)

foldedString.contains("hello") // true
```
## String Interpolation
Sometimes we want to init an instance of an object from a string. In order to do it we can use `ExpressibleByStringLiteral`.
``` Swift
struct Book {
	var name: String
	var authors: [String]
	var fpe: String
}

extension Book: ExpressibleByStringLiteral {
  public init(stringLiteral value: String) {

    let parts = value.components(separatedBy: " by: ")
    let bookName = parts.first ?? ""
    let authorNames = parts.last?.components(separatedBy:",") ?? []
    self.name = bookName
    self.authors = authorNames
    self.fpe = ""
	}
}
var book: Book = """
Expert Swift by: Ehab Amer,Marin Bencevic,\
Ray Fix,Shai Mishali
"""
```
We can also work with initial strings that not follow our defined format exactly by using `ExpressibleByStringInterpolation`. (Check the original refrence for more info)