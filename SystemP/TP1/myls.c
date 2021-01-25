#define _DEFAULT_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>
#include <dirent.h>
#include <time.h>
#include <string.h>

void mylstat(const char *fname) {
    struct stat infos;
    char buf[FILENAME_MAX];

    printf("--- %s ---\n", fname);

    if(lstat(fname, &infos) == -1) {
        perror("stat");
        exit(EXIT_FAILURE);
    }
    printf("Type : ");
    if(S_ISDIR(infos.st_mode)) {
        printf("d\n");
    } else if(S_ISREG(infos.st_mode)) {
        printf("f\n");
    } else if(S_ISLNK(infos.st_mode)) {
        readlink(fname, buf, FILENAME_MAX);
        printf("l (%s -> %s)\n", fname, buf);
    }
    printf("Inode's number : %ld\n", (long) infos.st_ino);
    printf("Size : %ld bytes\n",
            (long) infos.st_size);

    printf("Last modification : %s", ctime(&infos.st_mtime));
}

void myls(const char *fname) {
    struct dirent *reading;
    DIR *dir;
    char dest[FILENAME_MAX];

    dir = opendir(fname);

    while ((reading = readdir(dir))) {
        snprintf(dest, FILENAME_MAX, "%s/%s", fname, reading->d_name);
        mylstat(dest);
        printf("\n");
    }

    closedir(dir);
}

int main(int argc, char const *argv[]) {
    int i;
    struct stat infos;

    if(argc < 2) {
        myls(".");
    } else {
        for (i = 1; i < argc; i++) {
            if(lstat(argv[i], &infos) == -1) {
                perror("stat");
                exit(EXIT_FAILURE);
            }
            if(S_ISDIR(infos.st_mode)) {
                myls(argv[i]);
            } else {
                mylstat(argv[i]);
            }
        }
    }

    return EXIT_SUCCESS;
}