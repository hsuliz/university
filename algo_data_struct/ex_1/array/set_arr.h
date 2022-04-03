#pragma once

#include <iostream>

class set_arr {
    int size;
    const int universeSize = 100;
    bool *table;
    int min, max;

    bool checkRangeCorrectness(int x);

public:

    set_arr(int min, int max);

    void insert(int x);

    void withdraw(int x);

    bool isInSet(int i);

    int getSize();

    void clearSet();

    void printSet();

    set_arr operator+(set_arr &object);

    set_arr operator*(set_arr &object);

    set_arr operator-(set_arr &object);

    bool operator==(set_arr &object);

    bool operator<=(set_arr &object);
};

