/**
 * Created by Jimmy @notKamui Teillard
 * on 16/10/2020
 */
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#include "calc.h"
#include "stack.h"

int fact(int i) {
    if (i < 0) return i;
    else if (i == 0 || i == 1) return 1;
    else return i * fact(i-1);
}

int calc_add(Stack **stack) {
    int a, b;

    if (stack == NULL || *stack == NULL) return ERR_STACK_EMPTY;
    if (stack_size(*stack) < 2) return ERR_CALC_NOT_ENOUGH_TERMS;

    b = stack_pop(stack);
    a = stack_pop(stack);

    stack_push(stack, a + b);
    return 0;
}

int calc_sub(Stack **stack) {
    int a, b;

    if (stack == NULL || *stack == NULL) return ERR_STACK_EMPTY;
    if (stack_size(*stack) < 2) return ERR_CALC_NOT_ENOUGH_TERMS;

    b = stack_pop(stack);
    a = stack_pop(stack);

    stack_push(stack, a - b);
    return 0;
}

int calc_mul(Stack **stack) {
    int a, b;

    if (stack == NULL || *stack == NULL) return ERR_STACK_EMPTY;
    if (stack_size(*stack) < 2) return ERR_CALC_NOT_ENOUGH_TERMS;

    b = stack_pop(stack);
    a = stack_pop(stack);

    stack_push(stack, a * b);
    return 0;
}

int calc_div(Stack **stack) {
    int a, b;

    if (stack == NULL || *stack == NULL) return ERR_STACK_EMPTY;
    if (stack_size(*stack) < 2) return ERR_CALC_NOT_ENOUGH_TERMS;

    b = stack_pop(stack);
    a = stack_pop(stack);

    if (b == 0) {
        stack_push(stack, a);
        stack_push(stack, b);
        return ERR_CALC_ZERO_DIVISION;
    }

    stack_push(stack, a / b);
    return 0;
}

int calc_mod(Stack **stack) {
    int a, b;

    if (stack == NULL || *stack == NULL) return ERR_STACK_EMPTY;
    if (stack_size(*stack) < 2) return ERR_CALC_NOT_ENOUGH_TERMS;

    b = stack_pop(stack);
    a = stack_pop(stack);

    stack_push(stack, a % b);
    return 0;
}

int calc_fact(Stack **stack) {
    int i;

    if (stack == NULL || *stack == NULL) return ERR_STACK_EMPTY;
    if (stack_size(*stack) < 1) return ERR_CALC_NOT_ENOUGH_TERMS;

    i = stack_pop(stack);

    stack_push(stack, fact(i));
    return 0;
}

int calc_pow(Stack **stack) {
    int a, b;

    if (stack == NULL || *stack == NULL) return ERR_STACK_EMPTY;
    if (stack_size(*stack) < 2) return ERR_CALC_NOT_ENOUGH_TERMS;

    b = stack_pop(stack);
    a = stack_pop(stack);

    stack_push(stack, (int)pow(a, b));
    return 0;
}