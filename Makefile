CC=gcc
CFLAGS=-c -Wall -DROBOTS
LDFLAGS=
LIBS=-lm -lpthread
INC=-Iutil

BINDIR=bin
OBJDIR=obj

UTIL_SRCDIR=util
UTIL_OBJDIR=$(OBJDIR)/utilobj
UTIL_SOURCES=$(wildcard $(UTIL_SRCDIR)/*.c)
UTIL_OBJECTS=$(patsubst $(UTIL_SRCDIR)/%.c,$(UTIL_OBJDIR)/%.o,$(UTIL_SOURCES))

COMPILER_SRCDIR=RuC
COMPILER_OBJDIR=$(OBJDIR)/rucobj
COMPILER_SOURCES=$(wildcard $(COMPILER_SRCDIR)/*.c)
COMPILER_OBJECTS=$(patsubst $(COMPILER_SRCDIR)/%.c,$(COMPILER_OBJDIR)/%.o,$(COMPILER_SOURCES))
RUC_COMPILER=ruc

VM_SRCDIR = RuCVM
VM_OBJDIR=$(OBJDIR)/vmobj
VM_SOURCES=$(wildcard $(VM_SRCDIR)/*.c)
VM_OBJECTS=$(patsubst $(VM_SRCDIR)/%.c,$(VM_OBJDIR)/%.o,$(VM_SOURCES))
RUC_VM=rucvm

all: $(RUC_COMPILER) $(RUC_VM)

$(RUC_COMPILER): $(COMPILER_OBJECTS) $(UTIL_OBJECTS)
	mkdir -p $(BINDIR)
	$(CC) -g $(LDFLAGS) $(COMPILER_OBJECTS) $(UTIL_OBJECTS) -o $(BINDIR)/$@ $(LIBS)

$(RUC_VM): $(VM_OBJECTS) $(UTIL_OBJECTS)
	mkdir -p $(BINDIR)
	$(CC) $(LDFLAGS) $(VM_OBJECTS) $(UTIL_OBJECTS) -o $(BINDIR)/$@ $(LIBS)

$(COMPILER_OBJECTS): $(COMPILER_OBJDIR)/%.o: $(COMPILER_SRCDIR)/%.c
	mkdir -p $(COMPILER_OBJDIR)
	$(CC) -g $(INC) $(CFLAGS) -o $@ $^

$(UTIL_OBJECTS): $(UTIL_OBJDIR)/%.o: $(UTIL_SRCDIR)/%.c
	mkdir -p $(UTIL_OBJDIR)
	$(CC) -g $(INC) $(CFLAGS) -o $@ $^

$(VM_OBJECTS): $(VM_OBJDIR)/%.o: $(VM_SRCDIR)/%.c
	mkdir -p $(VM_OBJDIR)
	$(CC) $(INC) $(CFLAGS) -o $@ $^
