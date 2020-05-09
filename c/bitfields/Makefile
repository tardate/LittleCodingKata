TARGETS := example
OBJECTS=
CFLAGS= -Wall -O0
LDLIBS=
CC=gcc

.PHONY: run
run: all
	./example

.PHONY: all
all: $(TARGETS)

$(TARGETS): $(OBJECTS)

.PHONY: clean
clean:
	rm $(TARGETS)
