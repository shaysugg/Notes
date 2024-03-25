## `NSManagedObjectContext` is **not** thread safe
It's a best practice to put any related work to NSManagedObjectContext into one of these methods:
* `perform(_:)`
* `performAndWait(_:)`

these methods ensure that whatever action we pass to them is executed ==on the same queue that created the context.==
the first is an asynchronous method, whereas the second is synchronous
## Heavy coreData Operations
`persistentContainer.performBackgroundTask` is a shortcuts that we can use to offload heavy operation from current thread and send it to background thread.
## NSAsynchronousFetchRequest
When we have a lots of data that we ant to query and we want to query asynchronously we can use:
```Swift
let fetchRequest = Person.fetchRequest() as
NSFetchRequest<Person>

let asyncFetch = NSAsynchronousFetchRequest(fetchRequest:
fetchRequest) { [weak self] result in
  guard let self = self,
        let people = result.finalResult 
        else { return }
	//do something with result ...
}

do {
  let backgroundContext = persistentContainer.newBackgroundContext()
  try backgroundContext.execute(asyncFetch)
} catch let error {
  // handle error
}
```
🔴 Note that **an asynchronous fetch request must be run in a private background queue.**

## Sharing an `NSManagedObject`
sharing `NSManagedObject` between threads is **not safe**! Instead of sharing the whole object we should only share the object id and get the object in the other thread.
```Swift
let objectId = someEntity.objectID

DispatchQueue.main.async { [weak self] in
	  guard let self = self else { return }
	  let myEntity = self.managedObjectContext.object(with: objectId)
	  self.addressLabel.text = myEntity.address
}
```