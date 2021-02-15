#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/stat.h>

int main(int argc, char **argv) {
    size_t size;
    int fd;
    if (argc != 2) {
        printf("Missing argument, aborting\n");
        return EXIT_FAILURE;
    }

    if((fd = open(argv[1], O_WRONLY | O_CREAT | O_TRUNC, S_IRUSR | S_IWUSR | S_IXUSR | S_IROTH)) == -1) {
        printf("Error while opening file, aborting\n");
        return EXIT_FAILURE;
    }
    dup2(fd, STDOUT_FILENO);
    close(fd);

    printf("zrezrezr\n");

    return EXIT_SUCCESS;
}