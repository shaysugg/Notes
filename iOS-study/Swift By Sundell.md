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

## Custom Combine Operators
for defining a custom operator we need to extend `Publisher` and also put any related condition that we need to to its `Output` and `Failure`.
```Swift
extension Publishers where Output == Data, Failure == CustomError {}
```

### Data Validation[]()
```Swift
extension Publisher {
    func validate(
        using validator: @escaping (Output) throws -> Void
    ) -> Publishers.TryMap<Self, Output> {
        tryMap { output in
            try validator(output)
            return output
        }
    }
}
```
### Convert to result
This one makes sinking syntax to an error throwing publisher much nicer.
```Swift
extension Publisher {
    func convertToResult() -> AnyPublisher<Result<Output, Failure>, Never> {
        self.map(Result.success)
            .catch { Just(.failure($0)) }
            .eraseToAnyPublisher()
    }
}
```
### Async Map 
```Swift
extension Publisher {
    func asyncMap<T>(
        _ transform: @escaping (Output) async throws -> T
    ) -> Publishers.FlatMap<Future<T, Error>,
                            Publishers.SetFailureType<Self, Error>> {
        flatMap { value in
            Future { promise in
                Task {
                    do {
                        let output = try await transform(value)
                        promise(.success(output))
                    } catch {
                        promise(.failure(error))
                    }
                }
            }
        }
    }
}

somePublisher.asyncMap {
		try await someAsyncOperation()
}
.eraseToAnyPublisher()
```