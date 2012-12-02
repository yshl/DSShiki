.SUFFIXES: .d
.PHONY: lib test sample

all: lib
.d.o:
	dmd -c $^
lib:
	make -C dsshiki
sample:
	make -C sample
test:
	make -C test
