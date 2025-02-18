#ifndef EX5POINTER_POINTERBASEDQUEUE_HPP
#define EX5POINTER_POINTERBASEDQUEUE_HPP

#include <iostream>


template<typename T>
class PointerBasedQueue {
private:
    template<typename>
    struct Node {
        T value;
        Node *next;

        Node(T value, Node *next) {
            this->value = value;
            this->next = next;
        }
    };

    int size;
    Node<T> *front;
    Node<T> *rear;
public:

    PointerBasedQueue();

    ~PointerBasedQueue();

    bool isEmpty() const;

    int getSize() const;

    void enqueue(const T &element);

    void dequeue();

    T getFront();

    T getRear();

    // UTILITY //

    void printIsEmpty();

    void printAll();

    void printSize();

    void printRear();

    void printFront();
};

template<typename T>
PointerBasedQueue<T>::PointerBasedQueue() {
    front = nullptr;
    rear = nullptr;
    this->size = -1;
    std::cout << "Created queue!!" << std::endl;
}

template<typename T>
bool PointerBasedQueue<T>::isEmpty() const {
    if (size == -1) {
        return true;
    } else {
        return false;
    }
}

template<typename T>
int PointerBasedQueue<T>::getSize() const {
    return size;
}

template<typename T>
void PointerBasedQueue<T>::enqueue(const T &element) {
    if (front == nullptr) {
        front = new Node<T>(element, nullptr);
    } else {
        Node<T> *tmp = front;
        while (tmp->next != nullptr) {
            tmp = tmp->next;
        }
        tmp->next = new Node<T>(element, nullptr);
        rear = tmp->next;
    }
    size++;
}

template<typename T>
T PointerBasedQueue<T>::getFront() {
    return front->value;
}

template<typename T>
T PointerBasedQueue<T>::getRear() {
    return rear->value;
}

template<typename T>
void PointerBasedQueue<T>::printAll() {
    Node<T> *tmp;
    tmp = front;
    while (tmp != nullptr) {
        std::cout << tmp->value << " ";
        tmp = tmp->next;
    }
    std::cout << std::endl;
}

template<typename T>
void PointerBasedQueue<T>::printSize() {
    std::cout << "Size of queue is : " << size + 1 << std::endl;
}

template<typename T>
void PointerBasedQueue<T>::printIsEmpty() {
    (isEmpty()) ? std::cout << "I'm empty!!" : std::cout << "I'm not empty!!";
    std::cout << std::endl;

}

template<typename T>
void PointerBasedQueue<T>::dequeue() {
    if (isEmpty()) {
        std::cout << "Can't dequeue empty queue!!\n";
        return;
    }
    front = front->next;
    size--;
}

template<typename T>
void PointerBasedQueue<T>::printRear() {
    std::cout << "Rear: " << rear->value << std::endl;

}

template<typename T>
void PointerBasedQueue<T>::printFront() {
    std::cout << "Front: " << front->value << std::endl;

}

template<typename T>
PointerBasedQueue<T>::~PointerBasedQueue() {
    while (size != -1) {
        dequeue();
    }
    std::cout << "Destructor:\n";
    printIsEmpty();
}


#endif //EX5POINTER_POINTERBASEDQUEUE_HPP
