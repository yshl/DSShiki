DFLAGS=-I../dsshiki
LDFLAGS=-L-L../dsshiki -L-ldsshiki

.SUFFIXES: .d

all: sample_list
.d.o:
	dmd -c $^ $(DFLAGS)

sample_list: sample_list.o
	make -C .. lib
	dmd $^ $(DFLAGS) $(LDFLAGS)
