OBJS	= ex3.o
SOURCE	= ex3.cpp
HEADER	= LinkedList.hpp
OUT	= ex3
CC	 = g++
FLAGS	 = -g -c -Wall
LFLAGS	 = 

all: $(OBJS)
	$(CC) -g $(OBJS) -o $(OUT) $(LFLAGS)

ex3.o: ex3.cpp
	$(CC) $(FLAGS) ex3.cpp 


clean:
	rm -f $(OBJS) $(OUT)