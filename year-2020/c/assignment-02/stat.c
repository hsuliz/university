#include <stdio.h>
#include <math.h>

#define MAX_SIZE 100

double calculate_sum(double data[], int size) {
    double sum = 0;
    for (int i = 0; i < size; i++) {
        sum += data[i];
    }
    return sum;
}

double calculate_average(double data[], int size) {
    double sum = calculate_sum(data, size);
    return sum / size;
}

double calculate_standard_deviation(double data[], int size) {
    double mean = calculate_average(data, size);
    double deviation = 0;

    for (int i = 0; i < size; i++) {
        deviation += pow(data[i] - mean, 2);
    }

    return sqrt(deviation / size);
}

int main() {
    double data[MAX_SIZE];
    int size;

    printf("Enter the number of data points: ");
    scanf("%d", &size);

    printf("Enter the data points:\n");
    for (int i = 0; i < size; i++) {
        scanf("%lf", &data[i]);
    }

    double sum = calculate_sum(data, size);
    double average = calculate_average(data, size);
    double std_deviation = calculate_standard_deviation(data, size);

    printf("\nSum: %.2lf\n", sum);
    printf("Average: %.2lf\n", average);
    printf("Standard Deviation: %.2lf\n", std_deviation);

    return 0;
}
