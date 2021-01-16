#define _DEFAULT_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <dirent.h>
#include <dlfcn.h>

#include "pluginloader.h"

/* Checks if the extension of a file is ".so" */
int extIsSO(const struct dirent *entry) {
    const char *ext = entry->d_name + strlen(entry->d_name) - 3;
    if (strcmp(ext, ".so") == 0)
        return 1;
    else
        return 0;
}

int find_plugins(struct dirent ***entries) {
    return scandir("plugins", entries, extIsSO, alphasort);
}

Operator *load_plugins(struct dirent **entries, int amount) {
    int i;
    void *handle;
    evalfn eval;
    int (*arity)();
    char (*symbol)();
    char plugin[256];
    char pluginName[256];

    Operator *operators = (Operator *)malloc(sizeof(Operator) * amount);

    for (i = 0; i < amount; i++) {
        strcpy(plugin, "plugins/");
        strcpy(pluginName, entries[i]->d_name);
        strcat(plugin, pluginName);
        handle = dlopen(plugin, RTLD_NOW|RTLD_GLOBAL);
        if (!handle || dlerror())
            return NULL;
        *(void **)(&eval) = dlsym(handle, "eval");
        if (dlerror())
            return NULL;
        *(void **)(&arity) = dlsym(handle, "arity");
        if (dlerror())
            return NULL;
        *(void **)(&symbol) = dlsym(handle, "symbol");
        if (dlerror())
            return NULL;

        operators[i].eval = eval;
        operators[i].arity = (*arity)();
        operators[i].symbol = (*symbol)();
        operators[i].handle = handle;
    }
    return operators;
}

Operator *receive_operators(int *opsize) {
    int amount, i;
    Operator *operators;
    struct dirent **entries = NULL;

    printf("Auto-loading of plugins...\n");
    amount = find_plugins(&entries);
    if (amount == -1) {
        printf("Error while searching for plugins ; aborting...");
        exit(EXIT_FAILURE);
    }

    printf("Found %d potential plugin(s):\n", amount);
    for (i = 0; i < amount; i++) {
        printf("- %s\n", entries[i]->d_name);
    }

    printf("Loading plugins...\n");
    operators = load_plugins(entries, amount);
    if (operators == NULL) {
        printf("Error while loading plugins ; aborting...");
        exit(EXIT_FAILURE);
    }
    printf("Plugins loaded successfully !\n");

    /* Freeing the entries */
    for (i = 0; i < amount; i++) {
        free(entries[i]);
    }
    free(entries);

    *opsize = amount;
    return operators;
}