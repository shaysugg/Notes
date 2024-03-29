> scheduler is a protocol that defines when and how to execute a closure.

>A scheduler is not equal to a thread

* The concrete implementation is the one that defines where the “context” provided by the scheduler protocol executes!

## Operators for scheduling
* `subscribe(on:)` and `subscribe(on:options:)` **create** the subscription (start the work) on the specified scheduler.
* `receive(on:)` and `receive(on:options:)` **deliver** values on the specified scheduler.
## Scheduler implementations
• **ImmediateScheduler**
* **RunLoop**
	it is a way to manage input sources at the thread level
* **DispatchQueue**
	 Except main DispatchQueue which executes its works always on main thread all other DispatchQueues execute their code in a pool of threads managed by the system. Meaning you should never make any assumption about the current thread in code that runs in a queue.
* **OperationQueue**

## `RunLoop.main` and `DispatchQueue.main`

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
