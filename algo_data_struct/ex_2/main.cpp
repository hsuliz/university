#include <iostream>
#include "queue.h"

int main() {
    Queue test(9);
    for (int i = 0; i < 10; ++i) {
        test.insert(i);
    }
    test.print_like_matrix();
    test.RemoveRootElem();
    test.print_like_matrix();
    std::cout << test.getRootElem();

    return 0;
}
