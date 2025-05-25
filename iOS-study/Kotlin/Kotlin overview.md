[Overview](https://kotlinlang.org/docs/basic-syntax.html#program-entry-point)
[Get started](https://kotlinlang.org/docs/getting-started.html#install-kotlin)
[Coroutines](https://developer.android.com/kotlin/coroutines)
[Tests](https://kotlinlang.org/api/latest/kotlin.test/kotlin.test/)
## Unfamiliar things
### Package and imports
Packages are for grouping and connecting what it is inside the file to a specific package.
If you do not specify package their going to be connected to default package

imports are for importing packages or types inside packages.

Defining new types and functions for a package
```kotlin
//FILE: Message
package org.example

fun printMessage() { /*...*/ }
class Message { /*...*/ }
```

```kotlin
//FILE: Hello World
package org.example.printMessage

printMessage()
```
### Inline functions
```Kotlin
fun sum(a: Int, b: Int) = a + b
```
### Classes
Inline properties
```Kotlin
class Rectangle(val height: Double, val length: Double) {
    val perimeter = (height + length) * 2
}
```
**You're going to get a generated init if you declare properties like this.**

If a class needed to be inherited from add `open` to its declaration
## Conditional expressions
Inline if
```Kotlin
fun maxOf(a: Int, b: Int) = if (a > b) a else b
```

## Companion Objects
For adding static like behaviors in classes
```kotlin
class MyClass {
    companion object {
        const val PI = 3.14159
        
        fun sayHello() {
            println("Hello from MyClass!")
        }
    }
    
    // instance members of MyClass
    fun doSomething() {
    //directly access companion properties and methods inside the class
        println("Doing something in MyClass instance. $PI")
        
    }
}

//statically access comapnion properties outside of class
MyClass.PI 
MYClass.doSomething
```

## Optional unwrap```
```Kotlin

fun check(string: String?): Boolean {
	//perform operation with possibility of nullability
	val result = string?.let {it.lentgh > 5}

	//default values with ?:
	return result?.value ?: false
}
```

## Suspending functions
For functions that takes time to finish (like async await)
```Kotlin
suspend func getList(): List<String> {
//...
}

```
This is How to retrieve the result but we block the execution therefore we have to define the function suspend again
```Kotlin
suspend fun printList() {
	getList().also {
	
	println($it)
}
}
```
This way we can consume the result in ViewModels without blocking the current thread
```Kotlin
class Vm: MyViewModel() {
	fun printStuff() {
		viewModelScopr.launch {
			printList()
		}
	}
}
```
## Switch cases
```Kotlin
val obj = "Hello"

when (obj) {
    "1" -> println("One")
    "Hello" -> println("Greeting")
    else -> println("Unknown")     
}
```
## Sealed class
limit the inheritance capability of class into nested classes or in the same file. Can have enum traits and easily can be used with `when`.  Good options for defining models.
```kotlin
sealed class Shape {
    class Circle(val radius: Double) : Shape()
    class Rectangle(val width: Double, val height: Double) : Shape()
}


when (shape) {
        is Shape.Circle -> Math.PI * shape.radius * shape.radius
        is Shape.Rectangle -> shape.width * shape.height
}


```

```kotlin
sealed class Result<out R> {
    data class Success<out T>(val data: T) : Result<T>()
    data class Error(val exception: Exception) : Result<Nothing>()
}
```
## Coroutines
some functions can block the current thread either they're marked with suspend (main safe) or without suspend (not main safe)
All of the should be called inside a coroutines. ViewModels have their own scope of coroutines and you can create a coroutine like
```kotlin
viewModelScope.launch(Dispatchers.IO) {
	loginRepository.makeLoginRequest(jsonBody)
}
```
if ViewModel gets deallocated then all the associated coroutines will be cancelled

**A better approach** can be building and returning like
```kotlin
suspend fun makeLoginRequest(
        jsonBody: String
    ): Result<LoginResponse> {
        // Move the execution of the coroutine to the I/O 
        return withContext(Dispatchers.IO) {
            // Blocking network request code
        }
    }
```
However you still need to run it `viewModelScope.launch`. Note that thread specification `Dispatchers.IO` is not required in ViewModel. Also since you are specifying it in the `makeLoginRequest` you can safely handle UI Code inside the ViewModel.