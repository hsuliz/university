#include <stdio.h>
#include <math.h>

void print_pi_values() {
    double pi = M_PI;
    double pi_squared = pow(pi, 2);

    for (int precision = 4; precision <= 18; precision += 2) {
        printf("𝜋 (Pi):\n");
        printf("- With %d decimal places: %.*lf\n", precision, precision, pi);

        printf("\n𝜋² (Pi squared):\n");
        printf("- With %d decimal places: %.*lf\n", precision, precision, pi_squared);

        printf("\n");
    }
}

int main() {
    print_pi_values();
    return 0;
}
