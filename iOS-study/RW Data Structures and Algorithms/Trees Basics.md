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

# Binary Trees
A tree which every node has exactly two child, left and right
```Swift
public class BinaryNode<Element> {

	public var value: Element
	public var leftChild: BinaryNode?
	public var rightChild: BinaryNode?

	public init(value: Element) {
	    self.value = value
	}
}
```

## Traversal algorithms

### In-order traversal (LCR)
![binary-tree-lcr](./Images/binary-tree-lcr.png)
```Swift
public func traversInOrder(visit: (TreeNode) -> Void) {
	letfChild?.traversInOrder(visit)
	visit(self)
	rightChild?.traversInOrder(visit)
}
```
### Pre-order traversal (CLR)
![binary-tree-lcr](./Images/binary-tree-clr.png)
```Swift
public func traversPreOrder(visit: (TreeNode) -> Void) {
	visit(self)
	letfChild?.traversPreOrder(visit)
	rightChild?.traversPreOrder(visit)
}
```
### Post-order traversal (LRC)
![lrc](Images/binary-tree-lrc.png)
```Swift
public func traversPostOrder(visit: (TreeNode) -> Void) {
	letfChild?.traversPostOrder(visit)
	rightChild?.traversPostOrder(visit)
	visit(self)
}
```