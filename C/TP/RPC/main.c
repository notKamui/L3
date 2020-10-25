#include <stdio.h>
#include <stdlib.h>
#include <readline/readline.h>

#include "stack.h"
#include "parse.h"

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

    ret = parse_intornull("2");
    if (ret == NULL) printf("NaN\n");
    else printf("%d\n", *ret);
    free(ret);

    char *str = readline(NULL);
    printf("%s\n", str);
    free(str);

    return EXIT_SUCCESS;
}