#define _DEFAULT_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <readline/readline.h>
#include <dirent.h>
#include <dlfcn.h>

#include "libs/stack.h"

#include "pluginloader.h"

#define ERR_CALC -10
#define ERR_CALC_ZERO_DIVISION -11
#define ERR_CALC_NOT_ENOUGH_TERMS -12
#define ERR_CALC_UNKNOWN_OPERATOR -13

/* equivalent to Integer.parseInt(), except it returns NULL if not parsable */
int *parse_intornull(char *str) {
    int *ret;
    int i;

    ret = (int*)malloc(sizeof(int));
    *ret = atoi(str);

    /* atoi's return value is 0 if the string is not parsable
    so we have to check if it's that or str is actually a 0 */
    if (*ret == 0) {
        for (i = 0; i < strlen(str); i++) {
            if (str[i] != '0') { /* if it's not actually 0 -> free the allocated tmp string */
                free(ret);
                return NULL;
            }
        }
    }

    return ret;
}

/**
 * Delegates operations on a stack with a given token (value or symbol)
 * 
 * @param stack the stack
 * @param token the token to parse
 * @param operators the list of loaded operators
 * @param opsize the size of the list of operators
 */
void exec(Stack **stack, char *token, Operator *operators, int opsize) {
    int i, j;
    Operator operator;
    char symbol;
    int *args;
    int errno = 0;

    /* check if number */
    int *val = parse_intornull(token);

    if (val != NULL) { /* is a number */
        stack_push(stack, *val);
        free(val);
    } else { /* is not a number */
        symbol = token[0];
        if (symbol == 'p') {
            if (*stack != NULL) printf("%d\n", (*stack)->value);
        } else if (symbol == 'c') {
            stack_free(stack);
        } else if (symbol == 'a') {
            stack_print(*stack);
        } else if (symbol == 'r') {
            stack_reverse(stack);
        } else if (symbol == '?') {
            printf("[integer] : to push an int on the stack\n");
            printf("q : to quit\n");
            printf("p : to print the top's value\n");
            printf("a : to print the whole stack\n");
            printf("r : to reverse the two top values\n");
            printf("c : to reset the stack\n");
            printf("? : to print this message\n");
        } else if (stack_size(*stack) == 0) {
            errno = ERR_STACK_EMPTY;
        } else { /* if it's a symbol (may be an unkown operator) */
            for (i = 0; i < opsize; i++) { /* for each operator in the least */
                operator = operators[i];
                if (operator.symbol == symbol) { /* ^ check if symbol is in it */
                    if (stack_size(*stack) < operator.arity) { /* check if stack has enough elements */
                        errno = ERR_CALC_NOT_ENOUGH_TERMS;
                        break;
                    }
                    /* retrieve arguments from stack and eval the result to put it back in the stack */
                    args = (int *)malloc(sizeof(int) * operator.arity);
                    for (j = operator.arity - 1; j >= 0; j--) {
                        args[j] = stack_pop(stack);
                    }
                    stack_push(stack, (*operator.eval)(args));
                    free(args);
                    break;
                }
            }
            if (i == opsize)
                errno = ERR_CALC_UNKNOWN_OPERATOR;
        }

        /* err check */
        switch(errno) {
            case ERR_STACK_EMPTY:
                printf("Error : stack is empty\n");
                break;
            case ERR_CALC_NOT_ENOUGH_TERMS:
                printf("Error : not enough terms to operate\n");
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
    int i;
    Stack *stack = NULL;
    char *token = NULL;
    char *line = NULL;
    char *cmd = NULL;
    int opsize;

    /* getting the operators */
    Operator *operators = receive_operators(&opsize);

    /* parsing the command line into tokens to feed to exec() */
    while (1) {
        cmd = line = readline("$ ");
        if (strcmp(cmd, "q") == 0) break;
        while ((token = __strtok_r(cmd, " ", &cmd))) { /* "for each token -> exec(..token..)" */
            exec(&stack, token, operators, opsize);
        }
        free(line);
    }
    free(line);

    /* Freeing everything */
    stack_free(&stack);
    for (i = 0; i < opsize; i++) {
        dlclose(operators[i].handle);
    }
    free(operators);

    return EXIT_SUCCESS;
}