when testing view controllers is to **not test the views and controls directly.** This is better done using **UI automation** tests. Here, the goal is to check the **logic** and **state** of the view controller.
## Initializing ViewControllers
If we init viewControllers with default initializer aka `ViewController()`, its starting state is not the same as when the app runs. 
We can access our view controller by writing a function that gets the root view controller and a utility to find our view controller in its child.
```Swift 
func getRootViewController() -> RootViewController {
  guard let controller = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?
  .windows
  .first?
  .rootViewController as? RootViewController else {
    fatalError()
  }
  return controller
}
```

``` Swift 
extension RootViewController {
  var stepController: StepCountController {
    return children.first { $0 is StepCountController } as! StepCountController
  }
}
```
## OR
One alternate way of retrieving and testing a view controller can be done as follows: First, get a reference to the storyboard:
```Swift 
let storyboard = UIStoryboard(name: "Main", bundle: nil)
```
Second, get a reference to the view controller:
``` Swift
let stepController = storyboard.instantiateViewcontroller(withIdentifier: "stepController") as! StepCountController
```
Finally, if needed, you may load the view as follows:
``` Swift
stepController.loadViewIfNeeded()
```
Following this pattern allows you to instantiate a fresh view controller for each test, and it affords the option to set up and tear down the view controller for each test.
## Extra Notes
* calling `viewWillAppear` performs view lifecycle events and may have side effects. It's usually better to extract the code that we want to test from it to a different function.