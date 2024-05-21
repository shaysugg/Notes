# Trees
## Basic Implementation
```Swift 
public class TreeNode<T> {
	public var value: T
	public var children: [TreeNode] = []
	
	public init(_ value: Value) {
		self.value = value
	}

	public func add(_ child: TreeNode<T>) {
		children.append(child)
	}
}
```
# Traversal algorithms
### Depth-first traversal
*use an image to explain*
```Swift
public func depthFirstTraversal(_visit: (TreeNode) -> Void) {
	visit(self)
	for child in children {
		child.depthFirstTraversal(visit: visit)
	}
}
```
### Level-order traversal 
*use an image to explain*
```Swift
public func levelOrderTraversal(_ visit: (TreeNode) -> Void) {
	let queue = Queue<T>()
	queue.enqueue(self)
	while node = queue.dequeue() {
		visit(e)
		for child in e.children {
			queue.enqueue(child)
		}
	}
}
```

