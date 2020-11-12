#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <readline/readline.h>

#include "stack.h"
#include "parse.h"
#include "calc.h"

void exec(Stack **stack, char *op) {
    int errno = 0;

    int *val = parse_intornull(op);

    if (val != NULL) {
        stack_push(stack, *val);
        free(val);
    } else {
        if (strcmp(op, "+") == 0) {
            errno = calc_add(stack);
        } else if (strcmp(op, "-") == 0) {
            errno = calc_sub(stack);
        } else if (strcmp(op, "*") == 0) {
            errno = calc_mul(stack);
        } else if (strcmp(op, "/") == 0) {
            errno = calc_div(stack);
        } else if (strcmp(op, "%") == 0) {
            errno = calc_mod(stack);
        } else if (strcmp(op, "!") == 0) {
            errno = calc_fact(stack);
        } else if (strcmp(op, "^") == 0) {
            errno = calc_pow(stack);
        } else if (strcmp(op, "p") == 0) {
            if (*stack != NULL) printf("%d\n", (*stack)->value);
        } else if (strcmp(op, "c") == 0) {
            stack_free(stack);
        } else if (strcmp(op, "a") == 0) {
            stack_print(*stack);
        } else if (strcmp(op, "r") == 0) {
            stack_reverse(stack);
        } else if (strcmp(op, "?") == 0) {
            printf("[integer] : to push an int on the stack\n");
            printf("q : to quit\n");
            printf("p : to print the top's value\n");
            printf("a : to print the whole stack\n");
            printf("r : to reverse the two top values\n");
            printf("c : to reset the stack\n");
            printf("? : to print this message\n");
        } else if (strcmp(op, "q") != 0) {
            errno = ERR_CALC_UNKNOWN_OPERATOR;
        }

        switch(errno) {
            case ERR_STACK_EMPTY:
                printf("Error : stack is empty\n");
                break;
            case ERR_CALC_NOT_ENOUGH_TERMS:
                printf("Error : not enough terms to operate\n");
                break;
            case ERR_CALC_ZERO_DIVISION:
                printf("Error : cannot divide by zero\n");
                break;
            case ERR_CALC_UNKNOWN_OPERATOR:
                printf("Error : unkown operator\n");
                break;
            default:
                break;
        }
    }
}

int main() {
    Stack *stack = NULL;
    char *token = NULL;
    char *line = NULL;
    char *cmd = NULL;

    while (1) {
        cmd = line = readline("$ ");
        if (strcmp(cmd, "q") == 0) break;
        while ((token = __strtok_r(cmd, " ", &cmd))) {
            exec(&stack, token);
        }
        free(line);
    }
    free(line);

    stack_free(&stack);

    return EXIT_SUCCESS;
}