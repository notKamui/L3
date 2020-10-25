INCL    := stack.h parse.h
SRC     := main.c stack.c parse.c
OBJ     := $(SRC:.c=.o)
LIBS    := -lreadline
EXE     := rpcalc

CC      := gcc
CFLAGS  := -ansi -pedantic -Wall -O2
LIBPATH := -L.
LDFLAGS := -o $(EXE) $(LIBPATH) $(LIBS)
RM      := rm -f

%.o: %.c
	$(CC) -c $(CFLAGS) $*.c

$(EXE): $(OBJ)
	$(CC) $(LDFLAGS) $(OBJ)

$(OBJ): $(INCL)

clean:
	$(RM) $(OBJ) $(EXE)