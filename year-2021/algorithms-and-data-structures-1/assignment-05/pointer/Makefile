OBJS	= main.o
SOURCE	= main.cpp
HEADER	= PointerBasedQueue.hpp
OUT	= ex5PointerBased
CC	 = g++
FLAGS	 = -g -c -Wall

all: $(OBJS)
	clear
	$(CC) -g $(OBJS) -o $(OUT) $(LFLAGS)

main.o: main.cpp
	$(CC) $(FLAGS) main.cpp 


clean:
	clear
	rm -f $(OBJS) $(OUT)