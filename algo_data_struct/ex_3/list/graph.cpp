#include "graph.h"

void Graf::createVertices(int ile) {
    vertexList.reserve(ile);
    number_of_edges = ile;
}

void Graf::addEdge(int x, int y) {
    vertexList[x].push_back(y);
    vertexList[y].push_back(x);
}

bool Graf::removeEdge(int x, int y) {
    std::vector<int> tmp = vertexList[x];
    for (int i = 0; i < tmp.size(); ++i) {
        if (tmp.at(i) == y) {
            vertexList[x].erase(vertexList[x].begin() + i);
            return true;
        }
    }
    return false;
}

bool Graf::checkEdge(int x, int y) {
    std::vector<int> tmp = vertexList[x];
    for (int i: tmp) {
        if (i == y || i == x) {
            return true;
        }
    }
    return false;
}

int Graf::vertexDegree(int idx) {
    return vertexList[idx].size();
}

std::vector<int> Graf::getNeighbourIndices(int idx) {
    std::sort(vertexList[idx].begin(), vertexList[idx].end());
    return vertexList[idx];
}

void Graf::printNeighbourIndices(int idx) {
    std::vector<int> out = getNeighbourIndices(idx);
    for (int i: out) {
        std::cout << i << " ";
    }
    std::cout << std::endl;

}

int Graf::getNumberOfEdges() {
    return number_of_edges;
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

