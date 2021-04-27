CXXFLAGS = -std=c++17 -Wall -O3

SOURCES := $(wildcard *.cpp)
TARGETS := $(SOURCES:.cpp=)

.PHONY: run
run: all
	$(foreach target,$(TARGETS),./$(target);)

.PHONY: all
all: $(TARGETS)

.PHONY: clean
clean:
	rm -f $(TARGETS) *.o
	rm -fR *.dSYM
