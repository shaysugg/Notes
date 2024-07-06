It's a sort that probably only works with integers.
You start with the first digit and on each step (Iterations) elements with the sorted and grouped based one of their digits.
The process will be stopped when you check all of the digits of the biggest number. 

## Example
`101, 1432, 38, 523, 1000`

**First iteration**
first digits: `1, 2, 8, 3, 0`
buckets: `[[1000], [101], [1432], [523], [], [], [], [], [38], []]`
sorted: `[1000, 101, 1432, 523, 38]`

**Second iteration**
second digits (of previously sorted array):
`0, 0, 3, 2, 3`
buckets: `[[1000, 101], [], [523], [1432, 38], [], [], [], [], [], []]`
sorted: `[1000, 101, 523, 1432, 38]`

**Third iteration**
third digits (of previously sorted array):
`0, 1, 5, 4, 0`
buckets: `[[1000, 38], [101], [], [], [1432], [523], [], [], [], []]`
sorted: `[1000, 38, 101, 1432, 523]`

**Forth iteration**
forth digits (of previously sorted array):
`1, 0, 0, 1, 0`
buckets: `[[38, 101, 523], [100, 1432], [], [], [], [], [], [], [], []]`
sorted: `[38, 101, 523, 1000, 1432]`

## Implementation
```swift
func radixSort(_ elements: inout [Int]) {
	var digits = 1
	let base = 10
	var finished = false
	while !finished {
		finished = true
		var buckets: [[Int]] = Array(repeating: [], count: 10)
		elements.forEach { element in
			let remaining = element / digits
			let digit = remaining % base
			buckets[digit].append(element)
			if remaining > 0 {
				finished = false
			}
		}
		digits = digits * base
		elements = buckets.flatMap { $0 }
	}
}
```