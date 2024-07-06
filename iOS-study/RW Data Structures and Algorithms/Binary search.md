Useful for sorted array, search can be performed with o(logn) time complexity.
It's started with the middle of the array, then based on the value is bigger of smaller than the value the index will be jumped to the the middle of the the first half or the middle of the second half. this process will go on until the element will be found.
## Example
Regular search
![[bs1.png]]
Binary search
![[bs2.png]]
## Implementation
It make sense to implement binary search functionality on any array that can be sorted which means its elements are comparable.
```swift
public extension RandomAccessCollection where Element:
Comparable {

	func binarySearch(for value: Element, in range: Range<Index>?
= nil) -> Index? {
		//...
	} 
}
```

```swift
let range = range ?? startIndex..<endIndex
guard range.lowerBound < range.upperBound else {
	return nil
}

let size = distance(from: range.lowerBound, to:
range.upperBound)
let middle = index(range.lowerBound, offsetBy: size / 2)

if self[middle] == value {
	return middle
} else if self[middle] > value {
	return binarySearch(for: value, in: range.lowerBound..<middle)
} else {
	return binarySearch(for: value, in: index(after:
middle)..<range.upperBound)
}
```