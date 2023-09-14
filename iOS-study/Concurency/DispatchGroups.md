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

* `group.wait` is a syncronous way of waiting for completion of submitted tasks. It blocks the current thread untill result arived.
```Swift
if group.wait(timeout: .now() + 60) == .timedOut {
  print("The jobs didn’t finish in 60 seconds")
}
```
