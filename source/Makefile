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
grammer.o: syntax.rb grammer.c
	test -d synauto || mkdir synauto
	./syntax.rb grammer.y synauto synext syntax.h
	cc -c grammer.c

.PHONY: clean
clean:
	rm *.o *.tab.h grammer.c main syntax/*.o synauto/* syntax.h
