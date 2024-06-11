* Heap Data Structure is complete (every level is filled except the last one) Binary Trees.
* There are two types of heaps, Max Heap and Min Heap.
* Heap element are ordered based on their value on each parent and child, that means if we have a max heap for each node all of its children has smaller value.
![[max-heap.png]]
## Implementation
* An array is being used internally for heap implementation. we try to simulate the tree structure with a specific array ordering.
* Also we use the same structure for max heaps and min heaps and we differentiate them by a compare closure.
```swift
struct Heap<Element: Equatable> {
	var elements: [Element] = []
	let sort: (Element, Element) -> Bool
	init(sort: @escaping (Element, Element) -> Bool) {
	    self.sort = sort
	}
}```
### Heap ordering formula
`i` is the index of the node in the array
![[heap-array-formula.png]]
base on the top image o we can conclude these properties.
```swift
var isEmpty: Bool {
	elements.isEmpty
}

var count: Int {
	elements.count
}

func peek() -> Element? {
	elements.first
}

func leftChildIndex(ofParentAt index: Int) -> Int {
	(2 * index) + 1
}

func rightChildIndex(ofParentAt index: Int) -> Int {
	(2 * index) + 2
}

func parentIndex(ofChildAt index: Int) -> Int {
	(index - 1) / 2
}
```
## Methods
Most of the heap methods contain sifting. Insertion and deletion both have O(logn) time complexity.
### Deletion
1) First swap the first element with the last element and then remove it, this way we have O(1) for removing the last element in array.
2) After that you need to find a suitable place for the elements that you swapped, so you need to sift it down until you find its place.
*This method as you can see avoids the need of shifting all the elements of the array.*
```swift
mutating func remove() -> Element? {
	guard !isEmpty else {
		return nil
	}
	elements.swapAt(0, count - 1) 
	defer {
		siftDown(from: 0)
	}
	return elements.removeLast()
}

mutating func siftDown(from index: Int) {
	var parent = index // 1
	while true { // 2
	let left = leftChildIndex(ofParentAt: parent) // 3
	let right = rightChildIndex(ofParentAt: parent)
	
	var candidate = parent // 4
	if left < count && sort(elements[left], elements[candidate]){
		candidate = left // 5
}
	if right < count && sort(elements[right],
elements[candidate]) {
		candidate = right // 6
    }
    
	//if you can't find a bigger or smaller child
	if candidate == parent {
		return 
	}
	
	elements.swapAt(parent, candidate) // 8
	parent = candidate
  }

}
```
* swap with last element and remove
![[heap-remove.jpg]]
* Sift down until find a suitable place. 
*Note that if both children are bigger than the element that we're sifting then we choose the bigger child.* 
![[heap-sift-down.jpg]]
### Insertion
```swift
mutating func insert(_ element: Element) {
  elements.append(element)
  siftUp(from: elements.count - 1)
}

mutating func siftUp(from index: Int) {
	var child = index
	var parent = parentIndex(ofChildAt: child)
	while child > 0 && sort(elements[child], elements[parent]) {
		elements.swapAt(child, parent)
		child = parent
		parent = parentIndex(ofChildAt: child)
	}
}
```
![[heap-sift-up.jpg]]
### Remove arbitrary index
```swift
mutating func remove(at index: Int) -> Element? {
	guard index < elements.count else {
		return nil // 1
	}
	if index == elements.count - 1 {
		return elements.removeLast() 
	} else {
	    elements.swapAt(index, elements.count - 1) 
	    defer {
	      siftDown(from: index) 
	      siftUp(from: index)
    }
		return elements.removeLast() 
  }
}
```
*It's needed to perform `siftUp` and `siftDown` to cover all of the edge cases. For more info check the book*
## Building the heap
The elements that is passed through the initializer need to be sorted in the heap structure sorting order, In order to do that It's required to sift down the elements that are not leaf (if they're leaf there is no bottom level exists for them). So we iterate through half of the elements and sift them down.
```swift
init(sort: @escaping (Element, Element) -> Bool,
	elements: [Element] = []) {
	self.sort = sort
	self.elements = elements
	if !elements.isEmpty {
		for i in stride(from: elements.count / 2 - 1, through: 0,
by: -1) {
			siftDown(from: i)
		}
	}
}
```
## Time Complexity
* Insert O(logn)
* delete O(logn)
* peak O(1)
* search O(n)