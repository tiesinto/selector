# selector - dmenu fork
# See LICENSE file for copyright and license details.

include config.mk

SRC = drw.c selector.c util.c
OBJ = $(SRC:.c=.o)

all: selector

.c.o:
	$(CC) -c $(CFLAGS) $<

config.h:
	cp config.def.h $@

$(OBJ): arg.h config.h config.mk drw.h

selector: selector.o drw.o util.o
	$(CC) -o $@ selector.o drw.o util.o $(LDFLAGS)

clean:
	rm -f selector $(OBJ) selector-$(VERSION).tar.gz

dist: clean
	mkdir -p selector-$(VERSION)
	cp Makefile arg.h config.def.h config.mk\
		drw.h util.h $(SRC)\
		selector-$(VERSION)
	tar -cf selector-$(VERSION).tar selector-$(VERSION)
	gzip selector-$(VERSION).tar
	rm -rf selector-$(VERSION)

install: all
	mkdir -p $(DESTDIR)$(PREFIX)/bin
	cp -f selector $(DESTDIR)$(PREFIX)/bin
	chmod 755 $(DESTDIR)$(PREFIX)/bin/selector

uninstall:
	rm -f $(DESTDIR)$(PREFIX)/bin/selector\

.PHONY: all clean dist install uninstall
