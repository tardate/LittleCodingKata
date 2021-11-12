CXXFLAGS = -std=c++17 -Wall -O3 -I./lcklib/include
LDFLAGS = -L./lcklib -lanimals
CC = c++

TARGET := demo
SOURCES := $(wildcard *.cpp)
OBJECTS=$(subst .cpp,.o,$(SOURCES))

.PHONY: run
run: all
	./$(TARGET)

.PHONY: all
all: $(TARGET)

$(TARGET): $(OBJECTS)

.PHONY: clean
clean:
	rm -f $(TARGET) *.o
	rm -fR *.dSYM
