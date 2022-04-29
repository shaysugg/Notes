# About Futures
`EventLoopFuture<T>` is a future type from SwiftNIO that we can wrap our async function results in it and return them.

## Map, FlatMap
Both executes on a future and returns another future. **FlatMap** returns **the same type** of `EventLoopFuture`, **map** returns **another type** of `EventLoopFuture`

## Transform
looks like map but use when we don't want do any mapping on result we just want to change the result completely if its was successful.
