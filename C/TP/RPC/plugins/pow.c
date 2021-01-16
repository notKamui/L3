int arity() {
    return 2;
}

char symbol() {
    return '^';
}

int eval(int *args) {
    int i;
    int res = 1;
    for (i = 0; i < args[1]; i++)
        res *= args[0];
    return res;
}