TARGETS := example
OBJECTS=
CFLAGS= -Wall -O0 -std=c11
LDLIBS=
CC=gcc-10

.PHONY: run
run: all
	./$(TARGETS)

.PHONY: all
all: $(TARGETS)

$(TARGETS): $(OBJECTS)

.PHONY: clean
clean:
	rm -f $(TARGETS) *.o
	rm -fR *.dSYM
