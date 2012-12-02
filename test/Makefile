SRCDIR=../dsshiki
SRC=$(SRCDIR)/expression.d $(SRCDIR)/scanner.d $(SRCDIR)/parser.d

.SUFFIXES: .d
.PHONY: test

all: test
.d.o:
	dmd -c $^
unittests: unittests.d $(SRC)
	dmd -unittest $^
test: unittests
	./unittests
