#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/stat.h>

int change_input(const char* path) {
    int file_desc;

    file_desc = open(path, O_RDONLY);

    if (file_desc == -1) {
        printf("Error during file opening\n");
        return EXIT_FAILURE;
    }

    if (dup2(file_desc, STDIN_FILENO) == -1) {
        printf("Error during file dup2\n");
        return EXIT_FAILURE;
    }
    return file_desc;
}

int main(int argc, char** argv) {
    int file_desc, w, c , l, in_word;
    char chaar;

    if (argc > 1) {
        file_desc = change_input(argv[1]);
    }

    w = c = l = in_word = 0;
    while (scanf("%c", &chaar) > 0) {
        c++;
        if (chaar == '\n') {
            l++;
            w++;
        } else if (chaar == ' ') {
            w++;
        } else {
            in_word = 1;
        }
    }
    if (w > 0) w++;

    printf("l: %d\tw: %d\tc: %d\n", l, w, c);

    close(file_desc);

    return EXIT_SUCCESS;
}