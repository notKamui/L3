#include <stdio.h>
#include <stdlib.h>

int main(int argc, char **argv)
{
    int a;
    int b;

    while (1)
    {
        scanf("%d\n%d\n", &a, &b);
        printf("%d\n", a - b);
    }

    return EXIT_SUCCESS;
}