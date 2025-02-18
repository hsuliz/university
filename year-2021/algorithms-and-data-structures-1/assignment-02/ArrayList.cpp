#include <iostream>
#include "ArrayList.h"
#include "Fun.h"

//ok
ArrayList::ArrayList() {
    arraySize = 4;
    elementsIn = 0;
    data = new int[arraySize];
}

//ok
ArrayList::~ArrayList() {
    delete[]data;
};

//ok
bool ArrayList::insert(int index, const int &element) {
    if (index > MAX_ARRAY_SIZE && index < 0) {
        return false;
    }
    while (index >= arraySize) {
        arrayNewMem();
    }
    if (elementsIn <= index) {
        elementsIn = index + 1;
    }
    data[index] = element;
    return true;
}

//ok
bool ArrayList::remove(int index) {
    if (index > MAX_ARRAY_SIZE || index < 0) {
        return false;
    }
    for (int i = index; i <= elementsIn + 1; ++i) {
        data[i] = data[i + 1];
    }
    elementsIn--;
}

//ok
int ArrayList::retrieve(int index) {
    if (index > elementsIn || index <= 0) {
        return -1;
    }
    return data[index - 1];
}

//ok
int ArrayList::locate(const int &element) {
    for (int i = 0; i <= elementsIn; ++i) {
        if (element == data[i]) {
            return i + 1;
        }
    }
    return elementsIn + 1;
}

//ok
int ArrayList::end() {
    return elementsIn + 1;
}

//ok
int ArrayList::first() {
    return 0;
}

//ok
int ArrayList::next(int index) {
    return data[index + 1];
}

//ok
int ArrayList::previous(int index) {
    return data[index - 1];
}

//ok
int ArrayList::last() {
    return elementsIn;
}

//ok
int ArrayList::back() {
    return data[elementsIn - 1];
}

//ok
bool ArrayList::push_front(const int &element) {
    int *temp = new int[elementsIn + 1];
    temp[0] = element;
    for (int i = 0; i < elementsIn + 1; ++i) {
        temp[i + 1] = data[i];
    }
    delete[]data;
    data = temp;
    elementsIn++;
    return true;
}

//ok
bool ArrayList::push_back(const int &element) {
    int *temp = new int[elementsIn];
    temp[elementsIn] = element;
    for (int i = 0; i < elementsIn; ++i) {
        temp[i] = data[i];
    }
    delete[]data;
    data = temp;
    elementsIn++;
    return true;
}

//ok
void ArrayList::pop_front() {
    int *temp = new int[elementsIn - 1];
    for (int i = 1; i < elementsIn; ++i) {
        temp[i - 1] = data[i];
    }
    delete[]data;
    data = temp;
    elementsIn--;
}

//ok
void ArrayList::pop_back() {
    int *temp = new int[elementsIn - 1];
    for (int i = 0; i < elementsIn - 1; ++i) {
        temp[i] = data[i];
    }
    delete[]data;
    data = temp;
    elementsIn--;
}

//ok
void ArrayList::elementDestr(int element) {
    for (int i = 0; i <= elementsIn; ++i) {
        if (data[i] == element) {
            remove(i);
        }
    }
}

//idk
void ArrayList::reverseArray() {
    int n = elementsIn - 1;
    for (int low = 0, high = n; low <= high; low++, high--) {
        swap(data[low], data[high]);
    }

}

//// UTULITY STUFF

//utility
void ArrayList::print() {
    for (int i = 0; i < elementsIn; ++i) {
        std::cout << data[i] << ", ";
    }
    std::cout << "\n";
}

//new memory alloc
void ArrayList::arrayNewMem() {
    arraySize *= 2;
    int *temp = new int[arraySize];
    for (int i = 0; i < elementsIn; ++i) {

        temp[i] = data[i];
    }
    delete[]data;
    data = temp;
}

void ArrayList::memStatus() {
    std::cout << "MEMORY SIZE IS: " << arraySize << std::endl;
    std::cout << "ELEMENTS IN ARRAYS: " << elementsIn << std::endl;
}

int ArrayList::getArraySize() const {
    return arraySize;
}

int ArrayList::getElementsIn() const {
    return elementsIn;
}

