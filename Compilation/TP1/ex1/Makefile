CC      =	gcc
CFLAGS  =	-Wall
LDFLAGS =   -Wall -lfl -ly
EXEC    = 	exp-calculette
INC_PATH=	include/
SRC_PATH=	$(find src -type d)
OBJ_PATH=	$(foreach rep, $(SRC), $(rep))

YAC		:=	$(EXEC).y
YSRC	:=	src/yac/$(YAC:.y=).tab.c
YOBJ	:=	$(patsubst src%, obj%, $(YSRC:.c=.o))
YINC	:=	$(patsubst src/yac%, include%, $(YSRC:.c=.h))
YGRA	:=	$(YAC:.y=.dot)
YPDF	:=	$(YAC:.y=.pdf)

LEX		:=	$(EXEC).l
LSRC	=	src/lex/lex.yy.c
LOBJ	=	$(patsubst src%, obj%, $(LSRC:.c=.o))

$(EXEC)		:	$(YOBJ) $(LOBJ)
	$(CC) -o $@ $^ $(LDFLAGS)

$(YPDF)		:	$(YGRA)
	dot -Tpdf -o $@ $<

$(YGRA)		:	$(YAC)
	bison -g -o $@ $<

$(YOBJ)		:	$(YSRC)
	@mkdir -p obj obj/yac
	$(CC) -o $@ -c $< $(CFLAGS) -I $(INC_PATH)

$(LOBJ)		:	$(LSRC) 
	@mkdir -p obj obj/lex
	$(CC) -o $@ -c $< $(CFLAGS) -I $(INC_PATH)

$(LSRC)		:	$(LEX)
	flex -o $@ $<

$(YSRC)		:	$(YAC)
	@mkdir -p $(INC_PATH)
	bison -d -o $@ $<
	@mv $(YSRC:.c=.h) $(INC_PATH)

all		:	$(EXEC)

graph	:	$(YPDF)
	@evince $< &

clean	:
	rm -f $(YSRC) $(YOBJ) $(LSRC) $(LOBJ) $(YINC) $(YPDF) $(YGRA)

mrproper:	clean
	rm -rf obj/ include/ $(EXEC)

re		:	mrproper all
