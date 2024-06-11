# TaskGroups
Imagine we have hundreds of async tasks that we want to execute in parallel. We already know for executing Tasks in parallel we can use `async let` but we can't define an `async let` for hundred times in this case. the solution is using a task group

## Usage Example
```swift       
try await withThrowingTaskGroup(of: String.self, body: { group in

	group.addTask {
		try await getStringByPerformingAnAsyncOperation()
	}
	
	for try await string in group {
		print(string)
	}

})

func getStringByPerformingAnAsyncOperation() async throws -> String{
	//some heavy operation that returns an string eventually
}
```

* **group** in the closure conforms to `AsyncSequence` we can use for and loop or any other `AsyncSequence` function on it.

* Control task execution by canceling the group via `cancelAll()` or waiting for all tasks to complete with `waitForAll()`.

## Group Tasks That Doesn't Return Values
Sometimes group task is series of works and we don't actually want to return a value from them. Here is the example of how to implement it.

```swift       
// we are returning Void
try await withThrowingTaskGroup(of: Void.self, body: { group in

	group.addTask {
		try await doSomethingByPerformingAnAsyncOperation()
	}
	
    // we don't want to iterate through tasks here 
    // so we only wait for them to finish and throw their possible errors
	try await group.waitForAll() 

})

func doSomethingByPerformingAnAsyncOperation() async throws {
	//some heavy operation that returns an string eventually
}
```
* New in iOS 17: we can also use `withDiscardingTaskGroup`
## Reduce group
For cleaner syntax, we can use `reduce` on the group to return our desired result. note that we need to use another `withThrowingTaskGroup` initializers. here is the example:

```swift
let strings = try await withThrowingTaskGroup(
  of: String.self //this is the type that each addTask returns
  returning: [String].self // this is the type the closure should return
) { group in
  
	group.addTask {
			try await getStringByPerformingAnAsyncOperation()
	}

	return try await group.reduce(into: [String]()) { result, string in
		result.append(string)
	}
}
```

## Data Races in TaskGroups
A data race occurs when **multiple threads** access the same data in memory, and at least one of them is trying to **modify** that data.

![data race](taskgroup_data_race.png)

So which part of a `TaskGroup` is safe for mutating a shared state?

![Task Group Safe code](taskgroup_safe_code.png)

* It’s **mostly safe** to modify shared state from the **synchronous** parts of the code (in green) — for example, from outside the task group.
* It’s **somewhat safe** to modify state from **asynchronous** parts (in orange), if the compiler doesn’t complain. But to do that, you have to be sure you aren’t introducing a data race.
* It’s **dangerous** to modify state from the **concurrent** parts (in red), unless you use a safety mechanism.

 Best practice for mutating shared state In the dangerouse areas is define mutating components as an **Actor**
## Check cancellation
`group.addTaskUnlessCancelled` can be a good alternative to `group.add` when we want to check for cancelation before starting a new task

## Task group patterns
### Limit the number of concurrent task
Sometimes we don't want to add so many tasks in our group since it may hurt the performance. 
One general approach is to initially add a certain amount of task to the group and on the completion of each task if a remained tasks exists add it to the group. We can use a pattern like this:
```Swift
withTaskGroup(of: Something.self) { group in
    for _ in 0..<maxConcurrentTasks {
        group.addTask { }
    }

    while let <partial result> = await group.next() {
        if !shouldStop { 
            group.addTask { }
        }
    }
}
```
*check SampleCode s for a real implementation*
### Limit the total time 
When using Discarding Task Groups if any off the group tasks throws an error all of the other group tasks will be canceled.
By using that It's possible to implement a maximum time for all of the group concurrent tasks.
```Swift
func run() async throws i
	try await withThrowingDiscardingTaskGroup { group in
		for cook in staff. keys {
			group.addTask { try await cook.handleShift() }
		}
		group.addTask {
			// keep the restaurant going until closing time
			try await Task.sleep(for: shiftDuration)
			throw TimeCloseError()
		}
	}
}		
```
