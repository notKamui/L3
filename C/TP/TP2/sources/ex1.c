#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#include "../include/ex1.h"

/** 
 * Prints all triple roots up to the specified limit.
 * 
 * A triple root is a three digit number that is equal to
 * the sum of the cubes of its digits.
 * 
 * @return void
 * @param limit ; is the limit where the function stops
 */
void print_triple_roots(int limit) {
    int i;
    int units, tens, hundreds;

    // limit check
    if (limit > 999 || limit < 0) exit(EXIT_FAILURE);

    for (i = 0; i <= limit; i++) {
        units = i%10;
        tens = (i/10)%10;
        hundreds = (i/100)%10;

        if (pow(units, 3) + pow(tens, 3) + pow(hundreds, 3) == i) {
            printf("%d\n", i);
        }
    }
}

int main() {
    print_triple_roots(500);
    return EXIT_SUCCESS;
}