OBJS	= matrix_graph_tests.o graph.o
SOURCE	= matrix_graph_tests.cpp graph.cpp
HEADER	= graph.h
OUT	= ex_3_matrix
CC	 = g++
FLAGS	 = -g -c -Wall
LFLAGS	 = 

all: $(OBJS)
	$(CC) -g $(OBJS) -o $(OUT) $(LFLAGS)

matrix_graph_tests.o: matrix_graph_tests.cpp
	$(CC) $(FLAGS) matrix_graph_tests.cpp -std=c++14

graph.o: graph.cpp
	$(CC) $(FLAGS) graph.cpp -std=c++14


clean:
	rm -f $(OBJS) $(OUT)