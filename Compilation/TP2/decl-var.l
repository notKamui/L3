%{
/* decl-var.l */
#include "string.h"
#include "decl-var.h"
int lineno=1;
%}
%option noinput nounput noyywrap
%x COMMENT
%%
[ \t\r]+                ;
\n                      lineno++;
"/*"                    { BEGIN COMMENT;}
int                     { return INT;}
float                   { return FLOAT;}
[a-zA-Z_][a-zA-Z0-9_]*  { strncpy(yylval,yytext,MAXNAME); return IDENT; }
.                       { return yytext[0];}
<COMMENT>"*/"      { BEGIN INITIAL;}
<COMMENT>.         ;
<COMMENT>\n        lineno++;
%%