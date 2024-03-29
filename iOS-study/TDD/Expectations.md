For testing an asynchronous code.
```Swift 
let expected = expectation(description: "callback happened")
  sut.stateChangedCallback = { model in
    observedState = model.appState
    expected.fulfill()
  }

  // when
  sut.pause()

  // then
  wait(for: [expected], timeout: 1)
  XCTAssertEqual(observedState, .paused)
```
## Waiting for a specific notification
``` Swift
expectation(
    forNotification: AlertNotification.name,
    object: sut,
    handler: nil)
```
## Wait to call multiple times
Setting `expectedFulfillmentCount` to two means the expectation won’t be met until fulfill() has been called twice before the timeout.
```Swift 
exp.expectedFulfillmentCount = 2
```
## Expecting something not to happen
``` Swift
exp.isInverted = true
```
## Waiting for a condition
define a NSPredicate and make a expectation with it
``` Swift
let predicate = NSPredicate { model, _ -> Bool in
  (model as? AppModel)?.pedometerStarted ?? false
}

let exp = expectation(
  for: predicate,
  evaluatedWith: sut,
  handler: nil)
// when
try! sut.start()
// then
wait(for: [exp], timeout: 1)
XCTAssertTrue(sut.pedometerStarted)
```
