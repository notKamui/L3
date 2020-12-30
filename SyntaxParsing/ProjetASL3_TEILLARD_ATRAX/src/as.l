%{
    #include <stdio.h>
    #include <string.h>
    #include "as.tab.h"
    char errline[1024];
    int errcharno;
%}
%option nounput
%option noinput
%option yylineno

%x LNCOM BLCOM
ident  [_a-zA-Z][_a-zA-Z0-9]*
%%
"/*"            BEGIN LNCOM;
"//"            BEGIN BLCOM;

<LNCOM>.        errcharno += yyleng;
<LNCOM>\n       errcharno = 1;
<LNCOM>"*/" {
    errcharno = 1;
    BEGIN INITIAL; 
}
<BLCOM>.        errcharno += yyleng;
<BLCOM>\n {
    errcharno = 1;
    BEGIN INITIAL;
}

[0-9]+ {
    yylval = atoi(yytext);
    errcharno += yyleng;
    //printf("%d\n", yyleng);
    return NUM;
}

\'.\' {
    yylval = yytext[1];
    errcharno += yyleng;
    return CHARACTER;
}

"struct" {
    errcharno += yyleng;
	return STRUCT;
}

"int"|"char" {
    errcharno += yyleng;
    return TYPE;
}

"if" {
    errcharno += yyleng;
    return IF;
}

"else" {
    errcharno += yyleng;
    return ELSE;
}

"while" {
    errcharno += yyleng;
    return WHILE;
}

"return" {
    errcharno += yyleng;
    return RETURN;
}

"print" {
    errcharno += yyleng;
    return PRINT;
}

"reade" {
    errcharno += yyleng;
    return READE;
}

"readc" {
    errcharno += yyleng;
    return READC;
}

"or" {
    errcharno += yyleng;
    return OR;
}

"=="|"!=" {
    errcharno += yyleng;
    return EQ;
}

"<"|">"|"<="|">=" {
    return ORDER;
    errcharno += yyleng;
}

"+"|"-" {
    errcharno += yyleng;
    return ADDSUB;
}

"*"|"/"|"%" {
    errcharno += yyleng;
    return DIVSTAR;
}

"||" {
    errcharno += yyleng;
    return OR;
}

"&&" {
    errcharno += yyleng;
    return AND;
}

"void" {
    errcharno += yyleng;
    return VOID;
}

" "|\t  {
    errcharno += yyleng;
}

{ident} {
    errcharno += yyleng;
    return IDENT;
}

^.+/"\n" {
    strcpy(errline, yytext);
    REJECT;
}

\n {
    errcharno = 1;
}

. {
    errcharno += yyleng;
    return yytext[0];
}

<<EOF>> {
    return YYEOF;
}
%%