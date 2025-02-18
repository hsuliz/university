#include <iostream>
#include "ArrayStack.hpp"

using namespace std;

int main() {

    ArrayStack<int> tInt(5);
    /// PUSH
    cout << "===\nPushed.." << endl;
    for (int i = 0; i < 5; ++i) {
        tInt.push(i+1);
    }
    tInt.printAll();
    /// POP
    cout << "===\nPoped.." << endl;
    tInt.pop();
    tInt.printAll();
    /// PEEK
    cout << "===\nPeek.." << endl;
    cout << tInt.peek() << endl;
    /// isEMPTY
    cout << "===\nIs empty.." << endl;
    cout << "My stack is:" << endl;
    tInt.printAll();
    tInt.printIsEmpty();
    for (int i = 0; i < 4; ++i) {
        tInt.pop();
    }
    tInt.printAll();
    /// SIZE
    cout << "===\nSize.." << endl;
    cout << "Stack size is: " << tInt.size() << endl;
    cout << "Pushing.." << endl;
    tInt.push(25);
    cout << "Stack size is: " << tInt.size() << endl;
    /// isFULL
    cout << "===\nisFull.." << endl;
    cout << "My stack is:" << endl;
    tInt.printAll();
    tInt.printIsFull();
    cout << "Pushing full stack..\n";
    for (int i = 0; i < 4; ++i) {
        tInt.push(i*2);
    }
    tInt.printAll();
    tInt.printIsFull();
    return 0;
}
