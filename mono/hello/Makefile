PROGNAME = hello

all: $(PROGNAME).exe

%.exe: %.cs
	mcs $?

run:
	mono $(PROGNAME).exe

clean:
	rm $(PROGNAME).exe
