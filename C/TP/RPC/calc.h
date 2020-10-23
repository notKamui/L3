/**
 * Created by Jimmy @notKamui Teillard
 * on 16/10/2020
 *
 * Contains utility functions to the reverse polish calculator
 */

#ifndef RPCALC_CALC_H
#define RPCALC_CALC_H

#include "stack.h"

/**
 * Applies the given token on the given stack.
 * 
 * @param head is the head of the stack
 * @param token is the token to be applied
 */
void calc_instruct(Stack **head, char *token);

/**
 * Converts a string to an int or returns NULL
 * 
 * @param token is the token to be converted
 * @return a int* or NULL if the string could not be converted
 */
int *calc_toint(char *token);

#endif
