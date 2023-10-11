#include <iostream>
#include "set_list.h"

int main() {

    set_list data;
    // size
    std::cout << "getSize..\n";
    std::cout << data.getSize() << std::endl;

    // insert
    std::cout << "insert 2 and 5..\n";
    data.insert(2);
    data.insert(5);

    //printset
    data.printSet();

    //delete
    std::cout << "withdraw 5..\n";
    data.withdraw(5);
    data.printSet();

    //mull
    std::cout << "operator*..\n";
    set_list test_mull, data_mull;
    test_mull.insert(2);
    data_mull.insert(2);
    test_mull.insert(7);
    set_list mul = test_mull.operator*(data_mull);
    mul.printSet();

    //min
    std::cout << "operator-..\n";
    set_list test_min, data_min;
    test_min.insert(1);
    data_min.insert(5);
    set_list min = test_min.operator-(data_min);
    min.printSet();

    //equal
    std::cout << "operator==..\n";
    set_list test_eq, data_eq;
    test_eq.insert(2);
    test_eq.insert(3);
    data_eq.insert(2);
    data_eq.insert(3);
    bool eq = test_eq.operator==(data_eq);
    std::cout << eq << std::endl;

    // include
    std::cout << "operator<=..\n";
    set_list test_inc, data_inc;
    test_inc.insert(2);
    test_inc.insert(3);
    test_inc.insert(5);
    data_inc.insert(2);
    data_inc.insert(3);
    //data_inc.insert(5);
    bool inc = test_inc.operator<=(data_inc);
    std::cout << inc;


    return 0;
}
