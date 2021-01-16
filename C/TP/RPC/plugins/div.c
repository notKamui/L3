#include <stdio.h>

int arity() {
    return 2;
}

char symbol() {
    return '/';
}

int eval(int *args) {
    if (args[1] == 0) {
        printf("WARNING: Division by 0, returning 0");
        return 0;
    }
    return args[0] / args[1];
}