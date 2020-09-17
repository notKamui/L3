#include <stdio.h>
#include <stdlib.h>
#include <regex.h>

int main(int argc, char *argv[]) {
    int a, b, res;
    regex_t regex_int, regex_op;
    if(regcomp(&regex_int, "^([0-9]+)$", REG_EXTENDED) != 0) exit(EXIT_FAILURE);
    if(regcomp(&regex_op, "^[+\-x/]$", REG_EXTENDED) != 0) exit(EXIT_FAILURE);

    if(
        argc != 4 ||
        regexec(&regex_op, argv[1], 0, NULL, 0) != 0 ||
        regexec(&regex_int, argv[2], 0, NULL, 0) != 0 ||
        regexec(&regex_int, argv[3], 0, NULL, 0) != 0
      ) {
        printf("Use : ./Calc (+|-|x|/) int int\n");
        exit(EXIT_FAILURE);
    }

    a = atoi(argv[2]);
    b = atoi(argv[3]);

    switch(argv[1][0]) {
        case '+':
            res = a + b;
            break;
        case '-':
            res = a - b;
            break;
        case 'x':
            res = a * b;
            break;
        case '/':
            res = a / b;
            break;
    }

    printf("= %d\n", res);

    regfree(&regex_int);
    regfree(&regex_op);

    return EXIT_SUCCESS;
}
