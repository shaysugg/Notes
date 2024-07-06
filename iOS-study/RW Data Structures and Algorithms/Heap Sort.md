Since the maximum or minimum value always going too be the first element of heap (the root of heap tree) we can leverage this feature and build a sort mechanism on top of it. Here is an example of how it works:
## Example
Assume these numbers
`[1, 10, 5, 4, 20, 5, 11, 100, 22, 3]`

If we put them into a heap we're going to have
`[100, 22, 11, 10, 20, 5, 5, 4, 1, 3]`

we will swap the first element which is the maximum number with the final element of the array
`[3, 22, 11, 10, 20, 5, 5, 4, 1, 100]`

Then we will sift down all the elements until the last index
`[20, 10, 11, 4, 3, 5, 5, 1, 22, 100]`

We repeat the same process, each time the amount of sifting is reduces because we don't consider the elements that we swapped to the end of the array in the sifting process. They are in their correct positions. ie we are sorting from the end of the array

Here  is the all the steps for heap sorting the above numbers
```
[22, 20, 11, 10, 3, 5, 5, 4, 1,| 100]
[20, 10, 11, 4, 3, 5, 5, 1,| 22, 100]
[11, 10, 5, 4, 3, 1, 5,| 20, 22, 100]
[10, 5, 5, 4, 3, 1, |11, 20, 22, 100]
[5, 4, 5, 1, 3, |10, 11, 20, 22, 100]
[5, 4, 3, 1, |5, 10, 11, 20, 22, 100]
[4, 1, 3, |5, 5, 10, 11, 20, 22, 100]
[3, 1, |4, 5, 5, 10, 11, 20, 22, 100]
[1, |3, 4, 5, 5, 10, 11, 20, 22, 100]
[|1, 3, 4, 5, 5, 10, 11, 20, 22, 100]
```
The `|` is represent of the fixed sorted part which we don't consider in our sifting
## Code
```swift
extension Heap {
	func sorted() -> [Element] {
		var heap = Heap(elements: elements, sort: sort)
		for index in heap.elements.indices.reversed() {
			heap.elements.swapAt(0, index)
			heap.siftDown(from: 0, upTo: index)
		}
		return heap.elements
	}
}
```