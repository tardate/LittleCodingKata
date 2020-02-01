TARGETS := version
OBJECTS=
CFLAGS= -Wall -O3 `pkg-config --cflags libzmq`
LDLIBS=`pkg-config --libs libzmq`
CC=gcc

.PHONY: run
run: $(TARGETS)
	./version

$(TARGETS): $(OBJECTS)

.PHONY: clean
clean:
	rm $(TARGETS)
