#
# Makefile
#
# Created by oziroe on July 23, 2017.
#

all: source/oz
	mv source/oz .

source/oz:
	cd source && make

.PNONY: clean
clean:
	cd source && make clean
	rm oz
