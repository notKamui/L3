%{
    #include "as.tab.h"
%}
%option nounput
%option noinput
%option yylineno
%x LNCOM BLCOM
ident  [_a-zA-Z][_a-zA-Z0-9]*
%%
<LNCOM>\n BEGIN INITIAL;
<BLCOM>\*\/ BEGIN INITIAL;
<LNCOM,BLCOM>.|\n ;
\/\/ BEGIN LNCOM;
\/\* BEGIN BLCOM;

[0-9]+ {
    yylval = atoi(yytext);
    return NUM;
}

\'.\' {
    yylval = yytext[1];
    return CHARACTER;
}

"struct "{ident} {
	return STRUCT;
}

"int"|"char" {
    return TYPE;
}

"if" {
    return IF;
}

"else" {
    return ELSE;
}

"while" {
    return WHILE;
}

"return" {
    return RETURN;
}

"print" {
    return PRINT;
}

"reade" {
    return READE;
}

"readc" {
    return READC;
}

"or" {
    return OR;
}

"=="|"!=" {
    return EQ;
}

"<"|">"|"<="|">=" {
    return ORDER;
}

"+"|"-" {
    return ADDSUB;
}

"*"|"/"|"%" {
    return DIVSTAR;
}

"||" {
    return OR;
}

"&&" {
    return AND;
}

"void" {
    return VOID;
}

{ident} {
    return IDENT;
}

[ \t\n] ;

. {
    return yytext[0];
}

<<EOF>> {
    return EOF;
}
%%