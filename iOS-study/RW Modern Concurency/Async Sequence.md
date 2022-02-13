## Async Sequence
[Apple Documentation](https://developer.apple.com/documentation/swift/asyncsequence)

means anything conforms to `AsyncSequence` protocol. It a sequence that the elements of it get produced asynchronously.
some feature of async sequence that getting used are:

* Iterate through elements like
 ```swift
for try await item in asyncSequence { }
 ```
 or
 ```swift
 while let item = try await iterator.next() { }
 ```
 
 * using sequence methods like:
 ```swift
for await item in asyncSequence
  .dropFirst(5)
  .prefix(10)
  .filter { $0 > 10 }
  .map { "Item: \($0)" } {
    ...
  }
 ```
 
 * bytes sequence wrappers like
 ```swift
URL(string: "www.something.com")?.resourceBytes
 ```

 