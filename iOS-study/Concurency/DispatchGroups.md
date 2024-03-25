> Used when you want to **track** the **completion** of a group of tasks.

```Swift
let group = DispatchGroup()
someQueue.async(group: group) { /*... your work ...*/ }
someQueue.async(group: group) { /*... more work ....*/ }
someOtherQueue.async(group: group) { /*... other work ...*/ }
group.notify(queue: DispatchQueue.main) { [weak self] in
	print("All jobs have completed")
}
```

* `group.wait` is a synchronous way of waiting for completion of submitted tasks. It blocks the current thread until result arrived.
```Swift
if group.wait(timeout: .now() + 60) == .timedOut {
  print("The jobs didn’t finish in 60 seconds")
}
```
## DispatchSemaphore
Used when we want to limit the access to the shared resource. 
When the number that associated with it reached zero the current thread stops until the number become greater that zero.
number increment happened when calling `wait()`
number decrement happened when calling `signal()`

### Cool technique
`DispatchSemaphores` become handy when we want to limit how many number of tasks we want to execute concurrently with `DispatchGroups`
in this example we limit the number of concurrent task executions to 3.
```Swift
let group = DispatchGroup()
let queue = DispatchQueue.global(qos: .userInteractive)
let semaphore = DispatchSemaphore(value: 3)

for id in ids {
  semaphore.wait()
  group.enter()
  queue.async(group: group) {
    let task = aLongTask() { data, _, error in
    . defer {
        group.leave()
        semaphore.signal()
      }
	//...
    }
  }
}

group.notify(queue: queue) {
	//...
}
```