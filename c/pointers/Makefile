TARGETS := demo
OBJECTS=
CFLAGS= -Wall -O0
LDLIBS=
CC=gcc

.PHONY: run
run: all
	./demo

.PHONY: all
all: $(TARGETS)

$(TARGETS): $(OBJECTS)

.PHONY: clean
clean:
	rm $(TARGETS)
