#include <iostream>
#include "ArrayBasedQueue.hpp"

void separaTor() {
    for (int i = 0; i < 14; ++i) {
        std::cout << "=";
    }
    std::cout << std::endl;
}

int main() {
    
    // test for int
    ArrayBasedQueue<int> test(3, 7);
    test.printIsEmpty();
    test.printSize();
    // pull
    separaTor();
    std::cout << "Enqueue:" << std::endl;
    for (int i = 3; i < 7; ++i) {
        test.enqueue(i + 1);
    }
    test.printAll();
    separaTor();
    // getFront and getRear
    std::cout << "getFront and getRear:" << std::endl;
    std::cout << "\tgetFront is: " << test.getFront() << std::endl;
    std::cout << "\tgetRear is: " << test.getRear() << std::endl;
    test.printIsEmpty();
    test.printIsFull();
    separaTor();
    // dequine
    std::cout << "Dequeue 2 times:" << std::endl;
    for (int i = 1; i < 3; ++i) {
        test.dequeue();
    }
    test.printAll();
    test.printIsEmpty();
    test.printIsFull();
    //
    std::cout << "Size:" << std::endl;
    test.printTrueSize();

    return 0;
}


