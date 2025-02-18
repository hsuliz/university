//
// Created by Oleksandr Suliz on 13/11/2021.
//

#include <ctime>
#include <cstdlib>
#include "Fun.h"

void swap(int &x, int &y) {
    int temp = x;
    x = y;
    y = temp;
}

int getRandomNumber(int min, int max) {
    static const double fraction = 1.0 / (static_cast<double>(RAND_MAX) + 1.0);
    return static_cast<int>(rand() * fraction * (max - min + 1) + min);
}