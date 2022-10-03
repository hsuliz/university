#include "set_list.h"

#include <utility>

int set_list::getSize() {
    return vec.size();
}

void set_list::printSet() {
    if (vec.empty()) {
        std::cout << "IM EMPTY!!\n";
        return;
    }
    for (int i = 0; i < getSize(); ++i) {
        std::cout << vec.at(i) << std::endl;
    }
    std::cout << "=================\n";
}

void set_list::insert(int x) {
    for (int i: vec) {
        if (i == x) {
            std::cout << "This element already exists!!\n";
            return;
        }
    }
    vec.push_back(x);
}

void set_list::withdraw(int x) {
    for (int i = 0; i < vec.size(); ++i) {
        if (vec.at(i) == x) {
            vec.erase(vec.begin() + i);
        }
    }
}

bool set_list::isInSet(int x) {
    for (int i: vec) {
        if (i == x) {
            return true;
        }
    }
    return false;
}

set_list set_list::operator+(set_list &obj) {
    vec.insert(vec.end(), obj.vec.begin(), obj.vec.end());
    return set_list(vec);
}

set_list::set_list(std::vector<int> vector) {
    vec = std::move(vector);
}

set_list set_list::operator*(set_list &obj) {
    std::vector<int> tmp;
    for (int i = 0; i < obj.getSize(); ++i) {
        if (isInSet(obj.vec[i])) {
            tmp.push_back(obj.vec[i]);
        }
    }

    return set_list(tmp);

    //ver 2
    /*std::vector<int> tmp;

    std::sort(vec.begin(), vec.end());
    std::sort(obj.vec.begin(), obj.vec.end());

    std::set_intersection(vec.begin(), vec.end(),
                          obj.vec.begin(), obj.vec.end(),
                          back_inserter(tmp));

    return set_list(tmp);*/
}

// min
set_list set_list::operator-(set_list &obj) {
    std::vector<int> tmp;
    for (int i = 0; i < vec.size(); ++i) {
        if (!obj.isInSet(vec[i])) {
            tmp.push_back(vec[i]);
        }
        if(!isInSet(obj.vec[i])) {
            tmp.push_back(obj.vec[i]);
        }
    }
    return set_list(tmp);
}

bool set_list::operator==(set_list &obj) {
    return (obj.vec == vec);
}

bool set_list::operator<=(set_list &obj) {
    for (int i = 0; i < vec.size(); ++i) {
        if(isInSet(obj.vec[i])) {
            continue;
        } else {
            return false;
        }
    }
    return true;
}


