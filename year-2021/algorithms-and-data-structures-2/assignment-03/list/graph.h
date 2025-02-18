#pragma once

#include <iostream>
#include <vector>
#include <fstream>
#include <string>
#include <sstream>


class Graf {
    std::vector<std::vector<int>> vertexList;
    int number_of_edges;
public:
    Graf() = default;

    void createVertices(int ile);

    void addEdge(int x, int y);

    bool removeEdge(int x, int y);

    bool checkEdge(int x, int y);

    int vertexDegree(int idx);

    std::vector<int> getNeighbourIndices(int idx);

    void printNeighbourIndices(int idx);

    int getNumberOfEdges();

    void readFromFile(std::string path);
};

