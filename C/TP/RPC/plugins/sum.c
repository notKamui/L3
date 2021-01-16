int arity() {
    return 2;
}

char symbol() {
    return '+';
}

int eval(int *args) {
    return args[0] + args[1];
}