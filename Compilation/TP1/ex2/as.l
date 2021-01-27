%{
#include "as.tab.h"
%}

%option noinput
%option nounput
%%
b   { return (B); }
a   { return (A); }
[.] { return (STOP); }
[ \t] ;
.   { return (yytext[0]); }
\n ;

%%
