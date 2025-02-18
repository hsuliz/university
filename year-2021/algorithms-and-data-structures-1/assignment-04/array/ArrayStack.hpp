#ifndef EX4_ARRAYSTACK_HPP
#define EX4_ARRAYSTACK_HPP
using namespace std;

template<typename T>
class ArrayStack {
private:
    int stackSize;
    int elementsIn;
    T *stackArray;
public:
    explicit ArrayStack(int size);

    ~ArrayStack();

    void push(T element);

    void pop();

    T peek();

    bool isEmpty() const;

    int size() const;

    bool isFull() const;

/// UTILITY STUFF ///
    void printAll();
    void printIsEmpty();
    void printIsFull();

};



template<typename T>
ArrayStack<T>::ArrayStack(int size) {
    this->stackSize = size;
    this->elementsIn = -1;
    stackArray = new T(stackSize);
}

template<typename T>
ArrayStack<T>::~ArrayStack() {
    delete[] stackArray;
}

/// wstawienie elementu na szczyt stosu;
template<typename T>
void ArrayStack<T>::push(T element) {
    // if stack is full throwing exception with information
    if(isFull()) {
        throw invalid_argument("Stack is full!!");
    }
    elementsIn++;
    stackArray[elementsIn] = element;
}

/// usunięcie elementu znajdującego się na szczycie stosu;
template<typename T>
void ArrayStack<T>::pop() {
    if(isEmpty()) {
        throw invalid_argument("Can't pop empty array!!");
    }
    T *tmpArray = new T[elementsIn--];
    for (int i = 0; i <= elementsIn; ++i) {
        tmpArray[i] = stackArray[i];
    }
    delete stackArray;
    stackArray = tmpArray;
}

template<typename T>
void ArrayStack<T>::printAll() {
    if (elementsIn == -1) {
        cout << "I'm empty!!" << endl;
    } else {
        for (int i = 0; i <= elementsIn; ++i) {
            cout << stackArray[i] << " ";
        }
        cout << endl;
    }
}

template<typename T>
T ArrayStack<T>::peek() {
    return stackArray[elementsIn];
}

template<typename T>
bool ArrayStack<T>::isEmpty() const {
    if (elementsIn == -1) {
        return true;
    } else {
        return false;
    }
}

template<typename T>
int ArrayStack<T>::size() const {
    return elementsIn + 1;
}

template<typename T>
bool ArrayStack<T>::isFull() const {
    if (elementsIn == stackSize-1) {
        return true;
    } else {
        return false;
    }

}

template<typename T>
void ArrayStack<T>::printIsEmpty() {
    (isEmpty()) ? cout << "Stack is empty" : cout << "Stack is not empty";
    cout << endl;
}

template<typename T>
void ArrayStack<T>::printIsFull() {
    (isFull()) ? cout << "Stack is full" : cout << "Stack is not full";
    cout << endl;
}


#endif