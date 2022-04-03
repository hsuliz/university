OBJS	= list_graph_tests.o graph.o
SOURCE	= list_graph_tests.cpp main.cpp graph.cpp
HEADER	= graph.h
OUT	= ex_3_list.out
CC	 = g++
FLAGS	 = -g -c -Wall

all: $(OBJS)
	$(CC) -g $(OBJS) -o $(OUT) $(LFLAGS)

list_graph_tests.o: list_graph_tests.cpp
	$(CC) $(FLAGS) list_graph_tests.cpp -std=c++14

graph.o: graph.cpp
	$(CC) $(FLAGS) graph.cpp -std=c++14


clean:
	rm -f $(OBJS) $(OUT)
