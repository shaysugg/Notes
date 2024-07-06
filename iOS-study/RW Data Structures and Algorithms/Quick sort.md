Quick sort uses the divide and conquer same as [[Merge Sort]], However the main differences are:
* It doesn't require extra space for sorting. It can sort on the same array
* In merge sort you divide the array into two subarray with the same length. This isn't a case for quick sort since there are multiple partitioning strategies that help to divide in a more balanced way.
* The worst time complexity is O(n^2) which is greater than merge sort but overall it's a more suitable option for sorting mainly because it doesn't require additional space.
## Partitioning Strategies
### No Strategy
*It's an arbitrary thing mostly for educational purposes.*
It acts mostly like the merge sort you recursively divide the array in half. It's not really beneficial to use because:
* Picking the middle element it's not always the best
* You're not sorting in place. Have to dedicate extra memory.
```
[1, 10, 5, 4, 11, 5, 20, 100, 8]

pivot = 11
[1, 10, 5, 4, 5, 8] [11] [20, 100]
	pivot = 4
	[1] [4] [5, 5, 8]
			pivot = 5
			[] [5] [5, 8]

// flat the hiarechy
1, 4, 5, 8, 11, 20, 100
```

### Lomuto partitioning
* Consider the ==last element== as pivot.
* Use two pointers to the beginning of the array.
* You traverse the array with j
* Swap items that are smaller than element that j is pointing to with the pivot.
* Increase the i if you swap elements
* When you reach the final element swap it with with i
![[quicksort-lomuto-1.jpg]]
![[quicksort-lomuto-2.jpg]]
result
```
[1, 5, 4, 5 | 8 | 10, 11, 100, 20]
```
#### Code
```swift
public func partitionLomuto<T: Comparable>(_ a: inout [T],low: Int, height: Int) -> Int
	let pivot = a[high]

	var i = low // 2
	for j in low..<high {
		if a[j] <= pivot {
			a.swapAt(i, j)
			i += 1 
		}
	}
	a.swapAt(i, high)
	return i
}

public func quicksortLomuto<T: Comparable>(_ a: inout [T], low: Int, high: Int)
{
	if low < high {
		let pivot = partitionLomuto(&a, low: low, high: high)
		quicksortLomuto(&a, low: low, high: pivot - 1)
		quicksortLomuto(&a, low: pivot + 1, high: high)
	} 
}
```
### Hoare partitioning
* Consider the ==first element== as pivot.
* Use two pointers i and j, i pointing to the beginning of the array j pointing to the end.
* Traverse forward with i and backward with j
* Stop i when `a[i] > pivot`, stop j when `a[j] < pivot`
* Swap the `a[i]` and `a[j]`
* Repeat until j become smaller than i
![[quicksort-hoare.jpg]]
#### Code
```swift
public func partitionHoare<T: Comparable>(_ a: inout [T], low: Int, high: Int) -> Int {
	let pivot = a[low]
	var i = low - 1
	var j = high + 1
	while true {
		repeat { j -= 1 } while a[j] > pivot
		repeat { i += 1 } while a[i] < pivot
		if i < j {
			a.swapAt(i, j)
		} else {
			return j
		}
	}
}

public func quickSortHoare<T: Comparable>(_ a: inout [T], low: Int, high: Int, verbose: Bool = false) {
	if low < high {
		let p = partitionHoare(&a, low: low, high: high)
		quickSortHoare(&a, low: low, high: p)
		quickSortHoare(&a, low: p + 1, high: high)
	}
}
```
### Median of Three
*TODO: didn't quite understand this*
the problem with choosing the last or beginning element as pivot is they are possible to not be close to the average values in the array.
for example
```swift
[8, 7, 6, 5, 4, 3, 2, 1]
//lomuto partitioning results in
less: [ ]
equal: [1]
greater: [8, 7, 6, 5, 4, 3, 2]
```
you can see the partitioning wont help us that much in these scenarios and we may ended up with O(n^2) time complexity. In order to fix that before partitioning we use a solution called median of three which prevents us from picking the lowest or highest elements in array:z

```swift
public func medianOfThree<T: Comparable>(_ a: inout [T], low: Int, high: Int) -> Int {
	let center = (low + high) / 2
	if a[low] > a[center] {
	    a.swapAt(low, center)
	}
	if a[low] > a[high] {
		a.swapAt(low, high)
	}
	if a[center] > a[high] {
		a.swapAt(center, high)
	}
	return center
}
```
We use this medianOfThree before start partitioning in our quick sort.
```swift
public func quickSortMedian<T: Comparable>(_ a: inout [T], low: Int, high: Int)
{
	if low < high {
		let pivotIndex = medianOfThree(&a, low: low, high: high)
		a.swapAt(pivotIndex, high)
		let pivot = partitionLomuto(&a, low: low, high: high)
		quicksortLomuto(&a, low: low, high: pivot - 1)
		quicksortLomuto(&a, low: pivot + 1, high: high)
	} 
}
```
### Dutch national flag partitioning
In order to deal with **duplicates** in arrays we use a method that calls Dutch national flag. Just like the flag the result partitioning has 3 parts the middle parts contains the pivot and all its duplications
![[quicksort-dutchflag-1.jpg]]
![[quicksort-dutchflag-2.jpg]]
#### Code
```swift
public func partitionDutchFlag<T: Comparable>(_ a: inout [T],low: Int, high: Int, pivotIndex: Int)
-> (Int, Int) {
	let pivot = a[pivotIndex]
	var smaller = low 
	var equal = low 
	var larger = high 
  
	while equal <= larger { 
		if a[equal] < pivot {
			a.swapAt(smaller, equal)
			smaller += 1
			equal += 1
		} else if a[equal] == pivot {
			equal += 1
		} else {
			a.swapAt(equal, larger)
			larger -= 1 
		}
	}
	return (smaller, larger) // 5
}

public func quicksortDutchFlag<T: Comparable>(_ a: inout [T], Int) {
	if low < high {
		let (middleFirst, middleLast) =
      partitionDutchFlag(&a, low: low, high: high, pivotIndex:
high)
		quicksortDutchFlag(&a, low: low, high: middleFirst - 1)
		quicksortDutchFlag(&a, low: middleLast + 1, high: high)
	}
}
```