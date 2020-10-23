/**
 * Created by Jimmy @notKamui Teillard
 * on 16/10/2020
 *
 * Contains utility functions to manipulate stacks
 */

#ifndef RPCALC_STACK_H
#define RPCALC_STACK_H

/**
 * Simple implementation of a linked stack of integers
 *
 * @param value is an int (or a char)
 * @param next is a pointer to the next element
 */
typedef struct stack {
    int value;
    struct stack *next;
} Stack;

/**
 * Creates a new stack
 *
 * @param value is an int (or a char)
 * @return the head of the new stack
 */
Stack *stack_init(int value);

/**
 * Pushes an element on TOP of the stack
 *
 * @param head is the head of the stack
 * @param value is the value of the element
 */
void stack_push(Stack **head, int value);

/**
 * Pops the value on TOP of the stack
 *
 * @param head is the head of the stack
 * @return the popped value
 */
int stack_pop(Stack **head);

/**
 * Prints the value of the stack ;
 * head first, tail last
 *
 * @param head is the head of the stack
 */
void stack_print(Stack *head);

/**
 * Frees the memory of the stack?
 * 
 * @param head is the head of the stack
 */
void stack_free(Stack **head);

#endif
