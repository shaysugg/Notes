
## Custom Combine Operators
for defining a custom operator we need to extend `Publisher` and also put any related condition that we need to to its `Output` and `Failure`.
```Swift
extension Publishers where Output == Data, Failure == CustomError {}
```

### Data Validation
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

## Combine as a for loop
```Swift
let array = [String]
array.publisher.map {$0.lowrcased()}.flatmap { apiCall($0) }
```

## Input for viewModels
sometimes in viewModels you want to observe a value that is being emitted from viewController. you can define a property wrapper like this which is reverse version of  `@Published`.
```Swift

@propertyWrapper
struct Input<Value> {
    var wrappedValue: Value {
        get { subject.value }
        set { subject.send(newValue) }
    }

    var projectedValue: AnyPublisher<Value, Never> {
        subject.eraseToAnyPublisher()
    }

    private let subject: CurrentValueSubject<Value, Never>

    init(wrappedValue: Value) {
        subject = CurrentValueSubject(wrappedValue)
    }
}
```
```Swift
class SearchViewModel: ObservableObject {
	@Input var query = ""
}
```

## Deferred
For running tasks that need to execute once, one of the solutions is to pass them into a future closure and then erase the type future to `AnypPublisher`. but we should take that in mind that future will start its work immediately and coaches the result. [[Basic Defenitions#Future]]
If we want to wait for a subscription and then run the Publisher task we should wrap the future in a `Defered` publisher.
* we can think of `Defered` as a **lazy** publisher.
```Swift
Defered {
		 Future {}
}.eraseToAnyPublisher()
```

## Testing combine
for testing single value emitter publishers in our tests we can use this extension to avoid boilerplate and have a nicer syntax.

``` Swift
extension XCTestCase {
    func awaitPublisher<T: Publisher>(
        _ publisher: T,
        timeout: TimeInterval = 10,
        file: StaticString = #file,
        line: UInt = #line
    ) throws -> T.Output {
        var result: Result<T.Output, Error>?
        let expectation = self.expectation(description: "Awaiting publisher")

        let cancellable = publisher.sink(
            receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    result = .failure(error)
                case .finished:
                    break
                }

                expectation.fulfill()
            },
            receiveValue: { value in
                result = .success(value)
            }
        )
        
        waitForExpectations(timeout: timeout)
        cancellable.cancel()

        let unwrappedResult = try XCTUnwrap(
            result,
            "Awaited publisher did not produce any output",
            file: file,
            line: line
        )

        return try unwrappedResult.get()
    }
}
```
This extension may become handy in situations that we want to check more than one output from a publisher. (Usually when we're working with @Published). those situations.
```Swift 
extension Published.Publisher {
    func collectNext(_ count: Int) -> AnyPublisher<[Output], Never> {
        self.dropFirst()
            .collect(count)
            .first()
            .eraseToAnyPublisher()
    }
}
```

## Weak Assign
This extension helps us to assign properties on `self` without capturing self strongly.
```Swift
extension Publisher where Failure == Never {
    func weakAssign<T: AnyObject>(
        to keyPath: ReferenceWritableKeyPath<T, Output>,
        on object: T
    ) -> AnyCancellable {
        sink { [weak object] value in
            object?[keyPath: keyPath] = value
        }
    }
}
```