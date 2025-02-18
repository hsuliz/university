CC=g++
CFLAGS=-c -Wall

all: zad1

zad1: main.o insertSort.o
	$(CC) main.o insertSort.o -o zad1

main.o: main.cpp
	$(CC) $(CFLAGS) main.cpp

insertSort.o: insertSort.cpp
	$(CC) $(CFLAGS) insertSort.cpp insertSort.h
