All of these algorithms have time complexity of O(n^2). They're not commonly used in real-world sorting, but understanding how the work can be useful for understand array problems and inspire solution for them.
## Bubble Sort
[Article](https://www.geeksforgeeks.org/bubble-sort/?ref=shm)
* Two pointers
* First loop i traverse from end to beginning (right to left)
* Second loop j travers from beginning to i (left to right)
* On second loop if an element is bigger than its next element, the two will be swapped
* On each second loop iteration the largest ==number will be placed at the end of the array.== *(the inner loop act as finding a maximum in the array)*
* If you perform a second loop and you didn't swap anything then the sorting is finished and you can exit.
```swift
public func bubbleSort<Element>(_ array: inout [Element])
    where Element: Comparable {
	guard array.count >= 2 else {
		return
	}
	for end in (1..<array.count).reversed() {
		var swapped = false
		for current in 0..<end {
			if array[current] > array[current + 1] {
			    array.swapAt(current, current + 1)
				swapped = true
			}
		}
		
		if !swapped {
			return
		}
	}
}
```

## Selection Sort
[Article](https://www.geeksforgeeks.org/selection-sort/?ref=shm)
 * Two pointers
* First loop i traverse from beginning to end (left to right)
* Second loop j travers from i next element to end (left to right)
* On second loop you find the minimum value and store it in a value that is in first loop
* In first loop If a minimum value smaller than current element has been found you will swap the current and the minimum value (This one improves algorithm by avoiding ==unnecessary swaps==)
* ==On each second loop iteration the smallest number will be on left side==
```swift
public func selectionSort<Element>(_ array: inout [Element])
    where Element: Comparable {
	guard array.count >= 2 else {
		return
	}

	for current in 0..<(array.count - 1) {
		var lowest = current
		for other in (current + 1)..<array.count {
			if array[lowest] > array[other] {
				lowest = other
			}
		}
		if lowest != current {
			array.swapAt(lowest, current)
		}
	}
}
```
## Insertion Sort
![[sort-insetion.png]]
 * Two pointers
* First loop i starts at second element and goes to the end (left to right)
* Second loop j starts at i and goes backwards to the 0 (right to left)
* On the second loop the main purpose is shift the current item in first loop as left as we can. Shifting is based on current item is smaller than its previous item. if so swap the two.
* On each second loop iteration all of the item before first loop element is sorted.
```swift
public func insertionSort<Element>(_ array: inout [Element])
    where Element: Comparable {
	guard array.count >= 2 else {
		return
	}
	for current in 1..<array.count {
		for shifting in (1...current).reversed() {
			if array[shifting] < array[shifting - 1] {
				array.swapAt(shifting, shifting - 1)
			} else {
				break
			}
		}
	}
}
```
the main advantage of this algorithm is it's early break. you're more easily get out of second loop. As an example If the array is already sorted the time complexity is O(n) because the inner loop hit the break on the first check.