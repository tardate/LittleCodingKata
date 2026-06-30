SOURCES := $(wildcard *.c)
TARGETS := $(SOURCES:.c=)

OBJECTS=
CFLAGS= -Wall -O0
LDLIBS=
CC=gcc

.PHONY: all
all: $(TARGETS)

$(TARGETS): $(OBJECTS)

.PHONY: clean
clean:
	rm -f $(TARGETS) *.o
	rm -fR *.dSYM
