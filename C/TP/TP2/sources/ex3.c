#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "../include/ex3.h"

/**
 * Mirrors a given string.
 * 
 * @return void
 * @param string ; the string to mirror
 */
void mirror_string(char* string) {
    int len;
    int i;
    char temp;

    if (!string) exit(EXIT_FAILURE);

    len = strlen(string);
    if (len == 0) exit(EXIT_FAILURE);
    
    for (i = 0; i < len/2.; i++) {
        temp = string[i];
        string[i] = string[len-1-i];
        string[len-1-i] = temp;
    }
}

int main(int argc, char** argv) {
    char* string;

    if (argc != 2) exit(EXIT_FAILURE);

    string = argv[1];
    mirror_string(string);
    printf("%s\n", string);
    
    return EXIT_SUCCESS;
}