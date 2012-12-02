SRCDIR=../dsshiki
SRC=$(SRCDIR)/expression.d $(SRCDIR)/scanner.d $(SRCDIR)/parser.d
EXE=unittests

.SUFFIXES: .d
.PHONY: test clean

all: test
.d.o:
	dmd -c $^
unittests: unittests.d $(SRC)
	dmd -unittest $^
test: $(EXE)
	./$(EXE)

clean:
	rm -f $(EXE)
