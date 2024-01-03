## Tasks
> `Task`s act as a bridging the gap between synchronous and asynchronous code

```Swift
Task {
    let user = try await loader.loadUser(withID: userID)
}
```
* There are no `self` captures
* No `DispatchQueue.main.async` calls
* No tokens or cancellables that need to be retained
This is mainly because of the `MainActor` as it ensures that all the tasks finally will dispatched on the main thread. 

note that async tasks not automatically cancelled when their corresponding `Task` handle is deallocated. They just keep executing in the background.
we can store a reference to that task and cancel it anytime we want.
```Swift
private var loadingTask: Task<Void, Never>?

loadingTask = Task {
	//do some async stuff
	//when our task is finished
	loadingTask = nil
}

//later on ...
loadingTask?.cancel()
loadingTask = nil
```

### Task.detached
Assume we have an asynchronous function. By putting it in a `Task` the task may go to different thread base on the function implementation of concurrency. 
However if we have a synchronous task by just putting it in a Task It doesn't mean that we will send it to any other thread. in order to do that we need to use `Task.detached`
### Task.Sleep
The reason that the above call to `Task.sleep` is marked with the `try` keyword is because that call will throw an error in case the task was cancelled during its sleeping time.