OBJS	= ex4Array.o
SOURCE	= ex4Array.cpp
HEADER	= ArrayStack.hpp
OUT	= ex4Array
CC	 = g++
FLAGS	 = -g -c -Wall

all: $(OBJS)
	$(CC) -g $(OBJS) -o $(OUT) $(LFLAGS)

ex4Array.o: ex4Array.cpp
	$(CC) $(FLAGS) ex4Array.cpp 


clean:
	rm -f $(OBJS) $(OUT)