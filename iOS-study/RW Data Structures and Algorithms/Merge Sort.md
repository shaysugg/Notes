Marge sorts are based on divide and conquer techniques.
* Divide: You beak the array in half recursively until you reach a place that you can't break it (until the sub array has 1 element)
* Conquer: Once you reach the end of the dividing you merge the two sub arrays into one array in a sorted format and start reforming the array by merging sorted sub arrays. since in every merge the sub arrays are sorted then you spend log(n) time complexity for building a merged sort array.

![[merge-sort.jpg]]
* Space complexity may not be efficient since you keep creating temporary arrays at each merge
## Implementation
```swift
func mergeSort<Element>(_ elements: [Element]) -> [Element] where Element: Comparable  {
	print("breaking:", elements)
	
	guard elements.count > 1 else { return elements }
	let middle = elements.count / 2
	let left = mergeSort(Array(elements[0..<middle]))
	let right = mergeSort(Array(elements[middle..<elements.count]))
	 return merge(left: left, right: right)

}

func merge<Element>(left: [Element], right: [Element]) -> [Element] where Element: Comparable {

	print("merging:", left, right)
	var leftIndex = 0
	var rightIndex = 0
	var elements = [Element]()

	while leftIndex < left.count && rightIndex < right.count {
		let left = left[leftIndex]
		let right = right[rightIndex]
		if left < right {
			elements.append(left)
			leftIndex += 1
		} else if left > right {
			elements.append(right)
			rightIndex += 1
		} else {
			elements.append(left)
			leftIndex += 1
			elements.append(right)
			rightIndex += 1
		}
	}
	
	if leftIndex < left.count {
		elements.append(contentsOf: left[leftIndex ..< left.count])
}

	if rightIndex < right.count {
		elements.append(contentsOf: right[rightIndex ..< right.count])
}
	return elements
}
```
for sorting these numbers
`var numbers = [1, 10, 5, 4, 20, 5, 11, 100, 22, 3]`
here is the order of breaking s and merging s
```
**breaking: [1, 10, 5, 4, 20, 5, 11, 100, 22, 3]**
**breaking: [1, 10, 5, 4, 20]**
**breaking: [1, 10]**
**breaking: [1]**
**breaking: [10]**
**merging: [1] [10]**
**breaking: [5, 4, 20]**
**breaking: [5]**
**breaking: [4, 20]**
**breaking: [4]**
**breaking: [20]**
**merging: [4] [20]**
**merging: [5] [4, 20]**
**merging: [1, 10] [4, 5, 20]**
**breaking: [5, 11, 100, 22, 3]**
**breaking: [5, 11]**
**breaking: [5]**
**breaking: [11]**
**merging: [5] [11]**
**breaking: [100, 22, 3]**
**breaking: [100]**
**breaking: [22, 3]**
**breaking: [22]**
**breaking: [3]**
**merging: [22] [3]**
**merging: [100] [3, 22]**
**merging: [5, 11] [3, 22, 100]**
**merging: [1, 4, 5, 10, 20] [3, 5, 11, 22, 100]**
**[1, 3, 4, 5, 5, 10, 11, 20, 22, 100]**
```

