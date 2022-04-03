#include "graph.h"
#include <iostream>
#include <fstream>

void Graf::createVertices(int ile) {
    this->numberOfVertices = ile;
    array_generator(ile);

}

void Graf::addEdge(int i_Vertex_Index_1, int i_Vertex_Index_2) {
    this->matrix[i_Vertex_Index_1][i_Vertex_Index_2] = 1;
    this->matrix[i_Vertex_Index_2][i_Vertex_Index_1] = 1;
    this->number_of_edges++;
}

void Graf::removeEdge(int i_Vertex_Index_1, int i_Vertex_Index_2) {
    this->matrix[i_Vertex_Index_1][i_Vertex_Index_2] = 0;
    this->matrix[i_Vertex_Index_2][i_Vertex_Index_1] = 0;
    this->number_of_edges--;
}

bool Graf::checkEdge(int i_Vertex_Index_1, int i_Vertex_Index_2) {
    int x = this->matrix[i_Vertex_Index_1][i_Vertex_Index_2];
    int y = this->matrix[i_Vertex_Index_2][i_Vertex_Index_1];
    if (x == 1 && y == 1) {
        return true;
    } else {
        return false;
    }
}

int Graf::vertexDegree(int idx) {
    int k = 0;
    for (int i = 0; i < numberOfVertices; ++i) {
        if (checkEdge(idx, i)) {
            k++;
        }
    }
    return k;
}

int Graf::getNumberOfEdges() {
    return number_of_edges;
}

void Graf::array_generator(int ile) {
    this->matrix = new int *[ile];
    for (int i = 0; i < ile; i++) {
        matrix[i] = new int[ile];
    }
}

// what's elements connected to idx
std::vector<int> Graf::getNeighbourIndices(int idx) {
    std::vector<int> out;
    for (int i = 0; i < numberOfVertices; ++i) {
        if (checkEdge(idx, i)) {
            out.push_back(i);
        }
    }
    return out;
}

void Graf::printNeighbourIndices(int idx) {
    std::vector<int> out = getNeighbourIndices(idx);
    for (int i: out) {
        std::cout << i << " ";
    }
    std::cout << std::endl;
}

void Graf::readFromFile(std::string path) {
    // number of verticals
    // x y
    // ....
    int input_number;
    std::ifstream input_file(path);

    if (!input_file.is_open()) {
        input_file.close();
        throw std::domain_error("Wrong file name!!");
    }

    int i = -1;
    int *arr;

    while (input_file >> input_number) {
        if (i == -1) {
            arr = new int[input_number];
            createVertices(input_number);
        } else {
            arr[i] = input_number;
        }
        ++i;
    }

    for (int j = 0; j < i; j += 2) {
        addEdge(arr[j], arr[j + 1]);
    }

    input_file.close();
}




