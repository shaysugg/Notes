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

