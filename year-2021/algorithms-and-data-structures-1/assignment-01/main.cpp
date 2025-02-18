#include <iostream>
#include "insertSort.h"

int main() {

    int myData[] = {10, 9, 8, 7, 6, 5, 4, 3, 2, 1};
    //int myData[] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10};
    int size = 10;


    std::cout << "Before sort: \n";
    print(myData, size);

    std::cout << "After sort: \n";
    insertSort(myData, size);
    print(myData, size);


    return 0;
}
