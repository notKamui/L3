#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <ctype.h>
#include <string.h>
#include <signal.h>

int end = 0;

void on_baby_death()
{
    end = 1;
}

int main(int argc, char **argv)
{
    pid_t pid;
    char buf[BUFSIZ];
    int fd[2];
    int i;
    int currsize = 0;

    signal(17, on_baby_death);

    if (pipe(fd) == -1)
    {
        perror("pipe failed");
        return EXIT_FAILURE;
    }

    pid = fork();
    switch (pid)
    {
    case -1:
        perror("fork error");
        return EXIT_FAILURE;
    case 0:
        close(fd[1]);
        while (currsize < 10)
        {
            read(fd[0], buf, BUFSIZ);
            currsize += strlen(buf);
            for (i = 0; buf[i]; i++)
            {
                printf("%c", toupper(buf[i]));
            }
            printf("\n");
        }
        close(fd[0]);
        exit(EXIT_SUCCESS);
    default:
        close(fd[0]);
        while (!end)
        {
            scanf("%s", buf);
            write(fd[1], buf, BUFSIZ);
        }
        close(fd[1]);
    }

    return EXIT_SUCCESS;
}