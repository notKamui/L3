INCL    := stack.h parse.h calc.h
SRC     := main.c stack.c parse.c calc.c
OBJ     := $(SRC:.c=.o)
LIBS    := -lreadline -lm
EXE     := rpcalc

CC      := gcc
CFLAGS  := -ansi -pedantic -Wall -O2 -g
LIBPATH := -L.
LDFLAGS := -o $(EXE) $(LIBPATH) $(LIBS) -O2 -g
RM      := rm -f

%.o: %.c
	$(CC) -c $(CFLAGS) $*.c

$(EXE): $(OBJ)
	$(CC) $(LDFLAGS) $(OBJ)

$(OBJ): $(INCL)

clean:
	$(RM) $(OBJ) $(EXE)