#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <ctype.h>
#include <string.h>
#include <signal.h>

int main(int argc, char **argv)
{
    int addout[2], addin[2], subout[2], subin[2], mulout[2], mulin[2];
    char command[BUFSIZ], a[BUFSIZ], b[BUFSIZ], buffer[BUFSIZ];
    pid_t pidAdd, pidSub, pidMul;
    int i;

    if (pipe(addout) == -1)
    {
        {
            perror("pipe failed");
            return EXIT_FAILURE;
        }
    }

    if (pipe(addin) == -1)
    {
        {
            perror("pipe failed");
            return EXIT_FAILURE;
        }
    }

    if (pipe(subout) == -1)
    {
        {
            perror("pipe failed");
            return EXIT_FAILURE;
        }
    }

    if (pipe(subin) == -1)
    {
        {
            perror("pipe failed");
            return EXIT_FAILURE;
        }
    }

    if (pipe(mulout) == -1)
    {
        {
            perror("pipe failed");
            return EXIT_FAILURE;
        }
    }

    if (pipe(mulin) == -1)
    {
        {
            perror("pipe failed");
            return EXIT_FAILURE;
        }
    }

    // add
    pidAdd = fork();
    if (pidAdd < 0)
    {
        perror("fork error");
        return EXIT_FAILURE;
    }
    else if (pidAdd == 0)
    {
        close(addout[0]);
        close(addin[1]);
        dup2(addout[1], STDIN_FILENO);
        dup2(addin[0], STDOUT_FILENO);
        execv("./addition", NULL);
    }

    // sub
    if (pidAdd > 0)
    {
        pidSub = fork();
        if (pidSub < 0)
        {
            perror("fork error");
            return EXIT_FAILURE;
        }
        else if (pidSub == 0)
        {
            close(subout[0]);
            close(subin[1]);
            dup2(subout[1], STDIN_FILENO);
            dup2(subin[0], STDOUT_FILENO);
            execv("./soustraction", NULL);
        }
    }

    // mul
    if (pidAdd > 0 && pidSub > 0)
    {
        pidMul = fork();
        if (pidMul < 0)
        {
            perror("fork error");
            return EXIT_FAILURE;
        }
        else if (pidMul == 0)
        {
            close(mulout[0]);
            close(mulin[1]);
            dup2(mulout[1], STDIN_FILENO);
            dup2(mulin[0], STDOUT_FILENO);
            execv("./multiplication", NULL);
        }
    }

    if (pidAdd > 0 && pidSub > 0 && pidMul > 0)
    {
        close(addout[1]);
        close(addin[0]);
        close(subout[1]);
        close(subin[0]);
        close(mulout[1]);
        close(mulin[0]);
        while (1)
        {
            scanf("%s %s %s", command, a, b);
            if (strcmp(command, "stop") == 0)
            {
                break;
            }

            if (strcmp(command, "add") == 0)
            {
                write(addout[0], a, BUFSIZ);
                write(addout[0], b, BUFSIZ);
                read(addin[1], buffer, BUFSIZ);
                printf("%s\n", buffer);
            }
            else if (strcmp(command, "sub") == 0)
            {
                write(subout[0], a, BUFSIZ);
                write(subout[0], b, BUFSIZ);
                read(subin[1], buffer, BUFSIZ);
                printf("%s\n", buffer);
            }
            else if (strcmp(command, "mul") == 0)
            {
                write(mulout[0], a, BUFSIZ);
                write(mulout[0], b, BUFSIZ);
                read(mulin[1], buffer, BUFSIZ);
                printf("%s\n", buffer);
            }
        }
        kill(pidAdd, 9);
        kill(pidSub, 9);
        kill(pidSub, 9);
        close(addout[0]);
        close(addin[1]);
        close(subout[0]);
        close(subin[1]);
        close(mulout[0]);
        close(mulin[1]);
    }

    return EXIT_SUCCESS;
}
