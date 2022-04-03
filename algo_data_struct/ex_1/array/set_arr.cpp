#include "set_arr.h"

set_arr::set_arr(int min, int max) {
    this->min = min;
    this->max = max;
    this->size = max - min + 1;
    if (size > universeSize) {
        throw std::logic_error("\nSize is too big!!");
    }
    this->table = new bool[size];
    for (int i = 0; i < size; ++i) {
        table[i] = false;
    }
}

void set_arr::printSet() {
    for (int i = 0; i < size; ++i) {
        std::cout << "Index " << i + min << " is " << table[i] << std::endl;
    }
    std::cout << "=============\n";
}

void set_arr::insert(int x) {
    if (x > max || x < min) {
        throw std::logic_error("\nInsert error!!");
    }
    table[x - min] = true;
}

void set_arr::withdraw(int x) {
    if (x > max || x < min) {
        throw std::logic_error("\nWithdraw error!!");
    }
    table[x - min] = false;

}

bool set_arr::isInSet(int i) {
    if (table[i - min]) {
        return true;
    } else {
        return false;
    }
}

int set_arr::getSize() {
    return size;
}

void set_arr::clearSet() {
    // ver 1
    //delete[]table;
    //this->table = new bool[size];

    // ver 2
    for (int i = 0; i < size; ++i) {
        table[i] = false;
    }

}

//suma
set_arr set_arr::operator+(set_arr &object) {
    int g_max, g_min;
    (object.max > max) ? g_max = object.max : g_max = max;
    //std::cout << "Max is " << g_max << std::endl;
    (object.min < min) ? g_min = object.min : g_min = min;
    //std::cout << "Min is " << g_min << std::endl;

    set_arr tmp(g_min, g_max);

    for (int i = g_min; i <= g_max; ++i) {
        if (object.isInSet(i) || isInSet(i)) {
            tmp.insert(i);
        }
    }

    return tmp;
}

//część wspólna
set_arr set_arr::operator*(set_arr &object) {
    int g_max, g_min;
    (object.max > max) ? g_max = object.max : g_max = max;
    //std::cout << "Max is " << g_max << std::endl;
    (object.min < min) ? g_min = object.min : g_min = min;
    //std::cout << "Min is " << g_min << std::endl;

    set_arr tmp(g_min, g_max);

    for (int i = g_min; i <= g_max; ++i) {
        if (object.isInSet(i) && isInSet(i)) {
            tmp.insert(i);
        }
    }

    return tmp;
}

//różnica
set_arr set_arr::operator-(set_arr &object) {
    int g_max, g_min;
    (object.max > max) ? g_max = object.max : g_max = max;
    //std::cout << "Max is " << g_max << std::endl;
    (object.min < min) ? g_min = object.min : g_min = min;
    //std::cout << "Min is " << g_min << std::endl;

    set_arr tmp(g_min, g_max);

    for (int i = g_min; i < g_max; ++i) {
        if (object.isInSet(i) && isInSet(i)) {
            tmp.withdraw(i);
        }
    }

    return tmp;
}

//równość
bool set_arr::operator==(set_arr &object) {
    int g_max, g_min;
    (object.max > max) ? g_max = object.max : g_max = max;
    //std::cout << "Max is " << g_max << std::endl;
    (object.min < min) ? g_min = object.min : g_min = min;
    //std::cout << "Min is " << g_min << std::endl;

    for (int i = g_min; i < g_max; ++i) {
        if (object.table[i] == table[i]) {
            continue;
        } else {
            return false;
        }
    }

    return true;
}

//zawieranie
bool set_arr::operator<=(set_arr &object) {
    for (int i = min; i < max; ++i) {
        if (table[i] == object.table[i - min]) {
            continue;
        } else {
            return false;
        }
    }

    return true;
}




