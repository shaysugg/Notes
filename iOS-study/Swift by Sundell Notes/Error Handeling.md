## List of Errors
### Recoverable 
- **Return `nil` or an error enum case**. 
- **Throwing an error** (using `throw MyError`)
### None-Recoverable 
- **Using `assert()` and `assertionFailure()`** to verify that a certain condition is true. Per default, this causes a fatal error in debug builds, while being ignored in release builds. It’s therefor **not** guaranteed that execution will stop if an assert is triggered, so it’s kind of like a severe runtime warning.

- **Using `precondition()` and `preconditionFailure()`** instead of asserts. The key difference is that these are **always*** evaluated, even in release builds. That means that you have a guarantee that execution will never continue if the condition isn’t met.

- **Calling `fatalError()`** — which you have probably seen in Xcode-generated implementations of `init(coder:)` when subclassing an `NSCoding`-conforming system class, such as `UIViewController`. Calling this directly kills your process.

- **Calling `exit()`**, which exists your process with a code. This is very useful in command line tools and scripts, when you might want to exit out of the global scope (for example in `main.swift`).