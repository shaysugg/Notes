# Queue
A data structure mainly use for implementing **FIFO** (first in first out) behavior.
```Swift
public protocol Queue {
	assosiatedtype Element
	
	//returns true if operation was successfull
	mutating func enqueue(_ element: Element) -> Bool
	mutating func dequeue() -> Element
	
	var isEmpty: Bool { get }
	var peek: Element? { get }
}
```
## Implementations
It can be implemented by using:
* An Array
* A doubly Linked List
* A ring buffer
* Two Stacks
### Array Based Implementation
The most easiest implementations with worst time and space usage.
```Swift
public mutating func enqueue(_ element: T) -> Bool {
	array.append(element)
	return true
}

public mutating func dequeue() -> T? {
  isEmpty ? nil : array.removeFirst()
}
```
<table>
	<tr>
		<th>Operations</th>
		<th>Average case</th>
		<th>Wrost case</th>
	</tr>
	<tr>
		<td>enqueue</td>
		<td>O(1)</td>
		<td>O(n)</td>
	</tr>
	<tr>
		<td>dequeue</td>
		<td>O(n)</td>
		<td>O(n)</td>
	</tr>
	<tr>
		<td>Space Complexity</td>
		<td>O(n)</td>
		<td>O(n)</td>
	</tr>
</table>

### Doubly Linked List Implementation
[A doubly linked list](https://www.geeksforgeeks.org/doubly-linked-list/) is simply a linked list in which nodes also contain a reference to the previous node.
TODO: It is also possible with regular linked list???
```Swift
//Doubly linked list node
class Node<Value> {
	var value: Value
	var next: Node?
	var previous: Node?
}
```

```Swift
public class QueueLinkedList<T>: Queue {
	private var list = DoublyLinkedList<T>()
	public init() {}

	public func enqueue(_ element: T) -> Bool {
		list.append(element)
		return true
	}

	public func dequeue() -> T? {
		guard !list.isEmpty, let element = list.first else {
			return nil
		}
		return list.remove(element)
	}
}
```

<table>
	<tr>
		<th>Operations</th>
		<th>Average case</th>
		<th>Wrost case</th>
	</tr>
	<tr>
		<td>enqueue</td>
		<td>O(1)</td>
		<td>O(1)</td>
	</tr>
	<tr>
		<td>dequeue</td>
		<td>O(1)</td>
		<td>O(1)</td>
	</tr>
	<tr>
		<td>Space Complexity</td>
		<td>O(n)</td>
		<td>O(n)</td>
	</tr>
</table>

### Ring Buffer Implementation
[A Ring buffer](https://github.com/raywenderlich/swift-algorithm-club/tree/master/Ring%20Buffer) is a fixed size array with two pointers for **write** and **read**. once the pointer is reached the end of array It goes back to the beginning and overwrite the elements.
On **enqueue** the **write pointer** will shift one element and on **dequeue** the read pointer will shift one element.
*Buffer is empty when read pointer and write pointer are in the same place*
```Swift
public mutating func enqueue(_ element: T) -> Bool {
	ringBuffer.write(element)
}

public mutating func dequeue() -> T? {
	ringBuffer.read()
}
```
<table>
	<tr>
		<th>Operations</th>
		<th>Average case</th>
		<th>Wrost case</th>
	</tr>
	<tr>
		<td>enqueue</td>
		<td>O(1)</td>
		<td>O(1)</td>
	</tr>
	<tr>
		<td>dequeue</td>
		<td>O(1)</td>
		<td>O(1)</td>
	</tr>
	<tr>
		<td>Space Complexity</td>
		<td>O(n)</td>
		<td>O(n)</td>
	</tr>
</table>

**Ring buffer** implementation has the **same time complexity** as **Doubly linked list** implementation. the difference is Ring Buffer has a **constant space complexity** but it can **fail**. *Fails when write pointer has circled once and about to past the read pointer.*

## Two Stack Implementation
When you enqueue you add the element to the right stack, when you dequeue you reverse the right stack (if needed) into left stack and pop form it, in order to get the FIFO behavior.
```Swift
public mutating func enqueue(_ element: T) -> Bool {
	rightStack.append(element)
	return true
}

public mutating func dequeue() -> T? {
	// you only gonna perforem reversed on right stach when left stack is empty
  if leftStack.isEmpty { 
		leftStack = rightStack.reversed()
		rightStack.removeAll() 
	}
  return leftStack.popLast() 
}
```

<table>
	<tr>
		<th>Operations</th>
		<th>Average case</th>
		<th>Wrost case</th>
	</tr>
	<tr>
		<td>enqueue</td>
		<td>O(1)</td>
		<td>O(n)</td>
	</tr>
	<tr>
		<td>dequeue</td>
		<td>O(1)</td>
		<td>O(n)</td>
	</tr>
	<tr>
		<td>Space Complexity</td>
		<td>O(n)</td>
		<td>O(n)</td>
	</tr>
</table>

*better than the linked list in terms of spacial locality. This is because array elements are next to each other in memory blocks. So a large number of elements will be loaded in a cache on first access.*