#ifndef EX2_LIST_H
#define EX2_LIST_H

#include <string>

class List {
    virtual bool insert(int index, const int &element) = 0;

    virtual bool remove(int index) = 0;

    virtual int retrieve(int index) = 0;

    virtual int locate(const int &element) = 0;

    virtual int end() = 0;

    virtual int first() = 0;

    virtual int next(int index) = 0;

    virtual int previous(int index) = 0;

    virtual int last() = 0;

    virtual int back() = 0;

    virtual bool push_front(const int &element) = 0;

    virtual bool push_back(const int &element) = 0;

    virtual void pop_front() = 0;

    virtual void pop_back() = 0;
};


#endif //EX2_LIST_H

