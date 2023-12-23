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