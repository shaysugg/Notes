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

## Binary Tree Traversal algorithms

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
### Height of binary tree
The algorithm is commonly being used in many places. The implementation is brief yet a bit complicated.
```swift
func height<T>(of node: BinaryNode<T>?) -> Int {
	guard let node = node else {
		return -1
	}
	
  return 1 + max(
		height(of: tree.leftChild),
		height(of: tree.rightChild))
}
```
## Binary Search Tree
It's a binary tree with this consideration.
* Every left node is smaller that its parent.
* Every right node is bigger that its parent
Time complexity of its search, insertion and deletion is O(log(n))
### Insertion
```swift
extension BinarySearchTree {

  public mutating func insert(_ value: Element) {
    root = insert(from: root, value: value)
  }
  
  private func insert(from node: BinaryNode<Element>?, value:
Element)
      -> BinaryNode<Element> {
      //end of recursion
    guard let node = node else {
      return BinaryNode(value: value)
    }
    
	//perform recursion based on comparing
    if value < node.value {
      node.leftChild = insert(from: node.leftChild, value:
value)
	} else {
      node.rightChild = insert(from: node.rightChild, value:
value)
	}
	return node 
	}
}
```
* With this insertion It's possible to create **unbalanced** trees, that may result in the lack of good performance or even have the same performance as an array (when there is only one branch in tree) this has been addressed in:
### Find an element
It's not based on recursion!
```swift
public func contains(_ value: Element) -> Bool {
	var current = root
	while let node = current {
	    if node.value == value {
			return true
		}
	    if value < node.value {
	      current = node.leftChild
		} else {
	      current = node.rightChild
	    }
	}
	return false
}
```
### Deletion
There are three possibilities when you trying to delete a node
1) Node has no children (ie leaf): node can be simply removed
2) Node has one child: node can be removed but it's required to connect its child to the rest of the tree
3) Node has two children: It's more complicated ...
Check out the original book for more info.