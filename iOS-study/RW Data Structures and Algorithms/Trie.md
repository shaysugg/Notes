Good for tree representation of collections that have common elements, By avoiding repetitive sub collections that are common between different collections.
![[trie.png]]
```swift
public class TrieNode<Key: Hashable> {
  public var key: Key?
  public weak var parent: TrieNode?
  public var children: [Key: TrieNode] = [:]
  public var isTerminating = false // is the last element
}

public class Trie<CollectionType: Collection>
    where CollectionType.Element: Hashable {

  public typealias Node = TrieNode<CollectionType.Element>
  private let root = Node(key: nil, parent: nil)
  public init() {}
}
```
**Note that the root doesn't have a value.**
`for` iteration instead is being used in all of its methods instead of recursions.
## Insert
```swift
public func insert(_ collection: CollectionType) {
  var current = root
  for element in collection {
	if current.children[element] == nil {
		current.children[element] = Node(key: element, parent:
current)
}
	current = current.children[element]!
	}
	current.isTerminating = true
}
```
## Contains
```swift
public func contains(_ collection: CollectionType) -> Bool {
  var current = root
  for element in collection {
		guard let child = current.children[element] else {
			return false
		}
		current = child
	}
  return current.isTerminating
}
```
## Remove
1) First you travers the tree to see if the collection fully exists.
2) Then you check that if the collection that you find doesn't have any following elements or in other words it is terminating.
3) And finally you traverse backwards until you reach the root node. Meanwhile you remove nodes with two conditions.
* They are terminating
* and they don't have any children.
```swift
public func remove(_ collection: CollectionType) {
	var current = root
	for element in collection {
		guard let child = current.children[element] else {
			return
		}
	current = child
	}
	guard current.isTerminating else {
		return
	}
	current.isTerminating = false
	while let parent = current.parent,
	current.children.isEmpty && !current.isTerminating {
	parent.children[current.key!] = nil
	current = parent
	} 
}
```
## Subranges
Initially the prefix will be checked to see if it's exist in the trie or not. Then we start accumulating each collection that we can find with the prefix by calling a recursive function.
*see the project for implementations*
