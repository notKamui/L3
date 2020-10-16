CC      := gcc
CCFLAGS := -Wall
LDFLAGS := -ansi

TARGETS:= mytee binom lcm
MAINS  := $(addsuffix .o, $(TARGETS))
OBJ    := $(MAINS)
DEPS   :=

.PHONY: all clean

all: $(TARGETS)

clean:
	rm -f $(TARGETS) $(OBJ)

$(OBJ): %.o : ./sources/%.c $(DEPS)
	$(CC) -c -o $@ $< $(CCFLAGS)

$(TARGETS): % : $(filter-out $(MAINS), $(OBJ)) %.o
	$(CC) -o $@ $(LIBS) $^ $(CCFLAGS) $(LDFLAGS)
