## Fakes, Mocks, and Stubs
Assuming the original class and protocol are something liked this
``` Swift
protocol DataSourceProtocol {
	func getNumberOfItems() -> Int
}
class DataSource {
	func getNumberOfItems() -> Int { 
	// interacting with coredata for example
	}	
}
```
### Stubs 
Stubs stand in for the original object and provide **canned responses**. These are often used to implement one method of a protocol and have empty or nil returning implementations for the others.
```Swift 
class StubDataSource: DataSourceProtocol {
	func getNumberOfItems() -> Int { 5 }
}
```
### Fakes
Fakes often have **logic**, but instead of providing real or production data, they provide test data. For example, a fake network manager might read/write from local JSON files instead of connecting over a network.
```Swift 
class FakeDataSource: DataSourceProtocol {
	func getNumberOfItems() -> Int { 
		//interacting with inmemory data instead of coredata
	 }
}
```
### Mocks
Mocks are used to verify behavior, that is they should have an expectation that a certain method of the mock gets called or that its state was set to an expected value. Mocks are generally expected to provide test values or behaviors.
```Swift 
class MockDataSource: DataSourceProtocol {
	private let numberOfItems: Int
	
	init(numberOfItems: Int) {
		self.numberOfItems = numberOfItems
	}
	
	func getNumberOfItems() -> Int { 
		return numberOfItems
	 }
}
```
### Partial mock
While a regular mock is a complete substitution for a production object, a partial mock uses the production code and only overrides part of it to test the expectations. Partial mocks are usually a **subclass** or provide a **proxy** to the production object.
``` Swift
class PartialMockDataSource: DataSource {
	private let numberOfItems: Int
	
	init(numberOfItems: Int) {
		self.numberOfItems = numberOfItems
	}
	
	override func getNumberOfItems() -> Int { 
		return numberOfItems
	 }
}
```
## Spy
spy is a partial mock. It is used to record how it was called by the object under test, and you can then make assertions on it. The main difference is that, unlike mock objects, spy objects do carry out **real** actions.
```Swift
class SpyMockDataSource: DataSource {
	var numberfetched = false
	
	override func getNumberOfItems() -> Int { 
		numberfetched = true
		return realNumberFromDB()
	 }
}
```