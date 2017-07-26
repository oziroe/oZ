#
# source/Makefile
#
# Created by oziroe on July 22, 2017.
#

all: main
	cp main oz

syntax_node = $(shell ./syntax.rb names grammer.y)
syntax_generated_folder = synauto
syntax_extension_folder = synexts
syntax_generated_header = syntax.h

main: lexical.o grammer.o $(syntax_node:%=$(syntax_generated_folder)/%.o)
lexical.o: grammer.c
grammer.c: YFLAGS += -d
grammer.o: syntax.rb grammer.c
	test -d $(syntax_generated_folder) || mkdir $(syntax_generated_folder)
	./syntax.rb generate grammer.y $(syntax_generated_folder) $(syntax_extension_folder) $(syntax_generated_header)
	cc    -c grammer.c

.PHONY: clean
clean:
	rm *.o *.tab.h grammer.c main $(syntax_generated_folder)/* $(syntax_generated_header)
