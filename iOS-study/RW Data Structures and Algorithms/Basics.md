# Data Structures and Algorithms
## Time Complexities
* **O(1)** : Linear Functions
* **O(n)**: For-Loop Functions
* **O(n^2)**: Two For-Loop functions inside each other
* **O(log n)**: better than O(n),
	 *Example: Presume we want to find an element in a sorted array, Instead of searching through the whole array we can divide it in two and see in which part our element exists, then divide that part and check again, until we found the element*
```Swift
let numbers = [1, 3, 56, 66, 68, 80, 99, 105, 450]

//🔴 O(n)
func naiveContains(_ value: Int, in array: [Int]) -> Bool {
  for element in array {
	    if element == value {
		return true
	} }
	return false
}

//🟢 O(log n)
func naiveContains(_ value: Int, in array: [Int]) -> Bool {
  guard !array.isEmpty else { return false }
  let middleIndex = array.count / 2

	if value <= array[middleIndex] {
    for index in 0...middleIndex {
		if array[index] == value {
			return true
	} }
	} else {
    for index in middleIndex..<array.count {
	    if array[index] == value {
			return true
	} }
	}

	return false
}
```
* **O(n log n)**: Better than O(n^2)

## Space Complexities
*Kinda unclear right now, check the original book example (page37)*

## Swift Standard Library Data Structures
### Array
* Order
* Random Access:
	Random-access is a trait that data structures can claim if they can handle **element retrieval** in a **constant amount of time.**
* Insertion:
	**appending** is a **random-access** operation. It means It takes a constant time to add something at the end of the array no matter how long the array is, how ever **Insertion** performance can be **different** and is based on two factors:
	1) **Insert location**: All the other location **after insertion index** should shift away. For example in the worse scenario if we have a n long array and we inserted at the first index all the n elements should shift away! *which is not desired.*
	2) **Capacity**: if memory that dedicated for the array ran out then it needed to get copied and new amount of memory needs to dedicate to it. *which cost memory and time*

### Dictionary
* not Ordered
* Insertion take same amount of time without depending on how long array is
* Look up operation works faster than array *in an array requires a walk from the beginning of the array to the insertion point.*

### Set
> A set is a container that holds unique values. Imagine it being a bag that allows you to insert items into it, but rejects items that have already been inserted.


