#ifndef EX3_LINKEDLIST_HPP
#define EX3_LINKEDLIST_HPP

#include <iostream>

using namespace std;


template<typename T>
class List {
private:
    template<typename>
    class Node {
    public:
        Node *pNext;
        T data;
        int index;

        Node(T data = T(), Node *pNext = nullptr, int index = 1) {
            this->data = data;
            this->pNext = pNext;
            this->index = index;
        }
    };

    int listSize;
    Node<T> *head;

public:
    List();

    ~List();
    //ok
    void insert(int index, T data);

    //ok
    void remove(int index);

    //ok
    T retrieve(int index);

    //ok
    int locate(T data);

    //ok
    bool empty();

    //ok
    Node<T> *first() {
        return head;
    };

    //ok
    T front();

    //ok
    Node<T> *last() {
        Node<T> *tmp = this->head;
        while (true) {
            if (tmp->pNext == nullptr) {
                return tmp;
            }
            tmp = tmp->pNext;
        }
    }

    //ok
    T back();

    //ok
    int len();

    //ok
    void push_front(T data);

    //ok
    bool push_back(T data);

    //ok
    void pop_front();

    //ok
    void pop_back();

    void reverseList();

    // UTILITY

    int allIndex();

    int getSize() { return listSize; }

    void clearAll();

    void printAll();
};

template<typename T>
List<T>::List() {
    listSize = 0;
    head = nullptr;
}

template<typename T>
List<T>::~List() {
    clearAll();
}

template<typename T>
bool List<T>::push_back(T data) {
    if (head == nullptr) { // check if head emtry
        head = new Node<T>(data, nullptr, 1);
    } else {
        Node<T> *tmp = this->head;
        while (tmp->pNext != nullptr) {
            tmp = tmp->pNext;
        }
        int index = listSize + 1;
        tmp->pNext = new Node<T>(data, nullptr, index); // adding to the end of list
    }
    listSize++;
}

// working!!
template<typename T>
T List<T>::retrieve(int index) {
    if (index < 1 || index > listSize) {
        return -1;
    }
    Node<T> *tmp;
    tmp = head;
    for (int i = 0; i < index; ++i) {
        if (tmp->index == index) {
            return tmp->data;
        }
        tmp = tmp->pNext;
    }
}

template<typename T>
void List<T>::pop_front() {
    Node<T> *tmp = head;
    head = head->pNext;
    delete tmp;
    listSize--;
}

template<typename T>
void List<T>::clearAll() {
    while (listSize) {
        pop_front();
    }
}


template<typename T>
void List<T>::push_front(T data) {
    head = new Node<T>(data, head, listSize);
    listSize++;
}

// i hate this //
template<typename T>
void List<T>::insert(int index, T data) {
    Node<T> *tmp = this->head;
    for (int i = 1; i < index - 1; ++i) {
        tmp = tmp->pNext;
    }
    tmp->pNext = new Node<T>(data, tmp->pNext, index);
    listSize++;
}


template<typename T>
void List<T>::remove(int index) {
    Node<T> *tmp = this->head;
    for (int i = 1; i < index - 1; ++i) {
        tmp = tmp->pNext;
    }
    Node<T> *toDelete = tmp->pNext;
    tmp->pNext = toDelete->pNext;
    delete toDelete;
    listSize--;
}

template<typename T>
void List<T>::pop_back() {
    remove(listSize - 1);
}

template<typename T>
bool List<T>::empty() {
    if (head == nullptr) {
        return true;
    } else {
        return false;
    }
}


template<typename T>
T List<T>::front() {
    return head->data;
}

// work
template<typename T>
T List<T>::back() {
    if (listSize == 0) {
        return head->data;
    } else {
        Node<T> *tmp = this->head;
        for (int i = 0; i < listSize - 1; ++i) {
            tmp = tmp->pNext;
        }
        return tmp->data;
    }
}

template<typename T>
int List<T>::len() {
    return listSize;
}

template<typename T>
void List<T>::printAll() {
    Node<T> *tmp;
    tmp = head;
    while (tmp != nullptr) {
        cout << tmp->data << " ";
        tmp = tmp->pNext;
    }
    cout << endl << "===========" << endl;
}

template<typename T>
int List<T>::allIndex() {
    Node<T> *tmp;
    tmp = head;
    while (tmp != nullptr) {
        cout << tmp->index << " ";
        tmp = tmp->pNext;
    }
}

template<typename T>
int List<T>::locate(T data) {
    Node<T> *tmp;
    tmp = head;
    while (tmp != nullptr) {
        if (tmp->data == data) {
            return tmp->index;
        }
        tmp = tmp->pNext;
    }
    return -1;
}

template<typename T>
void List<T>::reverseList() {
    Node<T> *tmp;
    Node<T> *prev = nullptr;
    Node<T> *next = head;

    while (next != nullptr) {
        tmp = next->pNext;
        next->pNext = prev;
        prev = next;
        next = tmp;
    }
    head = prev;
}


#endif //EX3_LINKEDLIST_HPP
