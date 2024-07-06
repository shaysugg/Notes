## Get started with swift data
How to introduce swift data in your code
1) import it
2) Add `@Model` to class
4) Add a model container to view hierarchy 
5) `@Query` for models that supposed to work with swift data
```swift
//model defination
@Model
class Trip {
    //some properties
    var bucketList: [BucketListItem] = [BucketListItem]()
    var livingAccommodation: LivingAccommodation?
}

@Model
class BucketListItem {...}

@Model
class LivingAccommodation {...}

//add a model container to view hierarchy
@main
struct TripsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView
        }
        .modelContainer(for: Trip.self)
    }
}

//query stuff
struct ContentView: View {
    @Query
    var trips: [Trip]
    var body: some View {
        //...
    }
}
```
## customize the scheme
`@attributes`
`@relationships`
`@transient`
TODO: What are these???

`#unique`
which composition of properties should stay unique (avoid duplicates)
```swift
class Trip {
#Unique<Trip>([\.name, \.startDate, \.endDate])
}
```

history of swift data
Attribute(.preserveValueOnDeletion) keep the history
[track model changes with swift data history]
## Containers
model container the easiest way to start with swift data
have options like inmemory, isautosave, isundoenabled
you can build a custom container
```swift
let configuration = ModelConfiguration(schema: Schema([Trip.self]), url: fileURL)
            return try ModelContainer(for: Trip.self, configurations: configuration)
```
configuration can also be custom 
```swift
let configuration = JSONStoreConfiguration(schema: Schema([Trip.self], url: fileurl)
```
[create custom data store with swiftdata]

you can also build container for previews with 
```swift
struct SampleData: PreviewModifier {
}

#Preview(traits: .sampleData) {
 @Previewable @Query var trips: [Trip]
}
```

## Optimize Queries
### compound predicate
```swift
let predicate = #Predicate<Trip> {
    searchText.isEmpty ? true :
    $0.name.localizedStandardContains(searchText) ||
    $0.destination.localizedStandardContains(searchText)
}
```
### expression
expression are sort of reusable computed results that may being used in expression
```swift
let unplannedItemsExpression = #Expression<[BucketListItem], Int> { items in
    items.filter {
        !$0.isInPlan
    }.count
}

let today = Date.now
let tripsWithUnplannedItems = #Predicate<Trip>{ trip
    // The current date falls within the trip
    (trip.startDate ..< trip.endDate).contains(today) &&

    // The trip has at least one BucketListItem
    // where 'isInPlan' is false
    unplannedItemsExpression.evaluate(trip.bucketList) > 0
}
```
### index
swift data build an index to improve queries
consider properties that common in sorting an filtering
```swift
@Model 
class Trip {
//...
#Index<Trip>([\.name], [\.startDate], [\.endDate], [\.name, \.startDate, \.endDate])

}
```