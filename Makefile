.SUFFIXES: .d
.PHONY: test

all: sample_list test
.d.o:
	dmd -c $^
unittests: expression.d scanner.d parser.d
	dmd -unittest unittests.d $^
sample_list: sample_list.d expression.o scanner.o parser.o
	dmd $^
test: unittests
	./unittests
