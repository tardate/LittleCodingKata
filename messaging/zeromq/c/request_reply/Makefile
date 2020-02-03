TARGETS := client server
OBJECTS=
CFLAGS= -Wall -O3 `pkg-config --cflags libzmq`
LDLIBS=`pkg-config --libs libzmq`
CC=gcc

.PHONY: all
all: $(TARGETS)

$(TARGETS): $(OBJECTS)

.PHONY: clean
clean:
	rm $(TARGETS)
