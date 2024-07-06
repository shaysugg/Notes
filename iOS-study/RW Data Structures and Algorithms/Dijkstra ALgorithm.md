[Explanation Video](https://youtu.be/GazC3A4OQTE)
* Is used for finding the **cheapest** **cost** and **path** from one vertex to another.
* You need to form a table in order to have some implications of how it works.
* You need to use a priority queue to implement it
![[dijkstra-table-graph.jpg]]
**First row of table**
Assume A is our start point. the first row of the table is going to be

|     | B   | C   | D   | E   | F   | G       | H   |
| --- | --- | --- | --- | --- | --- | ------- | --- |
| A   | 8-A | -   | -   | -   | 9-A | ==1-A== | -   |
These are the paths that is possible to take from A to other vertices. 
For example 8-A on B column means we can go from A to B
* With 8 cost
* The path is going through A
The cheapest path is G. we check G for the second row.

**Second row of table**

|     | B   | C       | D   | E   | F   | G       | H   |
| --- | --- | ------- | --- | --- | --- | ------- | --- |
| A   | 8-A | -       | -   | -   | 9-A | ==1-A== | -   |
| G   | 8-A | ==3-G== | -   | -   | 9-A | ==1-A== | -   |
The top table shows how we can go from A to other vertices by considering it's possible to pass through G
By considering G it became possible to go to C also. Others remain the same G has one neighbor and we can't find a shorter path to other vertices
For the next row we're going to consider C as it was the vertex with the cheapest cost to reach.

**The complete table**
The explained approach will be taken until we find a path to the all the vertices.
![[dijkstra-table.jpg]]In the final table we highlight for example the shortest path from **A** to **D**.
The cost is going to be **7** (last row, D column) and the path is going to be through **A -> G -> C -> D -> F**