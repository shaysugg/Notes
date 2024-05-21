## Create PersistentContainer
If you are set upping in a package then you need to address the model file with:
```swift
Bundle.module.url(forResource: "Model", withExtension: "momd")
```
## Constructing NSManagedObject
If the default initializers won't work, this way of initializing may help
```swift
let entityDescription = NSEntityDescription.entity(forEntityName: "Your Entity", in: managedObjectContext)  
let object = Your Entity(entity: entityDescription!, insertInto: managedObjectContext)
```
## Specify ModulName
Explicitly define Module to be your package name for all of the entities!
![[module-name.png]]
#article_potential 