* Operations are built on top of GCD
* Operations allow for greater control over the submitted task.
* One of the first reasons you’ll likely want to create an Operation is for reusability (Operation is a Swift object) 

## Operation states
![Operation State](attachments/Operations-states.png)
* *The state machine is a get only. However we can set the sate to `isExectuting` by calling starting operation and set the state to `isCancelled` by calling `cancel()`*
## BlockOperation
```Swift
let operation = BlockOperation {
 print("Hello World!")
}
```
* A BlockOperation manages the **concurrent** execution of one or more closures on the default global queue.
* BlockOperation manages a **group of closures**. `blockOperation.addExecutionBlock {...}`
* Acts similar to a dispatch group in that it **marks itself as being finished** when all of the closures have finished. `blockOperation.completionBlock { ... }`

## Operations
We would subclass operation class for more **complex works** and **reusability**.
Example:
```Swift
class NumberOperation: Operation {
  private let input: Int

  init(input: Int) {
    self.input = input
    super.init()

  }

  override func main() {
// do a heavy synchronous task with number
    }

}
```

## OperationQueue
`OperationQueue` class is what you use to
1) manage the **scheduling** of an Operation 
2) manage the maximum number of operations that can run **simultaneously**.
### Waiting for Completion
* we use `waitUntilAllOperationsAreFinished` for tracking when all operations finished.
	Important to note that It will **block** the current queue.
* `addOperations(_:waitUntilFinished:)` use for tracking when an appended task finished its work.
### Quality of service
### Pausing the queue
By setting the `isSuspended` property to true, In-flight operations will continue to run but newly added operations will not be scheduled until you change `isSuspended` back to false.
### Maximum number of operations
By setting `maxConcurrentOperationCount` property.
### Underlying DispatchQueue
we can specify an existing DispatchQueue as the `underlyingQueue`.

## AsyncOperation
When we have an async work in operation `main()` its completion usually is a closure that may called later on. When `main()` reaches to the end state automatically set to `isFinished` while it should be set when completion gets called. To fix this issue we define another state that we will be able to set values and in the setters we also update the original state.
Example can be found in ![Async Operation](Sample-Codes/Async%Operation.swift)

## Operation Dependencies
Making one operation dependent on another provides two specific benefits for the interactions between operations:
1. Ensures that the dependent operation does not begin before the prerequisite operation has completed.
2. Provides a clean way to pass data from the first operation to the second operation automatically.
```Swift
let op1 = Operation1()
let op2 = Operation2()
let op3 = Operation3()

op1.addDependency(op: op2)
op2.addDependency(op: op3)
```
