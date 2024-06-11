```c
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Graph node structure
typedef struct GraphNode {
    char* value;
    struct GraphNode** adjacentNodes;
    int numAdjacentNodes;
} GraphNode;

// Graph structure
typedef struct Graph {
    int numVertices;
    GraphNode** nodes;
} Graph;

// Function to create a new graph node
GraphNode* createGraphNode(char* value) {
    GraphNode* node = (GraphNode*)malloc(sizeof(GraphNode));
    node->value = malloc(strlen(value) + 1);
    strcpy(node->value, value);
    node->adjacentNodes = NULL;
    node->numAdjacentNodes = 0;
    return node;
}

// Function to create a new graph
Graph* createGraph(int numVertices) {
    Graph* graph = (Graph*)malloc(sizeof(Graph));
    graph->numVertices = numVertices;
    graph->nodes = (GraphNode**)calloc(numVertices, sizeof(GraphNode*));
    return graph;
}

// Function to add an edge to the graph
void addEdge(Graph* graph, int src, GraphNode* dest) {
    graph->nodes[src]->adjacentNodes = (GraphNode**)realloc(graph->nodes[src]->adjacentNodes, (graph->nodes[src]->numAdjacentNodes + 1) * sizeof(GraphNode*));
    graph->nodes[src]->adjacentNodes[graph->nodes[src]->numAdjacentNodes] = dest;
    graph->nodes[src]->numAdjacentNodes++;
}

// Function to print the graph
void printGraph(Graph* graph) {
    for (int i = 0; i < graph->numVertices; i++) {
        printf("Node %d (%s) has %d adjacent nodes:\n", i, graph->nodes[i]->value, graph->nodes[i]->numAdjacentNodes);
        for (int j = 0; j < graph->nodes[i]->numAdjacentNodes; j++) {
            printf("-> %s\n", graph->nodes[i]->adjacentNodes[j]->value);
        }
        printf("\n");
    }
}

int main() {
    Graph* graph = createGraph(5);

    graph->nodes[0] = createGraphNode("A");
    graph->nodes[1] = createGraphNode("B");
    graph->nodes[2] = createGraphNode("C");
    graph->nodes[3] = createGraphNode("D");
    graph->nodes[4] = createGraphNode("E");

    addEdge(graph, 0, graph->nodes[1]);
    addEdge(graph, 0, graph->nodes[4]);
    addEdge(graph, 1, graph->nodes[2]);
    addEdge(graph, 1, graph->nodes[3]);
    addEdge(graph, 1, graph->nodes[4]);
    addEdge(graph, 2, graph->nodes[3]);
    addEdge(graph, 3, graph->nodes[4]);

    printGraph(graph);

    return 0;
}

```