# Dispatch Queues
* concurrent -> parallel
* `queue.sync` code would stop at the end of closure until the task inside closure end.
* `queue.async` code outside of queue will continue.

## Async-Serial
```swift
let queue = DispatchQueue(label: "test")

queue.async {
for i in 0 ... 3 { print(i) }
}

queue.async {
for i in 4 ... 6 { print(i) }
}
print("END")
```
Output -> END, 1, 2, 3, 4, 5, 6

## Sync-Serial
```swift
let queue = DispatchQueue(label: "test")

queue.sync {
for i in 0 ... 3 { print(i) }
}// code stops here till counting to 3 finishes

queue.sync {
for i in 4 ... 6 { print(i) }
}// code stops here till counting to 6 finishes
print("END")
```
Output -> 1, 2, 3, 4, 5, 6, END

## Async-Concurrent
```swift
let queue = DispatchQueue(label: "test", attributes: .concurrent)

queue.async {
for i in 0 ... 3 { print(i) }
}

queue.async {
for i in 4 ... 6 { print(i) }
}
print("END")
```
Output -> END,1, 4, 2, 5, 6, 3

## Sync-Concurrent
```swift
let queue = DispatchQueue(label: "test", attributes: .concurrent)

queue.sync {
for i in 0 ... 3 { print(i) }
}// code stops here till counting to 3 finishes

queue.sync {
for i in 4 ... 6 { print(i) }
} // code stops here till counting to 6 finishes

print("END")
```
Output -> 1, 2, 3, 4, 5, 6, END

<hr>

### More Info
* https://www.swiftbysundell.com/clips/2/
* https://www.donnywals.com/dispatching-async-or-sync-the-differences-explained/