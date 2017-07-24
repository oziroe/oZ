#
# source/Makefile
#
# Created by oziroe on July 22, 2017.
#

all: main
	cp main oz

syntax_node = expression4 expression3

main: lexical.o grammer.o $(syntax_node:%=syntax/%.o)
lexical.o: grammer.c
grammer.c: YFLAGS += -d

.PHONY: clean
clean:
	rm *.o *.tab.h grammer.c main syntax/*.o
