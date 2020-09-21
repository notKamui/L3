%{
/* td1-ex3.lex */
/* Chiffrement par substitution */
%}
%option nounput
%option noinput
%%
a fprintf(yyout, "e");
c fprintf(yyout, "d");
d fprintf(yyout, "c");
e fprintf(yyout, "a");
é fprintf(yyout, "g");
g fprintf(yyout, "e");
i fprintf(yyout, "s");
l fprintf(yyout, "u");
m fprintf(yyout, "p");
n fprintf(yyout, "r");
o fprintf(yyout, "t");
p fprintf(yyout, "m");
r fprintf(yyout, "n");
s fprintf(yyout, "i");
t fprintf(yyout, "o");
u fprintf(yyout, "l");
A fprintf(yyout, "E");
C fprintf(yyout, "D");
D fprintf(yyout, "C");
E fprintf(yyout, "A");
É fprintf(yyout, "G");
G fprintf(yyout, "E");
I fprintf(yyout, "S");
L fprintf(yyout, "U");
M fprintf(yyout, "P");
N fprintf(yyout, "R");
O fprintf(yyout, "T");
P fprintf(yyout, "M");
R fprintf(yyout, "N");
S fprintf(yyout, "I");
T fprintf(yyout, "O");
U fprintf(yyout, "L");
<<EOF>> return 0;
.|\n fprintf(yyout, "%c", yytext[0]);
%%
int main(int argc, char* argv[]) {
    extern FILE *yyin, *yyout;

    yyin = fopen(argv[1], "r");
    yyout = fopen("crypt.txt", "w");
    yylex();
    fclose(yyin);
    fclose(yyout);
    return 0;
}
