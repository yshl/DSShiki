OBJ=expression.o scanner.o parser.o
LIBS=libdsshiki.a

.SUFFIXES: .d
.PHONY: clean

all: $(LIBS)
.d.o:
	dmd -c $^
expression.o: expression.d
scanner.o: scanner.d
parser.o: parser.d

libdsshiki.a: $(OBJ)
	dmd -fPIC -of$@ -lib $^

clean:
	rm -f $(OBJ) $(LIBS)
