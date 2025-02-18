#ifndef EX2_ARRAYLIST_H
#define EX2_ARRAYLIST_H

#include "List.h"

const int MAX_ARRAY_SIZE = 256;

class ArrayList : public List {
private:
    int arraySize;
    int elementsIn;
    int *data;

    void arrayNewMem();

public:

    ArrayList();

    ~ArrayList();

    bool insert(int index, const int &element) override;

    bool remove(int index) override;

    int retrieve(int index) override;

    int locate(const int &element) override;

    int end() override;

    int first() override;

    int next(int index) override;

    int previous(int index) override;

    int last() override;

    int back() override;

    bool push_front(const int &element) override;

    bool push_back(const int &element) override;

    void pop_front() override;

    void pop_back() override;

    void print();

    void reverseArray();

    ////utility
    int getArraySize() const;

    int getElementsIn() const;

    void memStatus();

    void elementDestr(int element);

    void destroy();

    void dupDesrt();
};


#endif //EX2_ARRAYLIST_H
