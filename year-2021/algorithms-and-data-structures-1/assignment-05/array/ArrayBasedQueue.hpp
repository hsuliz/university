#ifndef EX5ARRAY_ARRAYBASEDQUEUE_HPP
#define EX5ARRAY_ARRAYBASEDQUEUE_HPP


#include <iostream>

const int MAX = 7;

template<typename T>
class ArrayBasedQueue {
private:
    T items[MAX];
    int front, rear, size, trueSize;

public:
    explicit ArrayBasedQueue(int front = 0, int rear = MAX);

    //~ArrayBasedQueue();

    bool isEmpty() const;

    bool isFull() const;

    int getSize() const;

    void enqueue(const T &element);

    void dequeue();

    T getFront();

    T getRear();

    // UTILITY //

    int getTrueSize() const;

    void printAll();

    void printSize();

    void printTrueSize();

    void printIsFull();

    void printFullArrayN();

    void printIsEmpty();
};

template<typename T>
ArrayBasedQueue<T>::ArrayBasedQueue(int front, int rear) {
    this->rear = rear;
    this->front = front;
    this->size = 0;
    this->trueSize = rear - front;
    if (front <= 0 || rear > MAX) {
        throw std::overflow_error("\nCan't change const size of array!!(Max 7)");
    }
    std::cout << "Created queue from " << front << " to " << rear << "!!" << std::endl;
}


template<typename T>
bool ArrayBasedQueue<T>::isEmpty() const {
    if (size == 0) {
        return true;
    } else {
        return false;
    }
}

template<typename T>
bool ArrayBasedQueue<T>::isFull() const {
    if (size == trueSize) {
        return true;
    } else {
        return false;
    }
}

template<typename T>
int ArrayBasedQueue<T>::getSize() const {
    return size;
}

template<typename T>
int ArrayBasedQueue<T>::getTrueSize() const {
    return trueSize;
}

template<typename T>
void ArrayBasedQueue<T>::enqueue(const T &element) {
    if (isFull()) {
        throw std::out_of_range("\nCAN'T ADD MORE!!");
    }
    items[size + front] = element;
    size++;
}

template<typename T>
void ArrayBasedQueue<T>::dequeue() {
    trueSize--;
    front++;
    for (int i = 0; i < trueSize; ++i) {
        items[i] = items[i + 1];
    }
}

template<typename T>
T ArrayBasedQueue<T>::getFront() {
    return items[front];
}

template<typename T>
T ArrayBasedQueue<T>::getRear() {
    return items[rear - 1];
}

template<typename T>
void ArrayBasedQueue<T>::printAll() {
    std::cout << "\t";
    for (int i = front; i < rear; ++i) {
        std::cout << items[i] << " ";
    }
    std::cout << std::endl;
}

template<typename T>
void ArrayBasedQueue<T>::printTrueSize() {
    std::cout << "\t" << trueSize << std::endl;
}

template<typename T>
void ArrayBasedQueue<T>::printIsFull() {
    (isFull()) ? std::cout << "I'm full!!\n" : std::cout << "I'm not full!!\n";
}

template<typename T>
void ArrayBasedQueue<T>::printFullArrayN() {
    for (auto &item: items) {
        std::cout << item << " ";
    }
    std::cout << std::endl;
}

template<typename T>
void ArrayBasedQueue<T>::printIsEmpty() {
    (isEmpty()) ? std::cout << "I'm empty!!\n" : std::cout << "I'm not empty!!\n";
}

template<typename T>
void ArrayBasedQueue<T>::printSize() {
    std::cout << size << std::endl;

}


#endif //EX5ARRAY_ARRAYBASEDQUEUE_HPP