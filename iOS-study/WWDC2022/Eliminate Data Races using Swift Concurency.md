This explanation may not be helpful much, check the original video*

For better understanding between sharing data between different tasks let see this example:
* assume each **task** represented as **boat**
* and each **data** items in it represent as an **object**
* If two **boat (task)** meet and want to **share** items (data), we should be sure that data is about to share is safe to mutate from two different boats (tasks). 
* So programmatically **Value Types** like Structs and Enums are safe to share (new copy of them would be created and shared) but **Reference Types** like classes are not (because reference of them get shared). 
* Being safe to share between two tasks means conforming to **Sendable Protocol** and all data that get share between two tasks should conform to it. 

<hr>

For better understanding standing of isolate classes that multiple tasks can safely mutate it lets see this example

* Assume each **actor** represented as an **island**
* and again each **task** represented as a **boat**
* Island can have some items (data) and it can mutate them only from inside of itself (by a function)
* So the island(actor) can get shared and different boat(tasks) can mutate items(data) of island(actor) (using internal mutating function that island has)
* Accessing to actor always should await, because some other task may mutating it at the same time
* Non-Sendable data cannot share between a task and an actor.

<hr>
[Original Video 🎥](https://developer.apple.com/videos/play/wwdc2022/110351/)