CC=gcc
CFLAGS=-ansi -Wall -g -Iinclude
LIBS=-lMLV -lm
EXEC=taquin

$(EXEC):bin/main.o bin/model.o bin/viewctrl.o
	$(CC) -o $@ $^ $(LIBS)

bin/main.o: src/main.c include/model.h include/viewctrl.h
	$(CC) -c $< $(CFLAGS) -o bin/main.o

bin/model.o: src/model.c include/model.h include/viewctrl.h
	$(CC) -c $< $(CFLAGS) -o bin/model.o

bin/viewctrl.o: src/viewctrl.c include/viewctrl.h
	$(CC) -c $< $(CFLAGS) -o bin/viewctrl.o

clean:
	rm -rf bin/*.o

rmproper: clean
	rm -rf $(EXEC)