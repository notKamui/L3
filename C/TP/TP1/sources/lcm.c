#include <stdio.h>
#include <stdlib.h>

#include "../include/lcm.h"

/**
 * The lowest common multiple of two numbers.
 * 
 * @param a the first number
 * @param b the second number
 * @return the lowest common multiple
 */
int lcm(int a, int b) {
    int min = (a < b) ? a : b;

    while (1) {
        if (min%a == 0 && min%b == 0) {
            return min;
        }
        min++;
    }
}

int main(int argc, char** argv) { 
    int i;
    int m = 1;

    if (argc < 2) return EXIT_FAILURE;

    for (i = 1; i < argc; i++) {
        m = lcm(atoi(argv[i]), m);
    }

    printf("%d\n", m);

    return EXIT_SUCCESS;
}