CC_SDL=`sdl2-config --cflags --libs`
CXXFLAGS = -std=c++17 -Wall -O3 $(CC_SDL)

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
