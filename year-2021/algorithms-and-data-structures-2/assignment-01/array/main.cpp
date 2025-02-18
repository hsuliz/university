#include <iostream>
#include "set_arr.h"

int main() {

    std::cout << "Creating 2 arrays\n";
    set_arr test(3, 7);
    set_arr data(1, 10);

    std::cout << "Printing..\n";
    test.printSet();
    data.printSet();

    std::cout << "Insert in test..\n";
    test.insert(3);
    test.insert(6);
    test.insert(7);

    std::cout << "Insert in data..\n";
    data.insert(3);
    data.insert(6);
    data.insert(9);

    std::cout << "Printing..\n";
    test.printSet();
    data.printSet();

    std::cout << "Withdraw 9 from data..\n";
    data.withdraw(9);

    std::cout << "Printing..\n";
    data.printSet();

    std::cout << "isInSet 3 in data..\n";
    (data.isInSet(3)) ? std::cout << "True" : std::cout << "False";
    std::cout << std::endl;

    std::cout << "Get size from test..\n";
    std::cout << "Size is " << test.getSize() << std::endl;

    std::cout << "Clear data set..\n";
    data.clearSet();

    std::cout << "Printing..\n";
    data.printSet();

    data.insert(2);
    data.insert(5);
    data.insert(6);

    std::cout << "operator +..\n";
    set_arr tmp = data.operator+(test);
    tmp.printSet();

    tmp.clearSet();

    std::cout << "operator -..\n";
    test.insert(7);
    tmp.printSet();
    set_arr tmpMin = test.operator-(data);
    tmpMin.printSet();

    std::cout << "operator*..\n";
    set_arr tmpMul = data.operator*(test);
    tmpMul.printSet();

    std::cout << "operator==..\n";
    (test.operator==(data)) ? std::cout << "true" : std::cout << "false";
    std::cout << std::endl;

    std::cout << "operator<=..\n";
    (test.operator<=(data)) ? std::cout << "true" : std::cout << "false";
    std::cout << std::endl;

    return 0;
}
