* Import framework by `#import Testing`
* Tests can be global functions
* Tests should start with `@Test`
* they can belong to a certain actor for example putting `@Mainactor` in front of the main actor execute the function code in the main actor
* `#expect()` checking expectation of test. 
		Accepts a boolean (equality of objects, isEmpty, contains)
* `#require()` macro is for checking conditions before start the test. 
	 Works with bool and optionals
	`try #requre(Object.optionalProperty)`
* It's possible group tests together using structs or enums addition to classes (then we can run them as group) (the type called tests suites)
	* It's possible to use nested types to have hierarchy of tests
	* We can store property in suite
	 * ==Property never shared between two cases!== they never get mutated by tests
* Traits: we can pass a descriptions, when test runs, how test behaves. example @Test("description")
 ![[traits.png]]
## Common workflows
### Tests with conditions
* Run tests in a specific conditions with `@Test(.enable(if: condition))`
* Disable tests with`@Test(.disable("description"))`
* Attach bug info with @test(.bug()), It will show in tests debugger in XCode
* Check condition availability with `@test @available(macOS15, *)` instead of check it inside the body of test
### test with common characteristics
* You can apply tags to tests for grouping them (How to write a new tag??)
* Also available to apply it to suits `@suite(.tags(.formatting))`
### test with different arguments
Useful for tests that perform a certain work, only different in the initial values that they run test on.
* Add an argument to test function
* Provide arguments trait
```swift

@Test("Number of mentioned continents", arguments: [
        "A Beach",
        "By the Lake",
        "Camping in the Woods",
        "The Rolling Hills",
        "Ocean Breeze",
        "Patagonia Lake",
        "Scotland Coast",
        "China Paddy Field",
    ])
    func mentionedContinentCounts(videoName: String) async throws {
        let videoLibrary = try await VideoLibrary()
        let video = try #require(await videoLibrary.video(named: videoName))
        #expect(!video.mentionedContinents.isEmpty)
        #expect(video.mentionedContinents.count <= 3)
    }
```

## Swift test and XCTest
* Swift tests can run on real device!(how?)
* By using `#expect()` you're not required to remember all those XCTest expect function
* Using `#expect()` and `#require()` will differentiate the use case of condition whereas in XCTest you can only use XCTest expectations for both
* you can setup things in `init()` of struct suit. If you need teardown you can use class suit `deinit`
* It's possible to group test in sub groups in swift tests.
Major different between two.
![[xctest-vs-swiftest.png]]
For migrating check: [migrating a test from xctets](https://developer.apple.com/documentation/testing/migratingfromxctest)

Run package tests from command line with `swift test`