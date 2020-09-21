%{

%}
%%
[a-zA-Z]{5,} printf("%s ", yytext);
. ;
<<EOF>> return 0;
%%
