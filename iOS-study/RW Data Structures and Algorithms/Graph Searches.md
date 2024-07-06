## Breadth-First Search
* You choose a vertex
* You check all of it's neighbors that you haven't already check
* Once you check all of the vertices the search is finished
### Implementation
A queue is used to implement it, somehow in the same way that it being used to implement breadth-first searches in trees.
```swift
extension Graph where Element: Hashable {

	func breadthFirstSearch(from source: Vertex<Element>) -> [Vertex<Element>] {
		var queue = QueueArray<Vertex<Element>>()
		var enqueued = Set<Vertex<Element>>()
		var visited = [Vertex<Element>]()
		
		queue.enqueue(source)
		enqueued.insert(source)
		
		while let vertex = queue.dequeue() {
			if enqueued.contains(vertex) { continue }
			visited.append(vertex)
			let edges = edges(from: vertex)
			for edge in edges {
				queue.enqueue(edge.destination)
				enqueued.insert(edge.destination)
			}
		}
		
		return visited
	}
}
```
## Depth-First Search
* You choose a vertex
* You go to one of its neighbors and push the vertex into a stack
* You continue traversing neighbors until
	* You reach a dead end (vertex has no neighbors)
	* All the vertex neighbors have been already pushed into stack
* Pop the stack (go back to the previous vertex)
* Repeat the process until the stack become empty
### Implementation
As it mentioned a stack is being used to implement it. 
```swift
func depthSearch(from source: Vertex<Element>) -> [Vertex<Element>] {
	var stack = Stack<Vertex<Element>>()
	var pushed = Set<Vertex<Element>>()
	var visited = [Vertex<Element>]()
	
	stack.push(source)
	pushed.insert(source)

	while !stack.isEmpty {
		let neighbors = edges(from: stack.last!)
		let neighborsDestinations = neighbors.map(\.destination)      
		let stop = neighbors.isEmpty || Set(neighborsDestinations).isSubset(of: pushed)
		if stop {
			let element = stack.pop()
			visited.append(element!)
			print("Poped: ", element!.data)
		}
		
		if let next = neighbors.first(where: {!pushed.contains($0.destination)}) {
			stack.push(next.destination)
			pushed.insert(next.destination)
			print("Pushed: ", next.destination.data)
			}
		}
	return visited
	}
```
*The code here is something that I write on myself and is different from book. But for our use case apparently it's working*
