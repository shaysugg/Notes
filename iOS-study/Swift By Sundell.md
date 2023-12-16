## Standard library
### Strings
If you want to ignore all the special characters is a string you use a `#` at the beginning and the end of the string.
```Swift
let regex = try NSRegularExpression(
    pattern: #"(([A-Z])|(\d))\w+"#
)
```

If you looking for a particular character sets you can use `CharacterSet`
```Swift
CharacterSet.letters.inverted
```

## `Codable`
Really nice patterns to add the extension of a codable to an entity object which my not posiible for us to change the implementations.
``` Swift
extension User {
    struct CodingData: Codable {
        struct Container: Codable {
            var fullName: String
            var userAge: Int
        }

        var userData: Container
    }
}

extension User.CodingData {
    var user: User {
        return User(
            name: userData.fullName,
            age: userData.userAge
        )
    }
}
```

//TODO Different asserts