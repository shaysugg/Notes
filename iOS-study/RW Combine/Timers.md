## Schedulers
> A Combine scheduler defines when and how to execute a closure.

Schedulers conform to the `Scheduler` protocol to which both `RunLoop.main` and `DispatchQueue.main` conform.
### RunLopp
> A RunLoop is a programmatic interface to objects that **manage input sources**, such as touches for an application

Each Thread class, can have its own RunLoop. 
### `RunLoop` vs `DispatchQueue.main`
**Commons:** Both `RunLoop.main` and` DispatchQueue.main` execute their code on the main thread, meaning that you can use both for updating the user interface.
**Differences**: `DispatchQueue.main` executes directly while the `RunLoop.main` might be busy and executes later on. 
**Example**: assume we want to present a downloaded image while scrolling, with `RunLoop` it waits for scroll to finish and then present image, while in `DispathQueue` it would present the image immediately.

### Notes
* It's always better to consider `DispatchQueue.main` for our UI stuff.
* RunLoop class is not thread-safe. You should only call RunLoop methods for the run loop of the current thread.

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