TARGETS := erf erf_gsl
OBJECTS=
CFLAGS= -Wall -O3 -std=gnu11
LDLIBS=
CC=gcc

.PHONY: run
run: all
	$(foreach target,$(TARGETS),./$(target);)

.PHONY: all
all: $(TARGETS)

$(TARGETS): $(OBJECTS)

erf: LDLIBS= -lm

erf_gsl: LDLIBS=`pkg-config --libs gsl`

.PHONY: clean
clean:
	rm -f $(TARGETS) *.o
	rm -fR *.dSYM
