/**
 * Created by Jimmy @notKamui Teillard
 * on 16/10/2020
 */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "parse.h"

int *parse_intornull(char *str) {
    int *ret;
    int i;

    ret = (int*)malloc(sizeof(int));
    *ret = atoi(str);

    if (*ret == 0) {
        for (i = 0; i < strlen(str); i++) {
            if (str[i] != '0') {
                free(ret);
                return NULL;
            }
        }
    }

    return ret;
}