CC      := gcc
CCFLAGS := -Wall
LDFLAGS := -ansi

TARGETS:= ex1 ex2 ex3 bunnysay
MAINS  := $(addsuffix .o, $(TARGETS) )
OBJ    := $(MAINS)
DEPS   :=
LIBS   := -lm

.PHONY: all clean

all: $(TARGETS)

clean:
	rm -f $(TARGETS) $(OBJ)

$(OBJ): %.o : ./sources/%.c $(DEPS)
	$(CC) -c -o $@ $< $(CCFLAGS)

$(TARGETS): % : $(filter-out $(MAINS), $(OBJ)) %.o
	$(CC) -o $@ $(LIBS) $^ $(CCFLAGS) $(LDFLAGS)
