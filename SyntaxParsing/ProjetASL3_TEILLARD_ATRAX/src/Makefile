as: bin/lex.yy.o bin/as.tab.o
	gcc -o as bin/lex.yy.o bin/as.tab.o -Wall -ly -lfl

bin/lex.yy.o: bin/lex.yy.c bin/as.tab.h
	gcc -o lex.yy.o -c bin/lex.yy.c -Wall -ly -lfl
	@mkdir -p bin/
	@mv lex.yy.o bin/

bin/as.tab.o: bin/as.tab.c bin/as.tab.h
	gcc -o as.tab.o -c bin/as.tab.c -Wall
	@mkdir -p bin/
	@mv as.tab.o bin/

bin/as.tab.c bin/as.tab.h: as.y
	bison -d -v as.y
	@mkdir -p bin/
	@mv as.tab.c as.tab.h as.output bin/

bin/lex.yy.c: as.l
	flex as.l
	@mkdir -p bin/
	@mv lex.yy.c bin/


clean:
	rm -rf as bin