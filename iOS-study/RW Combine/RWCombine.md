# Some Notes about Combine

## How to write a custom subscriber 

its just a struct that conforms to subscriber.

```swift
struct MySUB: Subscriber {
    typealias Input = Int
    typealias Failure = Never
    var combineIdentifier = CombineIdentifier() 
  
   func receive(subscription: Subscription) {
      // this only call once when subscriber subscribe to publisher
       subscription.request(.max(5))
    }
    
   func receive(_ input: Int) -> Subscribers.Demand {
     //this getting called on each value recieve
     //we can put a logic and specify how many othe requests we want in here
        print("RECIEVED \(input)")
        return .none
    }
    
   func receive(completion: Subscribers.Completion<Never>){
     //called only once when error or complition happends
        print("Completed! \(completion)")
   }
}
```

## Operators

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

*Uses when a publisher has a value that publish somthing* 
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

if you want to **subscribe multiple** to **one publisher** you should use `share` on that publisher then subscribe to it. *May have some side affects if you dont to it.*

