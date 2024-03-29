> Test-driven development, or TDD, is an iterative way to create software by **making many small changes** backed by **tests**
## TDD Cycle
![](./attachments/TDD_cycle.png)

* **Write a failing test**
*  **Make the test pass**
	Write the **minimum** amount of code to make the test pass
* **Refactor**
	Clean up test(s) and code as needed (refactor).
* **Repeat**
	Repeat the process until you cover all the logic cases.
## Naming Tests
``` Swift
func testAppModel_whenStarted_isInInProgressState() {}
```
1) All tests must begin with `test`.
2) `AppModel` This says an AppModel is the system under test (sut).
3) `whenStarted` is the condition or state change that is the catalyst for the test.
4) `isInInProgressState` is the assertion about what the sut’s state should be after the when
## What Should write test
* **Do** write tests for code that can’t be caught in an automated fashion otherwise. This includes code in your classes’ methods, custom getters and setters and mostly anything else you write yourself.
* **Don’t** write tests for generated code. 
* **Don’t** write tests for issues that can be caught by the compiler. If the tested issue would generate an error or warning, Xcode will catch it for you.
* **Don’t** write tests for dependency code, such as first- or third-party frameworks your app uses. The framework authors are responsible for writing those tests. 
## Test target structure
```
Test Target
  ⌊ Cases
     ⌊ Group 1
        ⌊ Tests 1
        ⌊ Tests 2
     ⌊ Group 2
        ⌊ Tests
  ⌊ Mocks
  ⌊ Helper Classes
  ⌊ Helper Extensions
```
