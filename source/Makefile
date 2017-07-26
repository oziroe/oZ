#
# source/Makefile
#
# Created by oziroe on July 22, 2017.
#

all: main
	cp main oz

generated_folder = syntax_auto
extension_folder = syntax_exts
generated_header = syntax.h

node = $(shell ./syntax.rb names grammer.y)
exts = $(shell ls $(extension_folder))

main: lexical.o grammer.o $(node:%=$(generated_folder)/%.o)
lexical.o: grammer.c
grammer.c: YFLAGS += -d
grammer.o: syntax.rb grammer.c $(exts:%=$(extension_folder)/%)
	test -d $(generated_folder) || mkdir $(generated_folder)
	./syntax.rb generate grammer.y $(generated_folder) $(extension_folder) $(generated_header)
	cc    -c grammer.c

.PHONY: clean
clean:
	rm *.o *.tab.h grammer.c main $(generated_folder)/* $(generated_header)
