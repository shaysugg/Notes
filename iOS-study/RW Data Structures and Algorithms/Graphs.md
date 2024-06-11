Graphs are data structures consist of un-hierarchal nodes and it's possible to traverse from any node to another if their relation between them exists
* Graph nodes called vertices.
* Relations between nodes called edges
## Implementation
```swift
public struct Vertex<T> {
	public let index: Int
	public let data: T
} 

public struct Edge<T> {
	public let source: Vertex<T>
	public let destination: Vertex<T>
	public let weight: Double?
}
```
*graphs has various implementation. not all of the properties of edge and vertext in top example are mandatory, They're mostly depend on the graph implementation*
### Graph definition
Here is some mature graph requirements. The can be much simpler based on the use case we have.
```swift
protocol Graph {
    associatedtype Element
    func addVertex(data: Element) -> Vertex<Element>
    func addDirectedEdge(
        from source: Vertex<Element>,
        to destination: Vertex<Element>,
        weight: Double
    )
    func addUndirectedEdge(
        from source: Vertex<Element>,
        to destination: Vertex<Element>,
        weight: Double
    )
    func edges(from source: Vertex<Element>) -> [Edge<Element>]
    func weight(
        from source: Vertex<Element>,
        to destination: Vertex<Element>
    ) -> Double?
}
```
### Graph Implementations
Two implementations that have mentioned in books are
* AdjacencyList
* AdjacencyMatrix
#### Adjacency List
Adjacency List uses a dictionary which connects vertices to the array of their edges.
```swift
public class AdjacencyList<T: Hashable>: Graph {
    var adjacencies: [Vertex<T> : [Edge<T>]] = [:]
    //...
}

//in order to use vertex as keys
extension Vertex: Equatable where T: Equatable {}
extension Vertex: Hashable where T: Hashable {}
```
#### Adjacency Matrix
Adjacency Matrix uses a combination of array of vertices and a two demential array of weights between vertices
In the array of weights the **rows are source vertices and the columns are destination vertices**, therefore Edges can be inferred from them.
```swift
class AdjacencyMatrix<T>: Graph {
    var vertices = [Vertex<T>]()

    //rows = source
    //columns = destinations 
    var weights = [[Double?]]()
    
   //...
}
```
## Graph Implementations Analysis

| Operations                | Adjacency List | Adjacency Matrix |
| ------------------------- | -------------- | ---------------- |
| Storage Space             | O(V + E)       | O(V^2)           |
| Add Vertex                | O(1)           | O(V^2)           |
| Add Edge                  | O(1)           | O(1)             |
| Finding Edges and Weights | O(V)           | O(1)             |
