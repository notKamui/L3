%{

%}
%%
[a-zA-Z] {
    if(yytext[0] == 90 || yytext[0] == 122) {
        printf("%c", yytext[0]-25);
    } else {
        printf("%c", yytext[0]+1);
    }
}
<<EOF>> return 0;
%%
