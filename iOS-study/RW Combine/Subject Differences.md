`CurrentValuseSubjects` required an initial value but `PassthroughSubject` won't accept an initial value.
Upon subscription of `CurrentValuseSubjects` the subscriber closure will be evaluated for once with the latest submitted value. However for the `PassthroughSubject` no matter if a value was submitted or not the closure will not run.
```Swift
let relay = PassthroughSubject<String, Never>()

relay.send("Initial")

let subscription = relay
.sink { value in
	print(value)
}

relay.send("Hello")
relay.send("World!")

//Output: Hello, World

let variable = CurrentValueSubject<String, Never>("Initial")

variable.send("After Initial")

let subscription2 = variable.sink { value in
	print(value)
}

variable.send("More text")

//Output: After Initial, More Text
```