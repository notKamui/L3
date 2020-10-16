#include <stdio.h>
#include <stdlib.h>

#include "../include/stack.h"

int main() {
    Stack *stack = stack_init(2);
    stack_push(&stack, 5);
    stack_push(&stack, 7);

    stack_print(stack);

    printf("%d\n", stack_pop(&stack)->value);

    stack_print(stack);

    return EXIT_SUCCESS;
}