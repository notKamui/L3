#define _DEFAULT_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>
#include <dirent.h>
#include <time.h>
#include <string.h>
#include <getopt.h>

#define MAX_BUFFER_SIZE 256

/* Get the type of the file : 
 * "f" : simple file
 * "d" : directory
 * ...
*/ 
char *getType(const char* fname){
    char buf[FILENAME_MAX];
    struct stat infos;

    if(lstat(fname, &infos) == -1) {
        perror("stat");
        exit(EXIT_SUCCESS);
    }
    if(S_ISDIR(infos.st_mode)) {
        return "d";
    } else if(S_ISREG(infos.st_mode)) {
        return "f";
    }
}

/**
 * ls like : display all the informations of the current directory 
 */
char** dir_info(char *dname){
    char* infos[FILENAME_MAX];
    int i = 0;
    struct dirent *reading;
    DIR *dir;
    dir = opendir(dname);

    while ((reading = readdir(dir))) {
        infos[i] = reading->d_name;
        i++;
    }
    closedir(dir);
    return infos;
}


/* 
 * Parse the file and display the informations using recursivity when there is a directory.
*/
void browseInfo(char *listFile[FILENAME_MAX], char val){
    char **subFile;
    int i = 0;
    while(listFile[i] != NULL){
        if(val == 'R' && strcmp(getType(listFile[i]), "d") == 0){
            subFile = dir_info(listFile[i]);
            browseInfo(subFile, val);
        }
        i++;
    }
}

/**
 * "ls -R" like.
 * 
 * TODO : conditions :
 * - no args = browseInfo of ".".
 * - args = browseInfo of all the arguments.
 * - if the arg is a file : ex2 like.
 */
int bigLs(int argc, char *argv[], char val){
    char listFile[FILENAME_MAX][FILENAME_MAX]; /* To store the names names of the files of the directory */
    char *type;
}



void mylstat(const char *fname) {
    struct stat infos;
    char buf[FILENAME_MAX];

    printf("%s", fname);

    /*if(lstat(fname, &infos) == -1) {
        perror("stat");
        exit(EXIT_SUCCESS);
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
    printf("Size : %lld bytes\n",
            (long long) infos.st_size);

    printf("Last modification : %s", ctime(&infos.st_mtime));*/
}

void myls(const char *fname) {
    struct dirent *reading;
    DIR *dir;
    char dest[FILENAME_MAX];

    dir = opendir(fname);

    while ((reading = readdir(dir))) {
        snprintf(dest, FILENAME_MAX * 2 + 1, "%s/%s", fname, reading->d_name);
        mylstat(dest);
        printf("\n");
    }

    closedir(dir);
}


/**
 * Just a program about how to use "getopt" 
 */
int main(int argc, char * argv[]) {
    const char * optstring = ":hi:o::";
    int val;
    int i;
    struct stat infos;

    if(argc < 2) {
        myls(".");
    } else {
        for (i = 1; i < argc; i++) {
            if(lstat(argv[i], &infos) == -1) {
                perror("stat");
                exit(EXIT_SUCCESS);
            }
            if(S_ISDIR(infos.st_mode)) {
                myls(argv[i]);
            } else {
                mylstat(argv[i]);
            }
        }
    }
    while (EOF != (val = getopt(argc,argv,optstring))) {
        printf("optind = %d \n", optind);
        printf("optarg = %s \n", optarg);
        switch (val) {
            case 'h':
                printf("help\n"); break;
            case 'o':
                printf("output %s\n",optarg); break;
            case 'i':
                printf("input %s\n",optarg); break;
            case ':':
                printf("arg missing for option %c\n",optopt); break;
            case '?':
                printf("unknown option %c\n",optopt); break;
            default:
                printf("default : unknown option %c\n",optopt); break;
        }
    }
    return 0;
}
