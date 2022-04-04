OBJS	= main.o
SOURCE	= main.c
OUT	= server
CC	 = gcc
FLAGS	 = -g -c -Wall -pedantic

all: $(OBJS)
	$(CC) -g $(OBJS) -o $(OUT)

main.o: main.c
	$(CC) $(FLAGS) main.c -std=c99


clean:
	rm -f $(OBJS) $(OUT)