#include <stdio.h>
#include <stdlib.h>
#include "../include/binom.h"

// time complexity is O(2^n)
int binom(int n, int p) {
    if (p == 0 || p == n)
        return 1;
    return binom(n - 1, p - 1) + binom(n - 1, p);
}

// time complexity is O(np)
int binom2(int n, int p) {
    int** pascal;
    int i, j;

    // avoiding trivial cases
    if (n == 0 || n == p) return 1;

    // initializing Pascal's triangle
    pascal = (int**)malloc(sizeof(int*)*n);
    for (i = 0; i <= n; i++) {
        pascal[i] = (int*)malloc(sizeof(int)*min(i+2, p+1)); // limit the size
        pascal[i][0] = 1;
        if (i <= p) {
            pascal[i][i] = 1;
        }
    }

    // calculating each entry without those we don't need
    for (i = 2; i <= n; i++) {
        for (j = 1; j <= min(i, p); j++) {
            pascal[i][j] = pascal[i-1][j] + pascal[i-1][j-1];
        }
    }

    return pascal[n][p];
}

int main(int argc, char** argv) {
    int n, p;

    if (argc != 3) {
        printf("Error : Usage : %s n p\n", argv[0]);
        return EXIT_FAILURE;
    }

    if ((n = atoi(argv[1])) < 0 || (p = atoi(argv[2])) < 0) {
        printf("Error : n and p must be positive integers\n");
        return EXIT_FAILURE;
    }

    if (p > n) {
        printf("Error : p must be smaller or equal to n\n");
        return EXIT_FAILURE;
    }

    printf("%d\n", binom2(n, p));
    /*for (int i = 0; i <= 8; i++) {
        for (int j = 0; j <= i; j++) {
            printf("%d ", binom2(i, j));
        }
        printf("\n");
    }*/
    

    return EXIT_SUCCESS;
}
