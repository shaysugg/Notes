## Publishing network data to multiple subscribers
You could use the `share()` operator, but that‘s tricky ==**because you need to subscribe all your subscribers before the result comes back**.==
By using `multicast()` operator, which creates a ConnectablePublisher that publishes values through a Subject, you can subscribe multiple times to the subject, then call the publisher‘s `connect()` method when you‘re ready.
``` Swift
let url = URL(string: "https://www.raywenderlich.com")!
let publisher = URLSession.shared
  .dataTaskPublisher(for: url)
  .map(\.data)
  .multicast { PassthroughSubject<Data, URLError>() }

let subscription1 = publisher
  .sink(receiveCompletion: { completion in
    if case .failure(let err) = completion {
      print("Sink1 Retrieving data failed with error \(err)")
    }
  }, receiveValue: { object in
    print("Sink1 Retrieved object \(object)")
})

let subscription2 = publisher
  .sink(receiveCompletion: { completion in
    if case .failure(let err) = completion {
      print("Sink2 Retrieving data failed with error \(err)")
    }
  }, receiveValue: { object in
    print("Sink2 Retrieved object \(object)")
})

let subscription = publisher.connect()
```