For avoiding performance issues it's required to only call save on `NSManagedObjectContext` when there are meaningful changes.
This extension would help
```Swift
extension NSManagedObjectContext {

    var hasPersistentChanges: Bool {
        return !insertedObjects.isEmpty || !deletedObjects.isEmpty || updatedObjects.contains(where: { $0.hasPersistentChangedValues })

    }
    
    @discardableResult public func saveIfNeeded() throws -> Bool {
        let hasPurpose = parent != nil || persistentStoreCoordinator?.persistentStores.isEmpty == false
        guard hasPersistentChanges && hasPurpose else {
            return false
        }
        try save()
        return true
    }
}
```