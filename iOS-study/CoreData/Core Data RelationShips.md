[Article](https://fatbobman.com/en/posts/mastering-relationships-in-core-data-fundamentals/)

> Core Data’s key task is how it precisely describes and effectively manages the complex relationships between different data instances. Indeed, the ability to manage relationships not only constitutes the core characteristic of Core Data but also represents a significant advantage over other data persistence frameworks.

>relationships in Core Data can be seen as a mechanism for establishing connections and operations between different tables.

## Lazy Loading of Relationships and Its Application

>In Core Data, on-demand data population of managed objects is a key feature. By default, managed objects retrieved from the persistent store are initially in a “fault” state, meaning their data isn’t fully loaded immediately. The complete data is loaded (turning the object into a “fulfilled” state) only when specific properties of that object are accessed

>If developers want to preload related entities B while fetching a specific entity A, they can specify the relevant relationships in the `relationshipKeyPathsForPrefetching` property of `NSFetchRequest`. For example:
```Swift 
let request = NSFetchRequest<Item>(entityName: "Item")
request.relationshipKeyPathsForPrefetching = ["Tag"]
```
