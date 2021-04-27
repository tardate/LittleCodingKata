SOURCES := $(wildcard *.c)
TARGETS := $(SOURCES:.c=)

OBJECTS=
CFLAGS= -Wall -O3 `pkg-config --cflags libzmq`
LDLIBS=`pkg-config --libs libzmq`
CC=gcc

.PHONY: run
run: $(TARGETS)
	$(foreach target,$(TARGETS),./$(target);)

$(TARGETS): $(OBJECTS)

.PHONY: clean
clean:
	rm -f $(TARGETS) *.o
	rm -fR *.dSYM
