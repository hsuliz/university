#pragma once

#include <iostream>
#include <vector>
#include <fstream>
#include <string>
#include <sstream>
#include "edge.h"


class Graf {

    int **matrix;
    int numberOfVertices{};
    int number_of_edges;

public:

    Graf() = default;



    // how many nodes
    void createVertices(int ile);

    void addEdge(int i_Vertex_Index_1, int i_Vertex_Index_2);

    void removeEdge(int i_Vertex_Index_1, int i_Vertex_Index_2);

    bool checkEdge(int i_Vertex_Index_1, int i_Vertex_Index_2);

    int vertexDegree(int idx);

    // #TODO have no idea
    std::vector<int> getNeighbourIndices(int idx);

    void printNeighbourIndices(int idx);

    int getNumberOfEdges();

    void readFromFile(std::string path);

private:
    // type of de-constructor I guess
    void clear();

    void array_generator(int number);
};

