# COMPILING LOW LEVEL IMAGE PROCESSING FEATURES

image_process.so: image_process.o
	gcc -lm -shared image_process.o -o image_process.so -g

image_process.o: image_process.c
	gcc -c -fPIC image_process.c -o image_process.o -Wall -ansi -O2 -g

clean:
	rm -rf *.so *.o __pycache__
