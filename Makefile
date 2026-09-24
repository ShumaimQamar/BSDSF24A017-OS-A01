CC = gcc
CFLAGS = -Wall -Wextra -Iinclude

LIBDIR = lib
OBJDIR = obj
BINDIR = bin

STATIC_LIB = $(LIBDIR)/libmyutils.a
TARGET = $(BINDIR)/client_static

all: directories $(STATIC_LIB) $(TARGET)

directories:
	mkdir -p $(LIBDIR) $(OBJDIR) $(BINDIR)

$(OBJDIR)/mystrfunctions.o: src/mystrfunctions.c
	$(CC) $(CFLAGS) -c src/mystrfunctions.c -o $(OBJDIR)/mystrfunctions.o

$(OBJDIR)/myfilefunctions.o: src/myfilefunctions.c
	$(CC) $(CFLAGS) -c src/myfilefunctions.c -o $(OBJDIR)/myfilefunctions.o

$(OBJDIR)/main.o: src/main.c
	$(CC) $(CFLAGS) -c src/main.c -o $(OBJDIR)/main.o

$(STATIC_LIB): $(OBJDIR)/mystrfunctions.o $(OBJDIR)/myfilefunctions.o
	ar rcs $(STATIC_LIB) $(OBJDIR)/mystrfunctions.o $(OBJDIR)/myfilefunctions.o

$(TARGET): $(OBJDIR)/main.o $(STATIC_LIB)
	$(CC) $(OBJDIR)/main.o -L$(LIBDIR) -lmyutils -o $(TARGET)

clean:
	rm -rf $(OBJDIR) $(LIBDIR) $(BINDIR)

.PHONY: all clean directories
