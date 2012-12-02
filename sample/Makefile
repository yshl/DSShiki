LIB=../dsshiki/dsshiki.a

.SUFFIXES: .d

all: sample_list
.d.o:
	dmd -c $^

$(LIB):
	make -C .. lib
sample_list: sample_list.o $(LIB)
	dmd $^ $(LIB)
