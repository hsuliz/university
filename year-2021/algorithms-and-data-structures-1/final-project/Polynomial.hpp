#ifndef POLYNOMIAL_HPP
#define POLYNOMIAL_HPP

#include <iostream>

/**
 * Adding 2 polynomials A and b
 * @param Polynomial A
 * @param Polynomial B
 * @param Size of polynomials
 * @return Sum value of polynomials
 */
int *add(const int A[], const int B[], int size) {
    int *sum = new int[size];
    for (int i = 0; i < size; i++) {
        sum[i] = A[i];
    }
    for (int i = 0; i < size; i++) {
        sum[i] += B[i];
    }
    return sum;
}

/**
 * Substantiating 2 polynomials
 * @param Polynomial A
 * @param Polynomial B
 * @param Size of polynomials
 * @return Substantiation value of polynomials
 */
int *sub(const int A[], const int B[], int size) {
    int *sub = new int[size];
    for (int i = 0; i < size; i++) {
        sub[i] = A[i];
    }
    for (int i = 0; i < size; i++) {
        sub[i] -= B[i];
    }
    return sub;
}

/**
 * Multiplying 2 polynomials
 * @param Polynomial A
 * @param Polynomial B
 * @param Size of polynomials
 * @return Multi value of polynomials
 */
int *multiply(const int A[], const int B[], int size) {
    int *mult = new int[size - 1];
    for (int i = 0; i < size - 1; i++) {
        mult[i] = 0;
    }
    for (int i = 0; i < size; i++) {
        for (int j = 0; j < size; j++) {
            mult[i + j] += A[i] * B[j];
        }
    }
    return mult;
}


/**
 *
 * @param Polynomial A
 * @param Value of x
 * @param Size of Polynomial
 * @return Computed value
 */
int hornerMethod(const int A[], int x, int size) {
    int horner = A[0];
    for (int i = 1; i < size; i++) {
        horner = horner * x + A[i];
    }
    return horner;
}

// UTILITY //
/**
 *
 * @param Polynomial to print
 * @param Size of polynomial
 * @param Name of polynomial
 */
void printPoly(int A[], int n, const std::string &name = "") {
    for (int i = 0; i < n; i++) {
        std::cout << A[i];
        if (i != 0) {
            std::cout << "x^" << i;
        }
        if (i != n - 1) {
            std::cout << " + ";
        }
    }
    std::cout << std::endl;
}


#endif //POLYNOMIAL_HPP
