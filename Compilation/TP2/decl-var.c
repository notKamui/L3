/* decl-var.c */
/* Traduction descendante récursive des déclarations de variables en C */
/* Compatible avec decl-var.lex */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "decl-var.h"

extern int lineno;  /* from lexical analyser */
int yylex();

int lookahead;
#define MAXSYMBOLS 256
STentry *symbolTable;
int STmax=MAXSYMBOLS; /* maximum size of symbol table */
int STsize=0;         /* size of symbol table */
char yylval[MAXNAME];

int main() {
    int i;
    symbolTable=malloc(STmax*sizeof*symbolTable);
    if (!symbolTable) {
        printf("Run out of memory\n");
        exit(1);
    }
    lookahead=yylex();
    DeclVar();
    for (i = 0; i < STsize; i++) {
        if (symbolTable[i].type == INT)
            printf("Var: int %s\n", symbolTable[i].name);
        else
            printf("Var: float %s\n", symbolTable[i].name);
    }
    free(symbolTable);
    return 0;
}

void check(int token) {
    if (token!=lookahead) {
        syntaxError();
    }
}

void addVar(const char name[], int type){
    int count;
    for (count=0;count<STsize;count++) {
        if (!strcmp(symbolTable[count].name,name)) {
            printf("semantic error, redefinition of variable %s near line %d\n",
            name, lineno);
            return;
        }
    }
    if (++STsize>STmax) {
        printf("too many variables near line %d\n", lineno);
        free(symbolTable);
        exit(1);
    }
    strcpy(symbolTable[STsize-1].name, name);
    symbolTable[STsize-1].type=type;
}
void syntaxError(){
    fprintf(stderr, "syntax error near line %d\n", lineno);
    free(symbolTable);
    exit(1);
}

void DeclVar() {
    int type;
    type = Type();
    Vars(type);
    check(';');
}

int Type() {
    int type = -1;
    if (lookahead == INT) {
        type = INTEGER;
    } else if (lookahead == FLOAT) {
        type = REAL;
    } else {
        syntaxError();
    }
    lookahead=yylex();
    return type;
}

void Vars(int type) {
    check(IDENT);
    addVar(yylval, type);
    lookahead=yylex();
    resteVars(type);
}

void resteVars(int type) {
    if (lookahead == ',') {
        lookahead=yylex();
        check(IDENT);
        addVar(yylval, type);
        lookahead=yylex();
        resteVars(type);
    }
}
