Producing the minimum spanning tree
* Spanning tree is a subgraph of the actual graph which It's possible to reach any vertex
* Minimum spanning tree: is spanning tree that you can reach to any vertex with the minimum cost.
## Example
Assume the below graph
![[prime-graph.jpg]]
**First Step**
We will consider a vertex and its edges as a starting point (2)
Find the minimum weight edge
**Second Step**
Consider the  minimum weight edge destination + starter vertex
Find the minimum weight edge
...
Repeat until you meet all the vertices of graph
![[prime-steps.jpg]]
minimum spanning tree:
![[prime-result.jpg]]
* For finding the minimum weight edge we can use priority queue
* On each iteration we make sure to don't reconsider an edge which points to a vertex that already we've considered
## Implementation
Before the prime algorithm implementation we need to have the ability of copying a graph vertices (the minimum spanning tree is a copy of the original graph) 
```swift
extension AdjacencyList {
	public func copyVertices(from graph: AdjacencyList) {
		for vertex in graph.vertices {
			adjacencies[vertex] = []
		}
	}
}
```
And here is the prim implementation
```swift
class Prime<T> where T: Hashable, T:Comparable {
    typealias Graph = AdjacencyList<T>
    
    init() {}
    
    func addAvailableEdges(
        for vertex: Vertex<T>,
        in graph: Graph,
        visited: Set<Vertex<T>>,
        to priorityQueue: inout PriorityQueue<Edge<T>>
    ) {
        for edge in graph.edges(from: vertex) {
            if !visited.contains(edge.destination) {
                priorityQueue.enqueue(edge)
            }
        }
    }
    
    func produceMinimumSpanningTree(for graph: Graph) -> (cost: Double, mst: Graph) {
        let mst = Graph()
        var cost = 0.0
        var visited: Set<Vertex<T>> = []
        var priorityQueue = PriorityQueue<Edge<T>>(elements: [], sort: {$0.weight ?? 0 < $1.weight ?? 0})
        
        mst.copyVertices(from: graph)
        
        guard let start = graph.adjacencies.keys.first else {
            return (cost: cost, mst: mst)
        }
        
        visited.insert(start)
        
        addAvailableEdges(
            for: start,
            in: graph,
            visited: visited,
            to: &priorityQueue
        )
        
        while let smallestEdge = priorityQueue.dequeue() {
            let vertex = smallestEdge.destination
            
            guard !visited.contains(vertex) else {
                continue
            }
            
            visited.insert(vertex)
            cost += smallestEdge.weight ?? 0.0
            mst.addUndirectedEdge(from: smallestEdge.source, to: smallestEdge.destination, weight: smallestEdge.weight)
            
            addAvailableEdges(for: vertex, in: graph, visited: visited, to: &priorityQueue)
        }
        
        return (cost, mst)
    }
}
```