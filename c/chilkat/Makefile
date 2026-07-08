SOURCES := $(wildcard *.c)
TARGETS := $(SOURCES:.c=)
OBJECTS := $(SOURCES:.c=.o)

CHILKAT_DIR  = ./chilkat-macosx-cpp

CC           = gcc
CXX          = g++
CFLAGS       = -Wall -O0 -I$(CHILKAT_DIR)/include
LDFLAGS      = -L$(CHILKAT_DIR)/libStatic -lchilkat \
               -lpthread -lresolv -ldl \
               -framework CoreFoundation -framework Security

.PHONY: all
all: $(TARGETS)

$(TARGETS): $(OBJECTS)
	$(CXX) $< $(LDFLAGS) -o $@

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

.PHONY: clean
clean:
	rm -f $(TARGETS) *.o
	rm -fR *.dSYM
