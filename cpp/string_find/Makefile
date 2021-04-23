CXXFLAGS = -std=c++17 -g -Wall -O3

SOURCES := $(wildcard *.cpp)
TARGETS := $(SOURCES:.cpp=)

.PHONY: run
run: all
	./example

.PHONY: all
all: $(TARGETS)

.PHONY: clean
clean:
	rm -f $(TARGETS) *.o
	rm -fR *.dSYM
