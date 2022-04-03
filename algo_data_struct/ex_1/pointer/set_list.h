#pragma once

#include <iostream>
#include <vector>

class set_list {
    std::vector<int> vec;

public:

    set_list() {

    }

    set_list(std::vector<int> vector);

    int getSize();

    void printSet();

    void insert(int x);

    void withdraw(int x);

    bool isInSet(int x);

    set_list operator+(set_list &obj);

    set_list operator*(set_list &obj);

    set_list operator-(set_list &obj);

    bool operator==(set_list &obj);

    bool operator<=(set_list &obj);


};


