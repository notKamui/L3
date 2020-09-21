%{
/* td1-ex1.lex */
int en_count = 0;
int fr_count = 0;
%}

%option nounput
%option noinput

%%
the|of|and|to|a|his|in|with|I|which     { printf("English "); en_count++; }
de|à|le|la|et|il|les|un|en|du    { printf("Français "); fr_count++; }
[a-zA-ZâàçêéèëîïôûùüœÂÀÇÊÉÈËÎÏÔÛÙÜŒ]+ ;
. ;
<<EOF>>    { if(en_count > fr_count) printf("Plutot anglais"); else if(fr_count > en_count) printf("Plutot francais"); else printf("Franglais"); return 0; }
%%
