## Legacy Code Change Algorithm Steps
### Identify change points
To change an app, you must figure out where to put that change – that is, figure out which classes and files need to be modified. The first step is understanding the requirements so you know exactly what to implement.
### Find test points
**Test points** are the locations where you need to write tests to support your changes. Test points aren’t about fixing bugs, they are to preserve existing app behavior.
we call this types of tests **Characterization Tests**.
#### Steps of writing a Characterization Test
1) Use the code in a test function.
2) Write an assertion that you expect to fail.
3) Let the failure characterize the behavior.
4) Change the test so that it passes based on the code’s behavior.
The main difference from TDD is in the last step above. **You’ll change the test to match the code, rather than change the code to pass the test.**
### Break dependencies
We need to break our change point dependencies in order to isolate objects in a way that can test them easily without worrying about their dependencies.
### Write tests
Now we implment our new feature using TDD
### Make changes and refactor
Just like TDD when tests passed we see which part of our tests and production code can be refactored