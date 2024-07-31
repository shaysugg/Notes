This is how a task tree cancellation works.
![](canceling_task.png)

**Cancellation is cooperative**
When a parent send the signal of a cancellation to its child task the child task **doesn't cancelled immediately**.
It set `Task.isCancelled` on that task. Task getting informed that its result is no longer needed.
If we have an expensive task we should check for cancellation before starting it

We can use  
* `Task.isCancelled` when we want to do some operation when task is cancelled
* `Task.checkCancellation()` Automatically throws a cancellation error for us if the task is cancelled.
* `withTaskCancellationHandler` Mostly used in AsyncSequences when our task getting suspended and not running and we want to do something on cancellations
```Swift
await withTaskCancellationHandler {
	//....
} onCancel: {
	//update stuff
}
```

## Tasks Canceling Methods
 
* **Task.isCancelled**: Returns true if the task is still alive but has been canceled since the last suspension point.
* **Task.currentPriority**: Returns the current task’s priority.
* **Task.cancel()**: Attempts to cancel the task and its child tasks.
* **Task.checkCancellation()**: Throws a CancellationError if the task is canceled, making it easier to exit a throwing context.
* **Task.yield()**: Suspends the execution of the current task, giving the system a chance to cancel it automatically to execute some other task with higher priority.”