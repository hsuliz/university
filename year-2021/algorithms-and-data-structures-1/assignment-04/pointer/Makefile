 OBJS	= ex4Pointer.o
SOURCE	= ex4Pointer.cpp
HEADER	= PointerStack.hpp LinkedList.hpp
OUT	= ex4Pointer
CC	 = g++
FLAGS	 = -g -c -Wall

all: $(OBJS)
	$(CC) -g $(OBJS) -o $(OUT) $(LFLAGS)

ex4Pointer.o: ex4Pointer.cpp
	$(CC) $(FLAGS) ex4Pointer.cpp 


clean:
	rm -f $(OBJS) $(OUT)