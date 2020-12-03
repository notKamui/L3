#include <stdio.h>
#include <stdlib.h>
#include<time.h>

#include "code.h"

int compare(const void* a, const void* b) {
    Bitkey _a = *((Bitkey*)a);
    Bitkey _b = *((Bitkey*)b);

    if (fitness_key(&_a) == fitness_key(&_b )) return 0;
    else if (fitness_key(&_a) > fitness_key(&_b)) return -1;
    else return 1;
}

Bitkey mate_keys(Bitkey key1, Bitkey key2, Bitkey key3) {
    int i;
    Bitkey k;

    for (i = 0; i < NB_OCT; i++) {
        k.values[i] = (key1.values[i] & key2.values[i])
                    | (key1.values[i] & key3.values[i])
                    | (key2.values[i] & key3.values[i]);
    }

    return k;
}

Bitkey get_random_key() {
    int i;
    Bitkey key;

    for (i = 0; i < NB_OCT; i++) {
        key.values[i] = rand();
    }

    return key;
}

void get_keygen(Bitkey* k, int d) {
    int i;

    if (d < 0)
        return;

    if (d == 0)
        *k = get_random_key();
    else {
        Bitkey* tab;
        tab = (Bitkey*)malloc(8 * sizeof(Bitkey));

        for (i = 0; i < 8; i++)
            get_keygen(&tab[i], d - 1);

        qsort(tab, NB_OCT, sizeof(Bitkey), compare);

        (*k) = mate_keys(tab[0], tab[1], tab[2]);

        free(tab);
    }
}

int main(void) {
    Bitkey k;
    int i;
    float fitness;
    time_t t;

    srand(time(&t));
    for(i = 0;; i++) {
        printf("Gen %d:\n", i);
        get_keygen(&k, i);
        fitness = fitness_key(&k);
        printf("Fitness : %f\n", fitness);
        enter_the_matrix(&k);
        if (fitness == 100) break;
    }

    return 0;
}