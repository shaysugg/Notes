## Create `NSPersistantContainer`
```Swift
static func builder() -> PersistentContainer {
	guard let url = Bundle.main.url(forResource: "DataModel", withExtension: "momd"),
	let model = NSManagedObjectModel(contentsOf: url) 
	else {
		fatalError("Unable to load data model file")
	}
	let container = PersistentContainer(name: "DataModel", managedObjectModel: model)
	return container
}
```
If you want a memory only container apply this to it:
```Swift
container.persistentStoreDescriptions[0].url = URL(filePath: "/dev/null")
```
Also see: [[Persistant Container.canvas]]
## Create temporarily `NSManagedObjects`
First we need a new child context.
``` Swift
let tmpContext = persistanteContainer.newBackgroundContext()
```
Then we create our object on the child context
```Swift
let note = Note(context: tmpContext)
```
If we save **child context** then the object going to be saved also on the **parent context**.
However no matter if we save the parent context changes or not the object is not going to be saved.
```Swift
try! tmpContext.save() // note is saved here
try! viewContext.save() // note is not saved
```
## Batch Operations
### Insertion
Pro:
- Lower memory as it operates at the SQL level and doesn’t load objects into memory.
Cons:
- **No validation** rules applied.
- **Relationships** can't be set.
- Dictionary initialization or JSON dictionary in which keys should exactly match entity models.
```Swift
let insertRequest = NSBatchInsertRequest(entity: entity(), managedObjectHandler: { object -> Bool in 
	//return true when insertation finished
	//return false when insertation still continues
	//you may want to use an index and act as while loop here
}
```
### Deletion
Pro:
* Lower memory as it operates at the SQL level and doesn’t load objects into memory
Cons:
* No validation rules applied
* In-memory objects are not updated without a merge notification or Persistent History Tracking enabled
``` Swift
let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: self.fetchRequest())
```
### Apply Batch Changes to context
see: [[Batch Operations]]
## Observing managed object context
### `@FetchRequest`
* Check for the changes in one context and will fetch the changes.
* Can't manually call fetch on it.
* Won't show child context changes.
* Won't work with batch requests.
### `NSFetchResultController` in vm
* Check for the changes in one context and will fetch the changes.
* Can manually call fetch on it and retrieve data.
* Won't show child context changes (unless manually call fetch).
* Won't work with batch requests.(unless manually call fetch)
### Manually syncing in vm
* You need to pull the changes always manually so you need to pay attention to only call it when is necessary.
* You can use multiple context.
* You can use batch requests.
## Having objects with unique property
Assume we want to have notes with unique names.
One approach is to check other note names before inserting a new one. which is quite insufficient.
The other approach is define the property as constraints for the data model. 
This way if we try to save the view context changes we get an error.
in order to not get any error and only save the last model with the same property value we can specify view context merge policy to `NSMergeByPropertyObjectTrumpMergePolicy`
![[core-data-constraints.png]]
## Number of objects
```Swift
// Wrong:
let fetchRequest = Article.fetchRequest()
let count = try! context.fetch(fetchRequest).count
// Good:
let countRequest = try! context.count(for: Article.fetchRequest)
```
## Newest
by using fetch limits
```Swift
let fetchRequest = Article.fetchRequest()
fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: Article.creationDate, ascending: false)]

// Wrong:
let wrongFirstArticle = try! context.fetch(fetchRequest).first as? Article

// Good:
fetchRequest.fetchLimit = 1
let goodFirstArticle = try! context.fetch(fetchRequest).first as? Article
```
## Dispatching to background context
There are two ways 
Creating a background context object
```swift
let backgroundContext = persistentContainer.newBackgroundContext()
backgroundContext.perform {}
```
Using perform background task closure
```swift
persistentContainer.performBackgroundTask { (backgroundContext) in
    // .. Core Data Code
}
```
The closure will create a new `NSManagedObjectContext` each time it's invoked. It's better to consider a background context object If we're dispatching more often.
## Debug Core Data
It's possible to add arguments the into `Scheme Editor -> Run -> Arguments -> Arguments passed on launch` for debugging core data behavior
### SQL level log 
Add `-com.apple.CoreData.SQLDebug 1`  It's possible to set the number up to 4 for more verbose logs and informations.
### Thread Safety
`-com.apple.CoreData.ConcurrencyDebug 1` 
After you’ve enabled concurrency debugging you can go through some flows in your app and an exception will be thrown when a concurrency issue occurs.
`
## Multiple Predicates
```Swift
var predicates: [NSPredicate] = []
NSCompoundPredicate(type: .and, subpredicates: predicates)
```