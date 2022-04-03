OBJS	= main.o set_arr.o
SOURCE	= main.cpp set_arr.cpp
HEADER	= set_arr.h
OUT	= ex1_list
CC	 = g++
FLAGS	 = -g -c -Wall
LFLAGS	 = 

all: $(OBJS)
	$(CC) -g $(OBJS) -o $(OUT) $(LFLAGS)

main.o: main.cpp
	$(CC) $(FLAGS) main.cpp 

set_arr.o: set_arr.cpp
	$(CC) $(FLAGS) set_arr.cpp 


clean:
	rm -f $(OBJS) $(OUT)