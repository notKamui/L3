int arity() {
    return 1;
}

char symbol() {
    return '!';
}

int fact(int i) {
    if (i < 0) return i;
    else if (i == 0 || i == 1) return 1;
    else return i * fact(i-1);
}

int eval(int *args) {
    return fact(args[0]);
}