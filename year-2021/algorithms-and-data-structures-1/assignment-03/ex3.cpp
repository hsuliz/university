#include <iostream>
#include "LinkedList.hpp"
#include <string>

using namespace std;

int main() {
    //// INT EXAMPLE
    List<int> test;

    /// push back
    cout << "Push back" << endl;
    for (int i = 1; i <= 6; ++i) {
        test.push_back(i);
    }
    test.printAll();
    /// remove
    cout << "Remove 3" << endl;
    test.remove(3);
    test.printAll();
    /// pop front
    cout << "Pop front" << endl;
    test.pop_front();
    test.printAll();
    /// pop back
    cout << "Pop back" << endl;
    test.pop_back();
    test.printAll();
    /// push front
    cout << "Push front" << endl;
    test.push_front(10);
    test.printAll();
    /// len
    cout << "Len" << endl;
    cout << "Size is: " << test.len() << endl;
    test.printAll();
    /// back
    cout << "Back" << endl;
    cout << test.back() << endl;
    test.printAll();
    /// first
    cout << "First" << endl;
    cout << test.first() << endl;
    test.printAll();
    /// last
    cout << "Last" << endl;
    cout << test.last() << endl;
    test.printAll();
    /// front
    cout << "Front" << endl;
    cout << test.front() << endl;
    test.printAll();
    /// empty
    cout << "Empty" << endl;
    if (test.empty()) {
        cout << "Is empty" << endl;
    } else {
        cout << "Not empty" << endl;
    }
    test.printAll();
    /// locate
    cout << "Locate 2" << endl;
    cout << test.locate(2) << endl;
    /// retrieve
    cout << "Retrive 2" << endl;
    cout << test.retrieve(2) << endl;
    test.printAll();
    /// insert
    cout << "Insert -25 on 5" << endl;
    test.insert(5, -25);
    test.printAll();
    /// reverse list
    test.reverseList();
    test.printAll();

    return 0;

}
