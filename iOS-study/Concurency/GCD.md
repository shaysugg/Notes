# Introduction
* GCD is Apple’s implementation of C’s libdispatch library
* Its purpose is to queue up tasks that can be run in parallel, depending on availability of resources.
* All of the tasks that GCD manages for you are placed into GCD-managed first-in, first-out (FIFO) queues.
## Sync and Async
* A **synchronous Task** makes the app wait and **block** the current **run loop** until execution finishes before moving on to the next task.
* A task that is run **asynchronously** will start, but return execution to your app immediately.
examples: [Sync-Async-Serial-Concurrent](Sync-Async-Serial-Concurrent.md)
## Serial and Concurent
* **Serial** queues only have a **single thread** associated with them and thus only allow a single task to be executed at any given time.
* **Concurrent** queue is able to utilize as many **threads** as the system has resources for and run multiple tasks at the same time.
examples: [Sync-Async-Serial-Concurrent](Sync-Async-Serial-Concurrent.md)

> Asynchronous doesn’t mean concurrent!

# Queues and Threads

> A thread is really short for thread of execution, and it’s how a running process splits tasks across resources on the system.

## Dispatch queues
The way you work with threads is by creating a DispatchQueue. 
When you create a queue, the OS will potentially **create and assign one or more threads to the queue.**
*Queues is better to have a revers DNS system like `com.raywenderlich.mycoolapp.networking`*
### The Main Queue
* When your app starts, a main dispatch queue is automatically created for you.
* It’s a serial queue that’s responsible for your UI.
* You **never** want to execute something **synchronously** against the main queue
### Quality of service
`.userInteractive` > `userInitiated` > `.utility` > `.background` > `.default and .unspecified`
### Capturing `self`
Strongly capturing self in a GCD async closure **will not cause a reference cycle** (e.g. a retain cycle) since the whole closure will be deallocated once it’s completed, but it will extend the lifetime of self.
## DispatchWorkItem
``` Swift
let queue = DispatchQueue(label: "xyz")
let workItem = DispatchWorkItem {
  print("The block of code ran!")
}
queue.async(execute: workItem)
```
* They are cancelable
	* If the task has **not yet started** on the queue, it will be **removed**.
	* If the task is **currently executing**, the **isCancelled** property will be set to **true**.
### 🔥 Works Dependencies
If we have some async works that are depended on each other we can implement them by dispatchWorkItem like this:
```Swift
let queue = DispatchQueue(label: "xyz")
let backgroundWorkItem = DispatchWorkItem { }
let updateUIWorkItem = DispatchWorkItem { }

backgroundWorkItem.notify(
	queue: DispatchQueue.main,
	execute: updateUIWorkItem
)
queue.async(execute: backgroundWorkItem)
```