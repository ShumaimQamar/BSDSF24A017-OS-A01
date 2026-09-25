CC = gcc
CFLAGS = -Wall -Wextra -Iinclude
PICFLAGS = -fPIC

LIBDIR = lib
OBJDIR = obj
BINDIR = bin

DYNAMIC_LIB = $(LIBDIR)/libmyutils.so
TARGET = $(BINDIR)/client_dynamic

all: directories $(DYNAMIC_LIB) $(TARGET)

directories:
	mkdir -p $(LIBDIR) $(OBJDIR) $(BINDIR)

$(OBJDIR)/mystrfunctions.o: src/mystrfunctions.c include/mystrfunctions.h
	$(CC) $(CFLAGS) $(PICFLAGS) -c src/mystrfunctions.c -o $(OBJDIR)/mystrfunctions.o

$(OBJDIR)/myfilefunctions.o: src/myfilefunctions.c include/myfilefunctions.h
	$(CC) $(CFLAGS) $(PICFLAGS) -c src/myfilefunctions.c -o $(OBJDIR)/myfilefunctions.o

$(DYNAMIC_LIB): $(OBJDIR)/mystrfunctions.o $(OBJDIR)/myfilefunctions.o
	$(CC) -shared $(OBJDIR)/mystrfunctions.o $(OBJDIR)/myfilefunctions.o -o $(DYNAMIC_LIB)

$(OBJDIR)/main.o: src/main.c include/mystrfunctions.h include/myfilefunctions.h
	$(CC) $(CFLAGS) -c src/main.c -o $(OBJDIR)/main.o

$(TARGET): $(OBJDIR)/main.o $(DYNAMIC_LIB)
	$(CC) $(OBJDIR)/main.o -L$(LIBDIR) -lmyutils -o $(TARGET)

clean:
	rm -rf $(OBJDIR) $(LIBDIR) $(BINDIR)

.PHONY: all clean directories
