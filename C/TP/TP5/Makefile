CC=gcc
CFLAGS=-ansi -Wall -g -I.
LIBS=
EXEC=piercer

$(EXEC): key.o code.o
	$(CC) -o $@ $^ $(LIBS)

key.o: key.c code.h
	$(CC) -c $< $(CFLAGS) -o key.o

clean:
	rm -f key.o piercer