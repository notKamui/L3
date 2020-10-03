#include <stdio.h>
#include <stdlib.h>
#include "../include/binom.h"

// time complexity is O(2^n)
int binom(int n, int p) {
    if (p == 0 || p == n)
        return 1;
    return binom(n - 1, p - 1) + binom(n - 1, p);
}

int main(int argc, char** argv) {
    int n, p;

    if (argc != 3) {
        printf("Error : Usage : %s n p\n", argv[0]);
        return EXIT_FAILURE;
    }

    if (!(n = atoi(argv[1])) || !(p = atoi(argv[2]))) {
        printf("Error : n and p must be positive integers\n");
        return EXIT_FAILURE;
    }

    if (p > n) {
        printf("Error : p must be smaller or equal to n\n");
        return EXIT_FAILURE;
    }

    printf("%d\n", binom(n, p));
    return EXIT_SUCCESS;
}
