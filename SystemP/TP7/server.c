#include <sys/socket.h>
#include <sys/ioctl.h>
#include <netinet/in.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int create_socket(struct sockaddr *sa)
{
    int sc = socket(AF_INET, SOCK_STREAM, 0);
    int err = bind(sc, sa, sizeof(*sa));
    if (err == -1)
    {
        fprintf(stderr, "bind\n");
        return -1;
    }
    err = listen(sc, SOMAXCONN);
    if (err < 0)
    {
        fprintf(stderr, "listen\n");
        return -1;
    }
    return sc;
}

int create_connection(int ssocket, struct sockaddr *sa)
{
    int s = sizeof(struct sockaddr);
    int sc = accept(ssocket, sa, (socklen_t *)&s);

    if (sc == -1)
    {
        return -1;
    }
    else
    {
        fprintf(stdout, "Connection successful\nSocket: %d\n", sc);
    }

    return sc;
}

char *listen_request(int socket)
{
    char *request = calloc(1024, sizeof(char));
    int len = 0;
    ioctl(socket, FIONREAD, &len);
    if (len > 0)
    {
        len = read(socket, request, len);
    }
    if (len < 0)
    {
        fprintf(stderr, "Failed to listen to request");
        return NULL;
    }
    return request;
}

int main()
{
    struct sockaddr_in sa;
    sa.sin_family = AF_INET;
    sa.sin_port = 8080;
    sa.sin_addr.s_addr = INADDR_ANY;

    int ssocket = create_socket((struct sockaddr *)&sa);
    int sz = sizeof(sa);

    getsockname(ssocket, (struct sockaddr *)&sa, &sz);
    printf("PORT: %d\n", ntohs(sa.sin_port));

    int csocket;
    int *newsock;

    while (csocket = create_connection(ssocket, (struct sockaddr *)&sa))
    {
        printf("%s\n", listen_request(csocket));
    }

    if (csocket < 0)
    {
        fprintf(stderr, "Connection refused\n");
        exit(EXIT_FAILURE);
    }

    return 0;
}