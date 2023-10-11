# Dijkstra's Algorithm Program

This program implements Dijkstra's algorithm to find the shortest path in a graph. It takes an input file containing the
graph information and generates an output file with the shortest distances from vertex 1.

## Getting Started

### Prerequisites

- Fortran compiler (e.g., GNU Fortran)

### Compilation

To compile the program, use the following command:

```bash
 gfortran dijkstra.f95 -o DijkstraProgram
 ``` 

### Usage

Run the program by executing the compiled binary file with the following command:

```bash
./DijkstraProgram
```

The program will prompt you to enter the input filename and the output filename. If you want to generate the graph data
interactively, enter "NULL" as the input filename.

### Input File Format

If you choose to provide an input file, it should follow the following format:

```text
<num_vertices> <num_edges>
<j1> <k1> <vertex1>
<j2> <k2> <vertex2>
...
```

- `<num_vertices>`: Number of vertices in the graph
- `<num_edges>`: Number of edges in the graph
- `<j>`: Starting vertex of an edge
- `<k>`: Ending vertex of an edge
- `<vertex>`: Weight of the edge

See the provided example input file for reference:

```text
5 7
1 2 5
1 3 3
2 3 2
2 4 6
3 4 4
3 5 7
4 5 1
```

### Output

The program will generate an output file with the provided output filename.

##### Author

Hlib-Oleksandr Suliz
