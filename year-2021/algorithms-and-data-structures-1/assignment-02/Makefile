OBJS	= main.o ArrayList.o Fun.o
SOURCE	= main.cpp ArrayList.cpp Fun.cpp
HEADER	= List.h ArrayList.h Fun.h
OUT	= ex2
CC	 = g++
FLAGS	 = -g -c -Wall
LFLAGS	 = 

all: $(OBJS)
	$(CC) -g $(OBJS) -o $(OUT) $(LFLAGS)

main.o: main.cpp
	$(CC) $(FLAGS) main.cpp 

ArrayList.o: ArrayList.cpp
	$(CC) $(FLAGS) ArrayList.cpp 

Fun.o: Fun.cpp
	$(CC) $(FLAGS) Fun.cpp 


clean:
	rm -f $(OBJS) $(OUT)