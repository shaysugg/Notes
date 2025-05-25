Given this json
```json
{
    "name": "John Doe",
    "age": 22,
    "courses": [
      {
        "name": "Introduction to Computer Science",
        "credits": 3
      },
      {
        "name": "Calculus I",
        "credits": 4
      },
      {
        "name": "English Composition",
        "credits": 3
      }
    ],

    "address": {
      "street": "123 Main St",
      "city": "Anytown",
      "state": "CA",
      "zip": "12345"
    }
}
 
```
We can decode an object by a custom decoder like
```swift

struct Course {
    let name: String
    
    init(name: String) {
        self.name = name
    }
}

struct Address {
    let street: String
    let city: String
}

class Student: Decodable, CustomStringConvertible {
    let courses: [Course]
    let address: Address
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case courses
        case address
    }
    
    enum AddCodingKeys: String, CodingKey {
        case street
        case city
    }
    
    enum CourseCodingKeys: String, CodingKey {
        case name
    }
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        //name
        name = try container.decode(String.self, forKey: CodingKeys.name)
        
        //cources
        var coursesArray = try container.nestedUnkeyedContainer(forKey: CodingKeys.courses)
        var decodedCourses: [Course] = []
        while !(coursesArray.isAtEnd) {
            let container = try coursesArray.nestedContainer(keyedBy: CourseCodingKeys.self)
            let name = try container.decode(String.self, forKey: CourseCodingKeys.name)
            decodedCourses.append(Course(name: name))
        }
        courses = decodedCourses
        
        //address
        let addContainer = try container.nestedContainer(keyedBy: AddCodingKeys.self, forKey: CodingKeys.address)
        let addStreet = try addContainer.decode(String.self, forKey: .street)
        let addcity = try addContainer.decode(String.self, forKey: .city)
        address = Address(street: addStreet, city: addcity)
    }
}
```