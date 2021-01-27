%{
#include "exp-calculette.tab.h"
int lineno=1;
%}
%option noinput nounput noyywrap
%x COMMENT
%%
[ \t\r]+                ;
\n                      lineno++;
"/*"                    { BEGIN COMMENT;}
"&&"                    { return AND; }
"||"                    { return OR; }
"*"|"/"|"%"             { yylval.divstar=yytext[0]; return DIVSTAR; }
"+"|"-"                 { yylval.addsub=yytext[0]; return ADDSUB; }
"=="|"!="               { strcpy(yylval.comp, yytext); return EQ; }
[0-9]+                  { sscanf(yytext, "%d", &(yylval.num)); return NUM; }
.                       { return yytext[0];}
<COMMENT>"*/"           { BEGIN INITIAL;}
<COMMENT>.              ;
<COMMENT>\n             lineno++;
%%
