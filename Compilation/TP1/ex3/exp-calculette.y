%{
#include <stdio.h>
#include <string.h>
#include "Tree.h"
int yylex();
void yyerror(char *);
extern int lineno;
%}
%union {
    int num;
    char comp[3];
    char addsub;
    char divstar;
    struct s_tree *node;
}

%token <num> NUM
%token <comp> EQ
%token <addsub> ADDSUB
%token <divstar> DIVSTAR
%token OR AND
%type <node> L EB TB FB E T F

%%
L   :  EB '.'       { $$ = $1;
                        print_tree($$, 0);
                        free_tree(&$$); }
    ; 
EB  :  EB OR TB     { $$ = make_node($1->num || $3->num, '|'); 
                        add_child(&$$, $1);
                        add_child(&$$, $3); }
    |  TB           { $$ = $1; }
    ;
TB  :  TB AND FB    { $$ = make_node($1->num && $3->num, '&');
                        add_child(&$$, $1);
                        add_child(&$$, $3); }
    |  FB           { $$ = $1; }
    ;
FB  :  E EQ E       { $$ = (!strcmp($2, "==")) ? 
                        make_node($1->num == $3->num, '=') : 
                        make_node($1->num != $3->num, '1');
                        add_child(&$$, $1);
                        add_child(&$$, $3); }
    |  E            { $$ = $1; }
    ;
E   :  E ADDSUB T   { $$ = ($2 == '+') ? make_node($1->num + $3->num, '+') :
                        make_node($1->num - $3->num, '-');
                        add_child(&$$, $1);
                        add_child(&$$, $3); }
    |  T            { $$ = $1; }
    ;    
T   :  T DIVSTAR F  { $$ = ($2 == '*') ? make_node($1->num * $3->num, '*') :
                        make_node($1->num / $3->num, '/');
                        add_child(&$$, $1);
                        add_child(&$$, $3); }
    |  F            { $$ = $1; }
    ;
F   :  ADDSUB F     { $$ = ($1 == '+') ? make_node($2->num, '+') :
                        make_node(- $2->num, '-');
                        add_child(&$$, $2); }
    |  '!' F        { $$ = make_node(!$2->num, '!');
                        add_child(&$$, $2); }
    |  '(' EB ')'   { $$ = $2; }
    |  NUM          { $$ = make_node($1, 0); }
    ;
%%
int main(int argc, char** argv) {
  yyparse();
  return 0;
}
void yyerror(char *s){
  fprintf(stderr, "%s near line %d\n", s, lineno);
}
