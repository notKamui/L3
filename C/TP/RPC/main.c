#include <stdio.h>
#include <stdlib.h>

#include "stack.h"
#include "calc.h"

int main() {
    int *ret;
    Stack *stack;
    
    stack = stack_init(2);
    stack_push(&stack, 5);
    stack_push(&stack, 7);

    stack_print(stack);

    printf("%d\n", stack_pop(&stack));

    stack_print(stack);

    stack_free(&stack);
    free(stack);

    stack_print(stack);

    ret = calc_toint("2");
    if (ret == NULL) printf("NaN\n");
    else printf("%d\n", *ret);
    free(ret);

    return EXIT_SUCCESS;
}