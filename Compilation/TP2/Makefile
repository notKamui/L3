CC      = gcc
CFLAGS  = -Wall
LDFLAGS = -Wall -ly -lfl
EXEC    = decl-var

$(EXEC): $(EXEC)-lexer.o $(EXEC).o
	$(CC) -o $@ $^ $(LDFLAGS)

%.o: %.c $(EXEC).h
	$(CC) -c -o $@ $< $(CFLAGS)

$(EXEC)-lexer.c: $(EXEC).l
	flex -o $@ $<

.PHONY: clean
clean:
	rm -f $(EXEC)-lexer.c *.o