OBJ=expression.o scanner.o parser.o
.SUFFIXES: .d
.PHONY:

all: dsshiki.a
.d.o:
	dmd -c $^
expression.o: expression.d
scanner.o: scanner.d
parser.o: parser.d

dsshiki.a: $(OBJ)
	dmd -fPIC -of$@ -lib $^
