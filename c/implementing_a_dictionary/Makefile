TARGETS := dict_use dict_test
CFLAGS = -g -Wall -Wno-deprecated-declarations -O3 `pkg-config --cflags glib-2.0`
LDLIBS  = `pkg-config --libs glib-2.0`

.PHONY: all
all: $(TARGETS)

dict_test: dict.o keyval.o

dict_use: dict.o keyval.o

.PHONY: clean
clean:
	rm *.o
	rm -fR *.dSYM
	rm $(TARGETS)
