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

## Memory managements
It is not required to write self in Task closures. However one important note is that we implicitly capturing self while using a self function or variable. 
this may not be an issue for the tasks that wont take long
but for the task that may take long or sometimes forever we should remember to cancel the task whenever we don't need it anymore.
### Example of Canceling long running task
```Swift
class DocumentViewController: UIViewController {
    private var loadingTask: Task<Void, Never>?
    
    ...

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        loadingTask = Task {
            do {
	            let document = try aLongRunningDocumentRead()
	            // a function that belongs to self
                renderDocument(document) 
            } catch {
                showErrorView(for: error)
            }
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    loadingTask?.cancel()
}
```
### Example of Canceling long running observations
```Swift 
class UserListViewController: UIViewController {
    private var observationTask: Task<Void, Never>?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        observationTask = Task {
        // without cancelation this is an actual memory leak
            for await users in list.$users.values {
                updateTableView(withUsers: users)
            }
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        observationTask?.cancel()
    }
}
```
## Actors
> Actors work much like classes (that is, they are [passed by reference](https://www.swiftbysundell.com/basics/value-and-reference-types)), with two key exceptions:

- An actor ==automatically serializes all access to its properties and methods==, which ensures that only one caller can directly interact with the actor at any given time. That in turn gives us complete protection against data races, since all mutations will be performed serially, one after the other.
- Actors don’t support subclassing since, well, they’re not actually classes.
### Race Conditions
Actors prevent data races but race conditions are still possible.
>Race conditions are logical issues that occur when multiple operations end up happening in an unpredictable order.

[Actors](https://www.swiftbysundell.com/articles/swift-actors/)