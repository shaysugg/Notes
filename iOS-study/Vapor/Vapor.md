# Introduction
## Setup a vapor project? 

```Shell
brew install vapor #installing
vapor new myServerName #create a new project

# run the project
cd myServerName
swift run
```

## Add some routes
1) open `Package.swift`
2) go to `routes.swift`
3) by adding this code there, if you open `http:// localhost:8080/hello/vapor`, there is a text that says "Hello Vapor!"
```Swift
app.get("hello", "vapor") { req -> String in 
	return "Hello Vapor!" 
}
```

### Reading Parameters from URL
by adding `:` you can parse that part of url as a parameter like this example:
```Swift
app.get("hello", ":name") { req -> String in
	guard let name = req.parameters.get("name") else { 
		throw Abort(.internalServerError)
	}
	return "Hello, \(name)!" 
 }
```
 
### Working with JSON
first define our models and conform them to `Content`
```Swift
struct InputInfo: Content {
	let bar: String
}

struct OutputInfo: Content {
	let zoo: String 
}

app.post("foo") { req -> OutputInfo in
	let input = try req.content.decode(InputInfo.Self)
	return OutputInfo(zoo: input.bar)
}
```

