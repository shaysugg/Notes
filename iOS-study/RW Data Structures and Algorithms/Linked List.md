# Linked List
*(see playground examples for better understanding)*

linked list is a collection of nodes. Each node holds a value and has a reference to the next node.

-   Linked lists are linear and unidirectional. As soon as you move a reference from one node to another, you can’t go back.
    
-   Linked lists have a O(1) time complexity for head first insertions. Arrays have O(n) time complexity for head-first insertions.
    
-   Conforming to Swift collection protocols such as Sequence and Collection offers a host of helpful methods for a fairly small amount of requirements.
    
-   Copy-on-write behavior lets you achieve value semantics.

## Linked List Operations
* **push**: Adds a value at the front of the list. (head-first insertion) O(1)
* **append**: Adds a value at the end of the list.(tail-end insertion) O(1)
* **insert(after:)**: Adds a value after a particular node of the list. O(1)
* **pop**: Removes the value at the front of the list. O(1)
* **removeLast**: Removes the value at the front of the list. O(n)
* **remove(after:)**: Removes a value anywhere in the list. O(1)
* **node(at)**: returns a node at given index. O(n)

## Value semantics and copy-on-write
Since linked list are heavy depended on the reference types if we have two linked list that second one did copied from the first one then some mutation on one of these linked list could have some side affects on another.
```Swift
example(of: "array cow") {
  let array1 = [1, 2]
  var array2 = array1

  print("array1: \(array1)")
  print("array2: \(array2)")

  print("---After adding 3 to array 2---")
  array2.append(3)
  print("array1: \(array1)")
  print("array2: \(array2)")
}
//👇🏻 OUTPUT
//List1: 1 -> 2
//List2: 1 -> 2
//After appending 3 to list2
//List1: 1 -> 2 -> 3
//List2: 1 -> 2 -> 3
```
then we introduce a copy on write functionality and we implement it as a private function named `copyNodes` and use it on every function that has **mutating** signature.

Since copyNodes is an O(n) function we need to do our best to optimize it. two ways of optimizing it are:
* **isKnownUniquelyReferenced**
* **minor predicament**
