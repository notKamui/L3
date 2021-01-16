INCL    := $(wildcard *.h)
PLUGINS := $(wildcard plugins/*.c)
C_LIBS  := $(wildcard libs/*.h)
OBJ     := main.o $(INCL:%.h=%.o)
PL_OBJ  := $(PLUGINS:%.c=%.so)
LIBS_OBJ:= $(C_LIBS:%.h=%.a)
LIBS    := -g -lstack -lreadline -ldl -lm
EXE     := eap

CC      := gcc
CFLAGS  := -ansi -pedantic -Wall -O2 -g
LIBPATH := -Ilibs/stack.h -L.
LDFLAGS := -o $(EXE) $(LIBPATH) $(LIBS)
RM      := rm -f

$(EXE): libs plugins $(OBJ)
	$(CC) $(OBJ) $(LDFLAGS)

plugins: $(PL_OBJ)

libs: $(LIBS_OBJ)

%.o: %.c %.h
	$(CC) -c $(CFLAGS) $*.c $*.h

%.so: %.c
	$(CC) -fPIC -c $(CFLAGS) $*.c
	$(CC) -shared $(subst plugins/,,$*.o) -o $*.so $(LIBPATH) $(LIBS)

%.a: %.o
	ar rs lib$(subst libs/,,$*.a) $(subst libs/,,$*.o)

main.o: main.c
	$(CC) -c $(CFLAGS) main.c

clean:
	$(RM) $(OBJ) $(C_LIBS:.h=.h.gch) $(INCL:.h=.h.gch) $(wildcard *.o)

rmproper: clean
	$(RM) lib$(subst libs/,,$(LIBS_OBJ)) $(PL_OBJ) $(EXE)