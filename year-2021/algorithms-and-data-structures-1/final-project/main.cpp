#include "Polynomial.hpp"
#include <iostream>

using namespace std;


int main() {
    int A[] = {5, 0, 10, 6};
    int B[] = {1, 2, 5, 0};
    int sizeOf = sizeof(A) / sizeof(A[0]);

    // sum
    int *sum = add(A, B, sizeOf);

    // sub
    int *minus = sub(A, B, sizeOf);

    // mult
    int *mult = multiply(A, B, sizeOf);

    // horner
    int xForHorner = 2;
    int hornerM = hornerMethod(A, sizeOf, xForHorner);

    // utility
    int multSize = sizeOf - 1;

    printPoly(A, sizeOf, "1");

    printPoly(B, sizeOf, "2");


    // PRINT ALL //

    cout << "\nSum is \n";
    printPoly(sum, sizeOf);
    cout << "Sub is \n";
    printPoly(minus, sizeOf);
    cout << "Mult is \n";
    printPoly(mult, multSize);
    cout << "Horner (x = 2) is \n";
    std::cout << hornerM << std::endl;

    return 0;
}

