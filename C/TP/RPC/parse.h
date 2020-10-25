/**
 * Created by Jimmy @notKamui Teillard
 * on 16/10/2020
 *
 * Contains utility functions to parse strings
 */

#ifndef RPCALC_PARSE_H
#define RPCALC_PARSE_H

/**
 * Converts a string to an int or returns NULL
 * 
 * @param str is the token to be converted
 * @return a int* or NULL if the string could not be converted
 */
int *parse_intornull(char *str);

#endif
