#include <iostream>
#include "queue.h"
#include <cmath>


Queue::Queue(int max_size) {
    data_store = new int[max_size];
    iterator = 0;
    deep = (int) log(max_size) + 1;
    std::cout << "Constructor:\n";
    std::cout << "Created array with " << max_size << " size\n";
    std::cout << "Deep of tree is " << deep << std::endl;
}

Queue::~Queue() {
    delete[] data_store;
}

void Queue::insert(int x) {
    data_store[iterator] = x;
    iterator++;
    sort();
}

// print like matrix
void Queue::print_like_matrix() {
    std::cout << "Print:\n";
    int count = 0;
    for (int i = 0; i < deep + 1; ++i) {
        for (int j = 0; j < pow(2, i); ++j) {
            std::cout << data_store[count] << " ";
            count++;
        }
        std::cout << std::endl;
    }
}

void Queue::RemoveRootElem() {
    int *tmp = new int[iterator - 1];

    for (int i = 0; i < iterator - 1; ++i) {
        tmp[i] = data_store[i + 1];
    }
    data_store = tmp;
}

int Queue::getRootElem() {
    return data_store[0];
}

// UTILITY //

void Queue::print_deep() const {
    std::cout << deep << std::endl;
}

void Queue::sort() {
    int tmp;
    for (int i = 0; i < iterator; ++i) {
        for (int j = i + 1; j < iterator; ++j) {
            if (data_store[i] > data_store[j]) {
                tmp = data_store[i];
                data_store[i] = data_store[j];
                data_store[j] = tmp;
            }
        }
    }
}
