#ifndef RPCALC_PLUGINLOADER_H
#define RPCALC_PLUGINLOADER_H

/**
 * Typedef for eval function pointer
 */
typedef int (*evalfn)(int *args);

/**
 * An operator
 */
typedef struct operator {
    evalfn eval;
    int arity;
    char symbol;

    void *handle; /* keeping the handle to close it when not needed anymore */
} Operator;

/**
 * Reads plugins in the plugin folder and extracts the operators
 * 
 * @param opsize is a pointer in which the size of the list will be put
 * 
 * @return the list of operators
 */
Operator *receive_operators(int *opsize);

#endif