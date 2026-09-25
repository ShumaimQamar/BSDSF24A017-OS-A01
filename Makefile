CC = gcc
CFLAGS = -Wall -Wextra -Iinclude

# The first target is the default target when you run 'make'
all: client

# Rule to compile the client executable
client: src/main.c src/mystrfunctions.c src/myfilefunctions.c
	$(CC) $(CFLAGS) $^ -o client

# Installation paths
PREFIX ?= /usr/local
BINDIR = $(PREFIX)/bin
MANDIR = $(PREFIX)/share/man/man1

.PHONY: all install

install: client
	install -d $(DESTDIR)$(BINDIR)
	install -d $(DESTDIR)$(MANDIR)
	install -m 755 client $(DESTDIR)$(BINDIR)/client
	install -m 644 man/man3/*.1 $(DESTDIR)$(MANDIR)/
