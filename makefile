# for debugging flex with nf:
#CCFLAGS="-DDEBUG=1"
CCFLAGS=

test:		forth.core forth

forth:		forth.o prims.o
		cc -o forth forth.o prims.o

forth.o:	forth.c common.h forth.h prims.h
		cc -c forth.c

prims.o:	prims.c forth.h prims.h
		cc -c prims.c

all:		forth.core forth l2b b2l

nf:		nf.o lex.yy.o
		cc -o nf nf.o lex.yy.o

nf.o:		nf.c forth.lex.h common.h
		cc $(CCFLAGS) -c nf.c

lex.yy.o:	lex.yy.c forth.lex.h
		cc -c lex.yy.c

lex.yy.c:	forth.lex
		flex -l forth.lex


forth.core:	nf forth.dict
		./nf < forth.dict

# l2b: convert a line file to a block file. Usage: l2b < linefile > blockfile
l2b:		l2b.c
		cc -o l2b l2b.c

# b2l: convert a block file to a line file. Usage: b2l < blockfile > linefile
b2l:		b2l.c
		cc -o b2l b2l.c

clean:		
		rm -f *.o
		touch forth.lex

# forth.line and forth.block are not included here, because you can't tell
# which one is more recent. To make one from the other, use b2l and l2b.
