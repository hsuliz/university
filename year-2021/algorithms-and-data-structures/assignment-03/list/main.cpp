#include <iostream>
#include "graph.h"

int main() {
    Graf *g = new Graf();
    g->createVertices(5);
    g->addEdge(1, 2);
    g->addEdge(3, 4);
    g->addEdge(3, 2);

    std::cout << g->getNumberOfEdges();

    return 0;
}
