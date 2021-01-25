#define _DEFAULT_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>
#include <time.h>

void watchdog(const char *file) {
    struct stat infos;
    long init_time;

    if(lstat(file, &infos) == -1) {
        perror("stat");
        exit(EXIT_FAILURE);
    }

    init_time = infos.st_mtime;
    while (1) {
        if(lstat(file, &infos) == -1) {
            perror("stat");
            exit(EXIT_FAILURE);
        }

        if (init_time != infos.st_mtime) {
            printf("File modified %s\n", ctime(&infos.st_mtime));
            return;
        }
        usleep(1000); 
    }
}

int main(int argc, char const *argv[]) {
    if(argc < 2) {
        fprintf(stderr, "Missing argument : filename\n");
        exit(EXIT_FAILURE);
    }

    watchdog(argv[1]);

    return EXIT_SUCCESS;
}