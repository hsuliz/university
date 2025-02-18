#include <iostream>
#include "PointerStack.hpp"
using namespace std;
int main() {
    PointerStack<int> tInt(5);
    /// PUSH
    cout << "Pushed.." << endl;
    for (int i = 0; i < 5; ++i) {
        tInt.push(i+1);
    }
    tInt.printAll();
    /// POP
    cout << "Poped.." << endl;
    tInt.pop();
    tInt.printAll();
    /// PEEK
    cout << "Peeked.." << endl;
    cout << tInt.peek() << endl;
    tInt.printAll();
    /// isEMPTY
    cout << "isEmpty..." << endl;
    tInt.printIsEmpty();
    tInt.printAll();
    /// size
    cout << "Size is:" << endl;
    cout << tInt.size() << endl;
    tInt.printAll();
    /// isFULL
    cout << "isFull..." << endl;
    tInt.printIsFull();
    tInt.printAll();
    return 0;
}
