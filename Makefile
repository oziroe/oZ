#
# Makefile
#
# Created by oziroe on July 22, 2017.
#
all: source/main
	mv source/main oz

source/main: source/lexical.o

.PHONY: clean
clean:
	rm source/*.o oz
