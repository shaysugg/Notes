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

## Examlpe of Dynamically adjusting demand

```Swift
final class IntSubscriber: Subscriber {

    typealias Input = Int
    typealias Failure = Never

    func receive(subscription: Subscription) {
      subscription.request(.max(2))
    }

    func receive(_ input: Int) -> Subscribers.Demand {
      print("Received value", input)

      switch input {
      case 1:
        return .max(2) // 1
      case 3:
        return .max(1) // 2
      default:
        return .none // 3
      }

}

let subscriber = IntSubscriber()
let subject = PassthroughSubject<Int, Never>()
subject.subscribe(subscriber)
subject.send(1)
subject.send(2)
subject.send(3)
subject.send(4)
subject.send(5)
subject.send(6)

//Output: Can you explain why?
//Received value 1
//Received value 2
//Received value 3
//Received value 4
//Received value 5


