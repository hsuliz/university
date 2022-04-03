#pragma once

#include <array>


class Queue {
    int *data_store;
    int iterator;
    int deep;
public:
    void insert(int x);

    void RemoveRootElem();

    void print_like_matrix();

    int getRootElem();

    // UTILITY //

    Queue(int max_size);

    ~Queue();

    void print_deep() const;

private:

    void sort();

};