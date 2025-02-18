//
// Created by Oleksandr Suliz on 22/10/2021.
//

#include <iostream>

// oszacować złożoność pesymistyczną
int pessimisticFun(int n) {
    return n * (n - 1) / 2;
}

// miarę wrażliwości pesymistycznej
int sensPessimisticFun(int n) {
    return ((2 + n) * (n - 1) / 2);
}

void print(int *arr, int size) {
    for (int i = 0; i < size; ++i) {
        std::cout << arr[i] << " ";
    }
    std::cout << std::endl;
}

void insertSort(int *arr, int size) {
    int baseCounter(0);
    int counterWhileDominate(0), counterDominate(0);
    int base(0), j(0);
    for (int i = 1; i < size; ++i) {
        j = i - 1;
        base = arr[i];
        // dodać instrukcję zliczającą operacje dominujące
        counterDominate++;
        while (j >= 0 && arr[j] > base) {
            arr[j + 1] = arr[j];
            j--;
            // dodać instrukcję zliczającą operacje dominujące
            counterWhileDominate++;
        }
        arr[j + 1] = base;
    }

    (counterWhileDominate >= counterDominate) ? baseCounter = counterWhileDominate : baseCounter = counterDominate;

    // operacje dominujące
    std::cout << "My dominate counter is: " << baseCounter << std::endl;
    // złożoność pesymistyczną
    std::cout << "My pessimistic is: " << pessimisticFun(size) << std::endl;
    // miarę wrażliwości pesymistycznej
    std::cout << "My sensitivity is: " << sensPessimisticFun(size) << std::endl;
}

