Instead of FIFO, Priority Queues enqueue and dequeue base on their priorities which can be max-priority and min-priority
It's possible to implement priority queues with different data structures
* Sorted Arrays: Inserting and deleting is O(n), Finding max or min is O(1)
* [[Binary Tree#AVL Trees]]: Inserting and deleting is O(logn), Finding max or min is O(logn)
* [[Heap]]: **The best choice**; Inserting and deleting is O(logn), Finding max or min is O(1)
## Implementing with Heap
```swift
struct PriorityQueue<Element: Equatable>: Queue {

	private var heap: Heap<Element> // 2
	init(sort: @escaping (Element, Element) -> Bool,
       elements: [Element] = []) { // 3
		heap = Heap(sort: sort, elements: elements)
  }
  
	var isEmpty: Bool { heap.isEmpty }
	
	var peek: Element? { heap.peek() }
	
	mutating func enqueue(_ element: Element) -> Bool {
		heap.insert(element)
		return true
	}

	mutating func dequeue() -> Element? {
	  heap.remove()
	}
}
```