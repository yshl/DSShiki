.SUFFIXES: .d
.PHONY: lib test sample clean

all: lib
.d.o:
	dmd -c $^
lib:
	make -C dsshiki
sample:
	make -C sample
test:
	make -C test

clean:
	make -C dsshiki clean
	make -C sample clean
	make -C test clean
