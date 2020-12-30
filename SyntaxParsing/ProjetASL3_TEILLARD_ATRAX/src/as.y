%{
    #include <stdio.h>
    #include <ctype.h>

    int yylex();
    int yyerror(char *);
    extern int yylineno;
    extern int yyleng;
    extern char errline[1024];
    extern int errcharno;
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
Prog:  
        Globals DeclFoncts 
    ;
TypeName:
        STRUCT IDENT
    |   TYPE
    ;
Globals:
       Globals Declarateurs ';' 
    |  Globals STRUCT IDENT '{' CorpsStruct '}' ';'
    |
    ;
DeclVars:
       DeclVars Declarateurs ';'
    |
    ;
Declarateurs:
       Declarateurs ',' IDENT 
    |  TypeName IDENT 
    ;
CorpsStruct:
       CorpsStruct Declarateurs ';'
	|  Declarateurs ';'
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
       SuiteInstr EntreeInstr
    |
    ;
EntreeInstr:
        OpenInstr
    |   CloseInstr
    ;
OpenInstr:
        IF '(' Exp ')' EntreeInstr
    |   IF '(' Exp ')' CloseInstr ELSE OpenInstr
    |   WHILE '(' Exp ')' OpenInstr
    ;
CloseInstr:
        Instr
    |   IF '(' Exp ')' CloseInstr ELSE CloseInstr
    |   WHILE '(' Exp ')' CloseInstr
    ;
Instr:
       IDENT '=' Exp ';'
    |  READE '(' IDENT ')' ';'
    |  READC '(' IDENT ')' ';'
    |  PRINT '(' Exp ')' ';'
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
    int i;
    fprintf(stderr, "%s near line %d at char %d\n%s\n", s, yylineno, errcharno-yyleng, errline);
    for (i = 1; i < errcharno-yyleng; i++) {
        fprintf(stderr, " ");
    }
    fprintf(stderr, "^\n");
    return 0;
}