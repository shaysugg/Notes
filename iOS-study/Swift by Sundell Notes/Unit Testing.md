## Two Important Refactoring Techniques
Two important techniques for refactoring a non-testable code
* Pure functions
* Dependency Injection
[Article](https://www.swiftbysundell.com/articles/refactoring-swift-code-for-testability)
## Functions Instead of Singleton
Assume an implementation of User loader which has singleton dependencies to `NetworkManager`, `UserCache`.
```Swift
struct UserLoader {
    func loadUser(
        withID id: User.ID,
        then handler: @escaping (Result<User, Error>) -> Void
    ) {
        if let user = UserCache.shared.user(withID: id) {
            return handler(.success(user))
        }
        NetworkManager.shared.loadData(from: .user(id: id)) { 
                UserCache.shared.insert(user)
    }
}
```
One of the easiest way of make this class testable is to replace the dependencies to singleton with functionality of those singleton.
See also: [[Functional Dependency Injection]]
```Swift 
struct UserLoader {
	@DebugOverridable
    var networking = NetworkManager.shared.loadData
    @DebugOverridable
    var cacheInsertion = UserCache.shared.insert
    @DebugOverridable
    var cacheRetrieval = UserCache.shared.user
}
```
We use `@DebugOverridable` to make sure we can only override those vars in tests and debug builds.
## Writing Tests for SwiftUI views
**Don't**
Extract the logic into other classes like viewModels, models, controllers and etc.
## Time Traveling
One thing that should be considered when we writing tests is waiting for our condition to happen. As it may take a while to happen. assuming we are raising a notification after a deadline. Test should not wait until that specific time. Regardless of how small that time is. In the test below we have to wait an amount of time for the notification to be raised from the PremiumService.
```Swift
class PremiumService {
	private(set) var deadline: Date

	func setupNotificationForDeadline() async throws {
		Task {
			try await Task.sleep(for: 
				.seconds(deadline.distance(to: Date.now))) 
			raiseNotif()
		}
	}
}

class Test: XCTest {
	func testDeadlineNotificationWillRaise() async throws {
	//given
		let expectation = expectation(forNotification: PremiumService.premiumExpiredNotification, object: nil)
	     let futureDate = Date.now.addingTimeInterval(1.5)
	        sut.deadline = futureDate
	       //when
	     try await sut.setupNotificationForDeadline()
			//🔴 NOT GOOD
			//Test will take 1.5 second to finish.
			//What if we want to test raising notif in the next 24 hr
	      await fulfillment(of: [expectation], timeout: 2)
	    }
}
```
### Introducing Time Travel
The general idea is creating the current date in these classes should be generative instead of hardcoding `Date.now`. By using that injection we can manipulate the current date in our test whenever we want. Also by introducing TimeTravel class we can reuse the incrementing dates in our tests much easier.
```swift
class TimeTraveler {
    private var date = Date()

    func travel(by timeInterval: TimeInterval) {
        date = date.addingTimeInterval(timeInterval)
    }

    func generateDate() -> Date {
        return date
    }
}
```
### Refactoring
```Swift
class PremiumService {
	private(set) var deadline: Date
	//we will inject it in our initializer
	var currentDateGenerator: () -> Date = Date.now
	
	func setupNotificationForDeadline() async throws {
		Task {
			try await Task.sleep(for: 
				.seconds(deadline.distance(to: currentDateGenerator()))) 
			raiseNotif()
		}
	}
}

class Test: XCTest {
	func testDeadlineNotificationWillRaise() async throws {
	//given
	let timeTraveler = TimeTraveler()
	sut.currentDateGenerator = timeTraveler.generateDate
		let invertExpectation = expectation(forNotification: PremiumService.expiredNotif, object: nil)
		invertExpectation.isInvert = true
		let futureDate = Date.now.addingTimeInterval(1.5)
		sut.deadline = futureDate
		
		try await sut.setupNotificationForDeadline()	
		//verify that notif will not raise instantly
		await fulfillment(of: [invertExpectation], timeout: 0.0001)
		
	     //travel in time
	     let expectation = expectation(forNotification: PremiumService.expiredNotif, object: nil)
		timemeTraveler.travel(by: 1.5)
		//verify that now we have traveled, notif will be raisen
		try await sut.setupNotificationForDeadline()
		await fulfillment(of: [expectation], timeout: 0.0001)
	    }
}
```
## Nice definition Test Structure
Most unit tests written using Apple’s built-in `XCTest` framework tend to follow a pattern made up of three steps: 
1) we set up the values and objects that we wish to test
2) we then perform a set of actions that trigger the functionality that we’re looking to verify
3) finally we _assert_ that the correct outcome was produced.

>_testable code_ — code that’s synchronous, predictable, and always produces the same output for a given set of inputs

## Testing Network Logic
### Mocking
Useful when we have small amount of networking in our app, As It's really difficult to make a mock that has all of the URLSession interfaces since It's a big class with a lots of method. 
### URLProtocol
It's an underlying class that URLSession uses before perform requests which make it a good candidate to manipulate requests and prevent actual networking to be happened. By registering it to a session we can control all of it ongoing requests.
[Full Article of It's implementation](https://www.swiftbysundell.com/articles/testing-networking-logic-in-swift/#integration-tests-instead-of-abstractions)
#### Implementation
A URLProtocol capable off defining its responding to request from outside
```Swift
class MockURLProtocol<Responder: MockURLResponder>: URLProtocol {
    override class func canInit(with request: URLRequest) -> Bool {
        true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        request
    }

    override func startLoading() {
        guard let client = client else { return }

        do {
            // Here we try to get data from our responder type, and
            // we then send that data, as well as a HTTP response,
            // to our client. If any of those operations fail,
            // we send an error instead:
            let data = try Responder.respond(to: request)
            let response = try XCTUnwrap(HTTPURLResponse(
                url: XCTUnwrap(request.url),
                statusCode: 200,
                httpVersion: "HTTP/1.1",
                headerFields: nil
            ))

            client.urlProtocol(self,
                didReceive: response,
                cacheStoragePolicy: .notAllowed
            )
            client.urlProtocol(self, didLoad: data)
        } catch {
            client.urlProtocol(self, didFailWithError: error)
        }

        client.urlProtocolDidFinishLoading(self)
    }

    override func stopLoading() {
        // Required method, implement as a no-op.
    }
}
```
#### Define a custom responding 
Here we make a `MockURLResponder` which always responds to any request with the defined item data.
```Swift
extension Item {
    enum MockDataURLResponder: MockURLResponder {
        static let item = Item(title: "Title", description: "Description")

        static func respond(to request: URLRequest) throws -> Data {
            let response = NetworkResponse(result: item)
            return try JSONEncoder().encode(response)
        }
    }
}
```
#### Extension
An extension to make it easy to initialize a URLSession with an injected `MockURLResponder`
```Swift
extension URLSession {
    convenience init<T: MockURLResponder>(mockResponder: T.Type) {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol<T>.self]
        self.init(configuration: config)
        URLProtocol.registerClass(MockURLProtocol<T>.self)
    }
}
```
## Flakiness caused by asynchronously
For codes that runs asynchronously It might be tempting to use expectations and waiting times but it's generally a recipe for flakiness. However it's better to inject those asynchronously dispatching logic.
instead of 
```Swift
DispatchQueue.main.async {
    //do somrthing
}
```
We can write the below code. we have a condition that checks if it's required to dispatch to main which in our test codes it's not.
```Swift
func performUIUpdate(using closure: @escaping () -> Void) {
    if Thread.isMainThread {
        closure()
    } else {
        DispatchQueue.main.async(execute: closure)
    }
}
```
## Integration Tests
They are for verifying how multiple units actually ==interact (or integrate)== with each other
We usually use real objects but with certain test configuration that limit their functionality related to our tests domain.  For example
* Register a mock`URLProtocol` to `URLsession` and see how other functionalities interact with it.
* Defining a mock path for a FileManager persistence and clear it after tests.