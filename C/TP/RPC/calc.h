/**
 * Created by Jimmy @notKamui Teillard
 * on 16/10/2020
 *
 * Contains rpc functions on stacks
 */

#ifndef RPCALC_CALC_H
#define RPCALC_CALC_H

#include "stack.h"

#define ERR_CALC -10
#define ERR_CALC_ZERO_DIVISION -11
#define ERR_CALC_NOT_ENOUGH_TERMS -12
#define ERR_CALC_UNKNOWN_OPERATOR -13

/**
 * Pops 2 values out of the stack and adds them to put it back in
 * 
 * @param stack is the stack
 * 
 * @return 0 or the error code
 */
int calc_add(Stack **stack);

/**
 * Pops 2 values out of the stack and subtracts them to put it back in
 * 
 * @param stack is the stack
 * 
 * @return 0 or the error code
 */
int calc_sub(Stack **stack);

/**
 * Pops 2 values out of the stack and multiplies them to put it back in
 * 
 * @param stack is the stack
 * 
 * @return 0 or the error code
 */
int calc_mul(Stack **stack);

/**
 * Pops 2 values out of the stack and divides them to put it back in
 * 
 * @param stack is the stack
 * 
 * @return 0 or the error code
 */
int calc_div(Stack **stack);

/**
 * Pops 2 values out of the stack and applies the modulo to put it back in
 * 
 * @param stack is the stack
 * 
 * @return 0 or the error code
 */
int calc_mod(Stack **stack);

/**
 * Pops 1 value out of the stack and applies its factorial to put it back in
 * 
 * @param stack is the stack
 * 
 * @return 0 or the error code
 */
int calc_fact(Stack **stack);

/**
 * Pops 2 values out of the stack and applies the first to the power of the second to put it back in
 * 
 * @param stack is the stack
 * 
 * @return 0 or the error code
 */
int calc_pow(Stack **stack);

#endif