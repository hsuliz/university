#include <iostream>
#include <cstdlib>
#include "List.h"
#include "ArrayList.h"
#include "Fun.h"

int main() {
    //rand set up
    srand(static_cast<unsigned int>(time(0))); // в качестве стартового числа используем системные часы
    rand();

    ////test
    ArrayList test;
    //insert
    std::cout << "\n=== INSERT ===\n";
    for (int i = 0; i < 10; ++i) {
        test.insert(i, i + 1);
    }
    test.insert(2, 8);
    test.print();
    test.memStatus();

    //remove
    std::cout << "\n=== REMOVE ===\n";
    test.remove(9);
    test.remove(0);
    test.print();
    test.memStatus();

    //retrive
    std::cout << "\n=== RETRIVE ===\n";
    std::cout << "Finding 6 index..." << std::endl;
    std::cout << test.retrieve(6) << std::endl;
    std::cout << "Finding 23(out of bound) index..." << std::endl;
    std::cout << test.retrieve(23) << std::endl;

    //locate
    int testData = test.retrieve(4);
    std::cout << "\n=== LOCATE ===\n";
    std::cout << "Finding number " << testData << "..." << std::endl;
    std::cout << test.locate(testData) << std::endl;
    std::cout << "Finding 23(out of search) element..." << std::endl;
    std::cout << test.locate(23) << std::endl;

    //end
    std::cout << "\n=== END ===\n";
    std::cout << test.end() << std::endl;

    //first
    std::cout << "\n=== FIRST ===\n";
    std::cout << test.first() << std::endl;

    //next
    std::cout << "\n=== NEXT ===\n";
    std::cout << "Element number 2\n";
    std::cout << test.next(2) << std::endl;

    //prev
    std::cout << "\n=== PREVIOUS ===\n";
    std::cout << "Element number 2\n";
    std::cout << test.previous(2) << std::endl;

    //last
    std::cout << "\n=== LAST ===\n";
    std::cout << test.last() << std::endl;

    //last
    std::cout << "\n=== BACK ===\n";
    std::cout << test.back() << std::endl;

    //push front
    std::cout << "\n=== PUSH_FRONT ===\n";
    test.push_front(25);
    test.print();
    test.memStatus();

    //push back
    std::cout << "\n=== PUSH_BACK ===\n";
    test.push_back(-25);
    test.print();
    test.memStatus();

    //pop front
    std::cout << "\n=== POP FRONT ===\n";
    test.pop_front();
    test.print();
    test.memStatus();

    //pop front
    std::cout << "\n=== POP BACK ===\n";
    test.pop_back();
    test.print();
    test.memStatus();


    //Usuwanie wszystkich wystąpień elementu w liście
    std::cout << "\n=== ELEMENT DESTR ===\n";
    test.print();
    test.elementDestr(8);
    test.print();
    test.memStatus();

    //Odwracanie listy
    std::cout << "\n=== ARR REVERSE ===\n";
    test.print();
    test.reverseArray();
    test.print();
    test.memStatus();


    return 0;
}
