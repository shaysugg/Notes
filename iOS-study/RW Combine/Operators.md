### Collect

we can collect by two factors, **time** and **count** heres a example of collecting with count.

```swift
["A", "B", "C", "D", "E"].publisher
 		.collect(2)
    .sink(receiveCompletion: { print($0) },
          receiveValue: { print($0) })
    .store(in: &subscriptions)

//OUTPUT: ["A", "B"] ["C", "D"] ["E"]
```

### FlatMap

*Uses when a publisher has a value that publish something* 
flattens the output from all received publishers into a single publisher.

### Debounce and Throttle

* debounce waits for a pause in values it receives, then emits the latest one after the specified interval.
* throttle waits for the specified interval, then emits either the first or the latest of the values it received during that interval. It doesn’t care about pauses.

### Output 

`output(at: 1)` would only emit the second item that publisher sent.
`output(in 1...3)` emits values whose indices are within a provided range.

### Scan and Reduce

**reduce** waits for publisher to finish and then do the tranformation with all the values, and emits **one** final result.
scan emits **each** value with the transformation that did provided for it

1..3 -> reduce {first + last} -> 6 
1..3 -> scan {first + last} -> 1 , 3 , 6

### Share

if you want to **subscribe multiple** to **one publisher** you should use `share` on that publisher then subscribe to it. **otherwise each subscribe runs the publisher again and different values for each subscriber can get generetated.** [more](https://developer.apple.com/documentation/combine/publishers/merge/share())

```swift
let pub = (1...3).publisher
    .delay(for: 1, scheduler: DispatchQueue.main)
    .map( { _ in return Int.random(in: 0...100) } )
    .print("Random")
    .share()


cancellable1 = pub
    .sink { print ("Stream 1 received: \($0)")}
cancellable2 = pub
    .sink { print ("Stream 2 received: \($0)")}

//whithout share the two subscribers will recive different values.
```

## Debging Tools

* print()
* handleEvents(receiveSubscription:receiveOutput:receiveCompletion:rece iveCancel:receiveRequest:)
* breakpointOnError()
* breakpoint(receiveSubscription:receiveOutput:receiveCompletion:)

