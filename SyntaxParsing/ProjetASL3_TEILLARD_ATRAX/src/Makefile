as: lex.yy.o as.tab.o
	gcc -o as lex.yy.o as.tab.o -Wall -ly -lfl

lex.yy.o: lex.yy.c as.tab.h
	gcc -o lex.yy.o -c lex.yy.c -Wall -ly -lfl

as.tab.o: as.tab.c as.tab.h
	gcc -o as.tab.o -c as.tab.c

as.tab.c as.tab.h: as.y
	bison -d --verbose as.y

lex.yy.c: as.l
	flex as.l


clean:
	rm -f as *.o *.c *.h *.output