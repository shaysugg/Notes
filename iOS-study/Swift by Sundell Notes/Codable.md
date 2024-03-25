## Polymorphism with enums
Assume this json data
```Json
{
    "videos": [
        {
            "name": "name 1",
            "platform": [
            {
                "youtube" : {
                    "url": "hello"
                }
            },
            {
                "tiktok" : {
                    "id": "010101"
                }
            }
            ],
        },
    ]
}
```
### The Problem
So as you can see each video may contains different platforms that it's hosted on. platforms however have different implementation. youtube has a url and tiktok has an id. 
#### Solutions
* One way we can fix this issue is generalize different platforms under a Platform protocol. Each implementation has its own custom container decoding implementation. [Example](https://www.swiftbysundell.com/articles/handling-model-variants-in-swift/#complete-polymorphism)
* But another interesting solution which is way more simpler can be achieved by using enums.
### `Codable` Enums with associated types
```Swift
struct Video: Codable {
    let platform: [Platform]
    let name: String
}

extension Video {
    enum Platform: Codable {
        case youtube(url: String)
        case tiktok(id: String)
    }
}
  
struct VideoCollection: Codable {
    let videos: [Video]
}
```
## Ignoring Keys
Let's say we don't want to assign `localDarfts` from while we're decoding json data.
```Swift
struct NoteCollection: Codable {
    var name: String
    var notes: [Note]
    var localDrafts = [Note]()
}
```
We can define custom coding keys without local draft.
```Swift
extension NoteCollection {
    enum CodingKeys: CodingKey {
        case name
        case notes
    }
}
```
## `Codable` Extension
Really nice patterns to add the extension of a codable to an entity object which my not possible for us to change the implementations.
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
