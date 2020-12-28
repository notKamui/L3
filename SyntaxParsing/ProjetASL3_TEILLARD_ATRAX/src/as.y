%{
    #include <stdio.h>
    #include <ctype.h>

    int yylex();
    int yyerror(char *);
    extern int yylineno;
%}
%token CHARACTER
%token NUM
%token IDENT
%token STRUCT
%token TYPE
%token EQ
%token ORDER
%token ADDSUB
%token DIVSTAR
%token OR
%token AND
%token VOID
%token READE
%token READC
%token PRINT
%token IF
%token ELSE
%token WHILE
%token RETURN
%%
Prog:  DeclStructs DeclVars DeclFoncts 
    ;
TypeName:
        STRUCT
    |   TYPE
    ;
DeclVars:
       DeclVars TypeName Declarateurs ';' 
    |
    ;
Declarateurs:
       Declarateurs ',' IDENT 
    |  IDENT 
    ;
DeclStructs:
       DeclStructs STRUCT '{' CorpsStruct '}' ';'
	|
    ;
CorpsStruct:
       CorpsStruct TypeName Declarateurs ';'
	|  TypeName Declarateurs ';'
	;
DeclFoncts:
       DeclFoncts EnTeteFonct '{' DeclVars SuiteInstr '}' 
    |  EnTeteFonct '{' DeclVars SuiteInstr '}' 
    ;
EnTeteFonct:
       TypeName IDENT '(' Parametres ')' 
    |  VOID IDENT '(' Parametres ')' 
    ;
Parametres:
       VOID 
    |  ListTypVar 
    ;
ListTypVar:
       ListTypVar ',' TypeName IDENT 
    |  TypeName IDENT 
    ;
SuiteInstr:
       SuiteInstr Instr 
    |
    ;
Instr:
       IDENT '=' Exp ';'
    |  READE '(' IDENT ')' ';'
    |  READC '(' IDENT ')' ';'
    |  PRINT '(' Exp ')' ';'
    |  IF '(' Exp ')' Instr 
    |  IF '(' Exp ')' Instr ELSE Instr
    |  WHILE '(' Exp ')' Instr
    |  IDENT '(' Arguments  ')' ';'
    |  RETURN Exp ';' 
    |  RETURN ';' 
    |  '{' SuiteInstr '}' 
    |  ';' 
    ;
Exp :  Exp OR TB 
    |  TB 
    ;
TB  :  TB AND FB 
    |  FB 
    ;
FB  :  FB EQ M
    |  M
    ;
M   :  M ORDER E 
    |  E 
    ;
E   :  E ADDSUB T 
    |  T 
    ;    
T   :  T DIVSTAR F 
    |  F 
    ;
F   :  ADDSUB F 
    |  '!' F 
    |  '(' Exp ')' 
    |  NUM 
    |  CHARACTER
    |  IDENT
    |  IDENT '(' Arguments  ')' 
    ;
Arguments:
       ListExp 
    |
    ;
ListExp:
       ListExp ',' Exp 
    |  Exp 
    ;
%%
int yyerror(char *s){
    fprintf(stderr, "%s near line %d\n", s, yylineno);
    return 0;
}