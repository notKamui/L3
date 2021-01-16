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

int stack_pop(Stack **head) {
    int ret;
    Stack *popped = *head;
    *head = (*head)->next;
    ret = popped->value;
    free(popped);
    return ret;
}

void stack_reverse(Stack **head) {
    Stack *tmp;
    
    if (stack_size(*head) >= 2) {
        /* simple swap */
        tmp = (*head)->next;
        (*head)->next = tmp->next;
        tmp->next = *head;
        *head = tmp;
    }
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

int stack_size(Stack *head) {
    int size = 0;

    while (head != NULL) {
        head = head->next;
        size++;
    }

    return size;
}

void stack_free(Stack **head) {
    Stack *tmp;

    while (*head != NULL) {
        /* linked free by swapping */
        tmp = *head;
        *head = (*head)->next;
        free(tmp);
    }
}