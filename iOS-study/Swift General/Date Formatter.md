Foundation have two new api for formatting date to string
## `.formatted`
you can have a nice combination of date and time together with it. below example has a complete date without any time information
```Swift
Date().formatted(date: .completed, time: .omitted)
// Tuesday, July 12, 2022
```

## `.formatted(.dateTime)`
with this one you can use a nice chain pattern to build your more advance customized date string.

```Swift
	Date().formatted(
	.dateTime
	.year(.twoDigits)
	.month(.wide)
	)
	//22, July
```