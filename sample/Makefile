DFLAGS=-I../dsshiki
LDFLAGS=-L-L../dsshiki -L-ldsshiki
OBJS=sample_list.o
EXES=sample_list

.SUFFIXES: .d
.PHONY: clean

all: $(EXES)
.d.o:
	dmd -c $^ $(DFLAGS)

sample_list: sample_list.o
	make -C .. lib
	dmd $^ $(DFLAGS) $(LDFLAGS)

clean:
	rm -f $(OBJS) $(EXES)
