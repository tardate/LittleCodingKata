TARGETS := erf erf_gsl
OBJECTS=
CFLAGS= -Wall -O3 -std=gnu11
LDLIBS=
CC=gcc

.PHONY: run
run: all
	./erf
	./erf_gsl

.PHONY: all
all: $(TARGETS)

$(TARGETS): $(OBJECTS)

erf: LDLIBS= -lm

erf_gsl: LDLIBS=`pkg-config --libs gsl`

.PHONY: clean
clean:
	rm $(TARGETS)
