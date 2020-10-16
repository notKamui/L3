/**
 * Created by Jimmy @notKamui Teillard
 * on 16/10/2020
 */

#include <stdio.h>
#include <stdlib.h>

#include "stack.h"

Stack *stack_init(int value) {
    Stack *head = (Stack*)malloc(sizeof(Stack));
    if (!head) {
        fprintf(stderr, "Error : Stack ! Memory allocation failure");
        exit(EXIT_FAILURE);
    }
    head->value = value;
    head->next = NULL;
    return head;
}

void stack_push(Stack **head, int value) {
    Stack *newHead = stack_init(value);
    newHead->next = *head;
    *head = newHead;
}

Stack *stack_pop(Stack **head) {
    Stack *popped = *head;
    *head = (*head)->next;
    return popped;
}

void stack_print(Stack *head) {
    Stack *current = head;

    printf("[ ");
    while (current != NULL) {
        printf("%d ", current->value);
        current = current->next;
    }
    printf("]\n");
}