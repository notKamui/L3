#include <stdio.h>
#include <stdlib.h>

#include "../include/ex2.h"

/**
 * Prints the terms of the harmonic sequence
 * up to the specified n with a given frequency.
 * Float precision.
 * 
 * @return void
 * @param n ; at which n to stop
 * @param frequency ; the frequency at which terms are printed
 */
void print_harmonic_float(long n, int frequency) {
    long i;
    float res = 0;

    if (n < 1 || frequency < 1) exit(EXIT_FAILURE);

    for (i = 1; i <= n; i++) {
        res += (float)1/i;

        if (i%frequency == 0) {
            printf("n = %ld -> %f\n", i, res);
        }
    }
}

/**
 * Prints the terms of the harmonic sequence
 * up to the specified n with a given frequency.
 * Double precision.
 * 
 * @return void
 * @param n ; at which n to stop
 * @param frequency ; the frequency at which terms are printed
 */
void print_harmonic_double(long n, int frequency) {
    long i;
    double res = 0;

    if (n < 1 || frequency < 1) exit(EXIT_FAILURE);

    for (i = 1; i <= n; i++) {
        res += (double)1/i;

        if (i%frequency == 0) {
            printf("n = %ld -> %f\n", i, res);
        }
    }
}

int main() {
    print_harmonic_float(1000000000, 1000); // stales at 15.403683
    printf("\n");
    print_harmonic_double(100000000000, 100000000); // can't find when it stales // too big
    return EXIT_SUCCESS;
}