`EventLoopFuture<T>` is a future type from SwiftNIO that we can wrap our async function results in it and return them.

## Map, FlatMap
the difference is that if the callback that processes the `EventLoopFuture` result returns an `EventLoopFuture`, use` flatMap(_:).` If the callback returns a type other than `EventLoopFuture`, use `map(_:)`.
https://fattywaffles.medium.com/map-and-flatmap-in-vapor-a17f88af431c