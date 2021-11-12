CXXFLAGS = -std=c++17 -Wall -O3
CC = c++

TARGET := libanimals.a
SOURCES := $(wildcard *.cpp)
OBJECTS=$(subst .cpp,.o,$(SOURCES))

.PHONY: all
all: $(TARGET)

$(TARGET): $(OBJECTS)
	ar -rsc $@ $^

.PHONY: clean
clean:
	rm -f $(TARGET) *.o
	rm -fR *.dSYM
