CXXFLAGS = -std=c++17 -g -Wall -O3

TARGET = fractal.exe
SOURCES = $(wildcard *.cpp)
OBJS = $(SOURCES:.cpp=.o)

.PHONY: all
all: $(TARGET)

.PHONY: run
run: all
	./$(TARGET)

%.exe: $(OBJS)
	$(LINK.cpp) $^ $(LDLIBS) -o $@

.SUFFIXES: .exe

.PHONY: clean
clean:
	rm -f $(TARGET) $(OBJS)
	rm -fR *.dSYM
