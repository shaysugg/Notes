## Running some code later on with Combine
```Swift
let queue = DispatchQueue.main
let cancellable = queue.schedule(
  after: queue.now,
  interval: .seconds(1)
){ 
	print("Hello after 1 sec")
}

//alternitavely we can use runloops
```
## Timer
```Swift
Timer
  .publish(every: 1.0, on: .main, in: .common)
  .autoconnect()
```
### what is `autoconnect()`?
The publisher the timer returns is a `ConnectablePublisher`. It’s a special variant of Publisher **that won’t start firing upon subscription until you explicitly call its** `connect()` method. You can also use the `autoconnect`() operator which automatically connects when the first subscriber subscribes.