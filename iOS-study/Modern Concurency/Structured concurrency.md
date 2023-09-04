* 🟢 Structured Tasks: `async let` and `TaskGroup`
	leave until the scope exists and cancel when they get out of scope
* 🟡 Unstructured Tasks: `Task` and `Task.detached`

Prefer structured concurrency over unstructured concurrency whenever is possible