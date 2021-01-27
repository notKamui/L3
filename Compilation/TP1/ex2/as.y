%{
#include <ctype.h>
#include <stdio.h>
#include "Tree.h"
int     yyerror(char *s)
{
    fprintf(stderr, "%s\n", s);
    return (0);
}
int     yylex(void);
%}
%union {
    struct s_tree *node;
}
%token <node> A
%token <node> B
%token <node> STOP
%type <node> L S T
%%
L   :   S STOP   { $$ = make_node('L');
                    $2 = make_node('.');
                    add_child(&$$, $1);
                    add_child(&$$, $2);
                    print_tree($$, 0); }
    ;

S   :   A S     { $$ = make_node('S');
                    $1 = make_node('a');
                    add_child(&$$, $1);
                    add_child(&$$, $2); }
    |   T       { $$ = make_node('S');
                    add_child(&$$, $1); }
    ;

T   :   T A     { $$ = make_node('T');
                    $2 = make_node('a');
                    add_child(&$$, $1);
                    add_child(&$$, $2); }
    |   B       { $$ = make_node('T');
                    $1 = make_node('b');
                    add_child(&$$, $1); }
    ;
%%


int     main(void)
{
    return ((yyparse()) ? 0 : 1);
}
