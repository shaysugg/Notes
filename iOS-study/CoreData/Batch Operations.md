In order to handle large operations efficiently, It's better to consider batch operations. They access the PersistentStore directly without needing to use ManagedObjectContexts.
Since context will not be used here, ==the reactive techniques that update the user interface by context changes won't work anymore.== Right here we have two options
* Perform a NSFetchRequest to poll newly added data from the store and also manually update the UI. also `viewContext.refreshAllObjects()` can be used.
* Observe persistent history and Merge the new changes of the store into the view context, without needing to change the context observation logic.
The later option looks more reasonable usually. The process of data entry -normal or using batch- shouldn't change the context observation logic `@FetchRequest` or `NSFetchedResultController`.
# Observing persistent history
This is a slightly complicated process. It's recommended to consider the implementation inside *CoreDataBestPractice* Project. (persistent history tracking). Overall steps that is required to setup persistent history tracking are:
* Enable persistent history tracking on the persistent container.
* Register and start observing changes that are raised from the`NSPersistentStoreRemoteChange` notification.
* It's better to process changes on a different queue but ==serially==. An operation queue with `maxConcurrentOperationCount` can be considered an appropriate choice here.
* History changes will be fetched on each history change notification. Note that filter the fetch requests in a way that only changes related to other context and other targets will be fetched.
* On each history change fetch result, which is called `HistoryTransaction`, It should be checked that is there anything meaningful `HistoryTransaction` that should be merged. Unnecessary changes must be avoided. If transactions should be related to specific entity we can use `MyEntity.entity().name == change.changedObjectID.entity.name`
* It's required to purge history tracking transactions, because they're take up space on disk. While It's possible to remove before a certain past date. *for example seven days ago* in the best practice project there is a timestamp tracking mechanism to remove history exactly after its changes have been merged to the context.

#article_potential
## Further readings
`NSPersistantRemoteChanges`? What are the differences between two
https://www.finnvoorhees.com/words/subscribing-to-swiftdata-changes-outside-swiftui