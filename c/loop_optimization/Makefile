TARGETS := example1-O0.s example1-O1.s example2-O3.s
OBJECTS=
CFLAGS= -Wall -std=c17 -S
LDLIBS=
CC=gcc

.PHONY: run
run: all
	 tail -n+1 $(TARGETS)

.PHONY: all
all: $(TARGETS)

example1-O0.s: example1.c
	$(CC) $(CFLAGS) -O0 -o example1-O0.s example1.c

example1-O1.s: example1.c
	$(CC) $(CFLAGS) -O1 -o example1-O1.s example1.c

example2-O3.s: example2.c
	$(CC) $(CFLAGS) -O3 -o example2-O3.s example2.c

.PHONY: clean
clean:
	rm $(TARGETS)
