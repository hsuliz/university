OBJS	= main.o set_list.o
SOURCE	= main.cpp set_list.cpp
HEADER	= set_list.h
OUT	= ex1_list
CC	 = g++
FLAGS	 = -g -c -Wall
LFLAGS	 = 

all: $(OBJS)
	$(CC) -g $(OBJS) -o $(OUT) $(LFLAGS)

main.o: main.cpp
	$(CC) $(FLAGS) main.cpp 

set_list.o: set_list.cpp
	$(CC) $(FLAGS) set_list.cpp 


clean:
	rm -f $(OBJS) $(OUT)