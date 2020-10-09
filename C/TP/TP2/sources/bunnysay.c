#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "../include/bunnysay.h"

/**
 * Draws an ascii bunny with a specified offset
 * 
 * @return void
 * @param offset The offset
 */
void draw_bunny(int offset) {
    int i;
    char wsp[offset];

    // init the offset
    for (i = 0; i < offset; i++) {
        wsp[i] = ' ';
    }

    printf("%s(\\ /)   /\n%s( . .) /\n%sc(\")(\")\n", wsp, wsp, wsp);
}

/**
 * Draws the given string in a bubble
 * 
 * @return void
 * @param string The string
 */
void draw_bubble(char* string) {
    int i;
    int len;

    if (!string) exit(EXIT_FAILURE);

    len = strlen(string);
    if (!len) exit(EXIT_FAILURE);

    char dashes[len];
    for (i = 0; i < len; i++) {
        dashes[i] = '-';
    }

    printf(" -%s-\n< %s >\n -%s-\n", dashes, string, dashes);
}

int main(int argc, char **argv) {
    if (argc != 2) exit(EXIT_FAILURE);

    draw_bubble(argv[1]);
    draw_bunny(strlen(argv[1])/2);
    return EXIT_SUCCESS;
}