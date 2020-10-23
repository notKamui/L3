/**
 * Created by Jimmy @notKamui Teillard
 * on 16/10/2020
 */
#include <stdio.h>
#include <stdlib.h>
#include <readline/readline.h>
#include <string.h>

#include "calc.h"

void calc_instruct(Stack **head, char *token) {

}

int *calc_toint(char *token) {
    int *ret;
    int i;

    ret = (int*)malloc(sizeof(int));
    *ret = atoi(token);

    if (*ret == 0) {
        for (i = 0; i < strlen(token); i++) {
            if (token[i] != '0') {
                free(ret);
                return NULL;
            }
        }
    }

    return ret;
}