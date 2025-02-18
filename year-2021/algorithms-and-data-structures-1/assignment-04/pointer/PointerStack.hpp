//
// Created by Oleksandr Suliz on 05/12/2021.
//

#ifndef EX4POINTER_POINTERSTACK_HPP
#define EX4POINTER_POINTERSTACK_HPP

#include "LinkedList.hpp"

using namespace std;

template<typename T>
class PointerStack {
private:
    List<T> stack;
    int stackSize, elementsIn;
public:
    PointerStack(int size);

    void push(T element);

    void pop();

    T peek();

    bool isEmpty() const;

    int size() const;

    bool isFull() const;

    void printAll();

    void printIsEmpty();

    void printIsFull();
};


template<typename T>
PointerStack<T>::PointerStack(int size) {
    this->stackSize = size;
    this->elementsIn = -1;
}

template<typename T>
void PointerStack<T>::push(const T element) {
    if(isFull()) {
        throw invalid_argument("\nArray is full!!"
                               " Can't add more!!");
    }
    stack.push_back(element);
    elementsIn++;
}

template<typename T>
void PointerStack<T>::pop() {
    stack.pop_back();
    elementsIn--;
}

template<typename T>
T PointerStack<T>::peek() {
    if (isEmpty()) {
        throw invalid_argument("Array is empty!!");
    }
    return stack.back();
}

template<typename T>
bool PointerStack<T>::isEmpty() const {
    if (elementsIn > -1) {
        return false;
    } else {
        return true;
    }
}

template<typename T>
int PointerStack<T>::size() const {
    return elementsIn + 1;
}

template<typename T>
bool PointerStack<T>::isFull() const {
    if (elementsIn == stackSize-1) {
        return true;
    } else {
        return false;
    }
}

template<typename T>
void PointerStack<T>::printAll() {
    stack.printAll();
}

template<typename T>
void PointerStack<T>::printIsEmpty() {
    (isEmpty()) ? cout << "Stack is empty" : cout << "Stack is not empty";
    cout << endl;
}

template<typename T>
void PointerStack<T>::printIsFull() {
    (isFull()) ? cout << "Stack is full" : cout << "Stack is not full";
    cout << endl;
}
#endif //EX4POINTER_POINTERSTACK_H
