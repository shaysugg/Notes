These 5 sections are general rules that you want to consider when designing and API using swift
## What developers want?
> The first time a developer interacts with a new piece of code, they have certain hopes and expectations.

* It should be obvious
* It should be well documented
* Reduces mental load
* Being modern (language features)
## What is the core of your API? (Access Levels)
![[access-levels.png]]
You may want to use final for forbidding inheritance capabilities on a class.
* you can go to the `related items` icon (picture below) and select `Generated Interfaces` to have an overall view of how your class api looks
![[related-items.png]]
## Modern language features
[[Modern language features]]
## Documenting your code
Use `command + option + /` to get a place holder for documentations in markdown format.
Example:
```Swift
/// Add the fist two parameters value and return the results.
///
/// ```swift
/// let c = sum(a:1, b:2)
/// ```
/// - **Parameters**:
///   - a: first parameter
///   - b: second parameter
///
/// - **note**: Use this function to add two values
///
/// - **Throws**: if the numbers are negative

func sum(a: Int, b: Int) throws -> Int {  }
```
Addition to parameters, returns, throwing these are the other metadata that Xcode recognize.
![[documetation-meta-data.png]]

## Publish to world
### Versioning
```
<major> . <minor> . <patch>
2.3.11

<major> . <minor> . <patch> - <pre-release> + <meta-data>
2.3.11-beta.2+11132
```
major contains **breaking** changes while minor has compatible changes.
meta data usually contains build number.
prerelease values can be something like `rc.1 , beta.2, alpha.13` (`rc` = release candidate)

<hr>

[Swift API Design Guidelines](https://www.swift.org/documentation/api-design-guidelines/#argument-labels)

