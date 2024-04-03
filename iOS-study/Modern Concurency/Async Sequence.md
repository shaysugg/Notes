# Async Sequence
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

## Real World Example

 Lets assume that we want to download a file and show its progress in the UI
 Here is how we can do it by using URLSession async iterator APIs in our ViewModel:

 1) first defining our request:
  ```swift
let url = URL(string: "http://somehost.com/getfile")
let request = URLRequest(url: url)

//for partial download request we can also use this
request.addValue("bytes=\(offset)-\(offset + length - 1)", forHTTPHeaderField: "Range")
 ```
 
 2) perform our request to make a `AsyncIterator`
```swift
let result: (downloadStream: URLSession.AsyncBytes, response: URLResponse)
result = try await URLSession.shared.bytes(for: request)
var downloadIterator = result.downloadStream.makeAsyncIterator()
 ```

 3) use a `ByteAccumulator` to collect bytes based on the given size and store them in an array
```swift
let accumulator = ByteAccumulator(name: name, size: size)
      
while !accumulator.checkCompleted() {
	while !accumulator.isBatchCompleted,
	let bytes = try await downloadIterator.next() {
		accumulator.append(bytes)
	 }

	 Task.detached(priority: .medium) { [weak self] in
		//raise an state to update UI wity accumulator.progress
	 }
 }
 ```
 
 4) return `accumulator.data`
## Async Sequence from Combine
by using `.values` on combine publishers we would get async sequence of publishers events and we would be able to Iterate through it.

```swift
let timerSequence = Timer
  .publish(every: 1, tolerance: 1, on: .main, in: .common)
  .autoconnect()
  .values

Task {
  for await duration in timerSequence {
    print(duration)
  }
}
 ```

## How to create an AsyncSequence from scratch?
first by conforming our sequence to `AsyncSequence` and then define our iterator in there by conforming it to `AsyncIteratorProtocol`. *see playground example*.

it may looks to have a little boilerplate specially for simple sequences. in these situations we can use `AsyncStream`

### Alternative: AsyncStream
if we want to write more functional (simpler) way instead of using bunch of classes we can use `AsyncStream` like this:
```swift
let stream = AsyncThrowingStream {
	guard index < urls.count else {
		return nil
	}

	let url = urls[index]
	index += 1

	let (data, _) = try await urlSession.data(from: url)
	return data
}

for try await item in stream {
 //do some stuff
}
```
*see playground example*

## Adopt AsyncSequence in other places
one example can be adding an extension to` NotificitationCenter`

```swift
extension NotificationCenter {
	func notifications(for name: Notification.Name) -> AsyncStream<Notification> {
		AsyncStream<Notification> { continuation in
			NotificationCenter.default.addObserver(
			forName: name, 
			object: nil, 
			queue: nil
		) { notification in
			  continuation.yield(notification)
			}
		}
	}
}

//use it like this
for await _ in await NotificationCenter.default
  .notifications(for: UIApplication.willResignActiveNotification) {
	//do stuff in here 
}
```
## Continuation outside of closure
Sometimes we want to extract the continuation out of asyncstream builder in order to send values to it from other places. The safe way of implementing it is by using:
```swift
```swift
class Foo {
  let stream: AsyncStream<String>
  private let continuation: AsyncStream<String>.Continuation

	override init() {
	let (stream, continuation) = AsyncStream.makeStream(of: String.self)
	self.stream = stream
	self.continuation = continuation
	}

	func foo() {
		continuation.yield("Hello")
	}
}
```
##