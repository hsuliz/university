OBJS	= main.o queue.o
SOURCE	= main.cpp queue.cpp
HEADER	= queue.h
OUT	= ex_2_out
CC	 = g++
FLAGS	 = -g -c -Wall
LFLAGS	 = 

all: $(OBJS)
	$(CC) -g $(OBJS) -o $(OUT) $(LFLAGS)

main.o: main.cpp
	$(CC) $(FLAGS) main.cpp 

queue.o: queue.cpp
	$(CC) $(FLAGS) queue.cpp 


clean:
	rm -f $(OBJS) $(OUT)