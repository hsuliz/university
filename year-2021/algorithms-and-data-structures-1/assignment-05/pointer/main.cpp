#include <iostream>
#include "PointerBasedQueue.hpp"

void separaTor() {
    for (int i = 0; i < 14; ++i) {
        std::cout << "=";
    }
    std::cout << std::endl;
}

int main() {
    //test for char
    PointerBasedQueue<char> test;
    test.printIsEmpty();
    test.printSize();
    separaTor();
    // enqueue
    std::cout << "Enqueue: \n";
    for (int i = 0; i < 5; ++i) {
        test.enqueue((char) (i + 97));
    }
    test.printAll();
    test.printSize();
    separaTor();
    // dequeue
    std::cout << "Dequeue 2 times: \n";
    test.dequeue();
    test.dequeue();
    test.printAll();
    test.printSize();
    separaTor();
    // getR and getF
    std::cout << "getFront and getRear: \n";
    test.printAll();
    test.printFront();
    test.printRear();



    return 0;
}
