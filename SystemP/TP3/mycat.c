#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>

#define SSIZE_MAX 1048576 // 1MiB

int main(int argc, char **argv) {
    int i;
    int fd;
    char buffer[SSIZE_MAX];
    if (argc < 2) {
        printf("Missing argument, aborting\n");
        return EXIT_FAILURE;
    }
    
    for (i = 1; i < argc; i++) {
        if((fd = open(argv[i], O_RDONLY)) == -1) {
            printf("Error while opening file, aborting\n");
            return EXIT_FAILURE;
        }
        read(fd, buffer, SSIZE_MAX);
        printf("%s\n", buffer);
    }

    return EXIT_SUCCESS;
}