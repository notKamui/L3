#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include "../include/mytee.h"

int mytee(char* fname) {
    char buf[1];
    FILE* fp = NULL;

    if (fname) {
        fp = fopen(fname, "w+");
        if (!fp) {
            printf("Error : %s could not be opened\n", fname);
            return EXIT_FAILURE;
        }
    }

    while (read(0, buf, sizeof(buf)) > 0) {
        fprintf(stdout, "%c", buf[0]);
        if (fp) fprintf(fp, "%c", buf[0]);

    }

    if (fp) fclose(fp);

    return EXIT_SUCCESS;
}

int main(int argc, char** argv) {
    return mytee(argv[1]);
}

// man printf | ./mytee doc.log | wc -l
