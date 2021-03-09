#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <unistd.h>
#include <sys/wait.h>
#include <string.h>
#include <signal.h>

void children()
{
    int i;
    pid_t pid;
    char msg[100];

    printf("mon PID est %d", getpid());

    sprintf(msg, "my PID is %d", getpid());
    write(STDOUT_FILENO, msg, strlen(msg));

    pid = fork();
    switch (pid)
    {
    case -1:
        exit(EXIT_FAILURE);
    case 0:
        printf("je suis le fils et mon PID est %d", getpid());

        sprintf(msg, "i am the child process and my PID is %d", getpid());
        write(STDOUT_FILENO, msg, strlen(msg));
        break;
    default:
        printf("je suis le père et mon PID est %d", getpid());

        sprintf(msg, "i am the parent process and my PID is %d", getpid());
        write(STDOUT_FILENO, msg, strlen(msg));
        break;
    }

    puts("");
}

int main(int argc, char **argv)
{
    children();
    return EXIT_SUCCESS;
}