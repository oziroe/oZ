#
# source/Makefile
#
# Created by oziroe on July 22, 2017.
#

all: main
	cp main oz

main: lexical.o grammer.o
lexical.o: grammer.c
grammer.c: YFLAGS += -d

.PHONY: clean
clean:
	rm *.o *.tab.h grammer.c main
