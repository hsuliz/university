#!/usr/bin/python3
# Hlib-Oleksandr Suliz, Script Language, group no.2

import sys

from prim_algo import PrimAlgorithm


def print_help():
    """Prints the help message with an example matrix format and program description."""
    help_message = """
This program finds the minimum spanning tree (MST) of a graph represented by an adjacency matrix.
The graph should be connected, and the matrix should represent the weights of the edges between vertices,
with 0s indicating no direct path between two vertices.

Usage: main.py [options]

Options:
  --file FILE         Path to the file containing the adjacency matrix.
                      The matrix should be in the following format:
                      0 9 75 0 0
                      9 0 95 19 42
                      75 95 0 51 66
                      0 19 51 0 31
                      0 42 66 31 0
                      Each row represents the connections of a vertex to others,
                      with the value indicating the weight of the edge (or 0 for no edge).
  --output OUTPUT     Optional: Path to the output file to save the minimum
                      spanning tree matrix. The output matrix represents the MST with the same format.
  --help              Show this help message and exit.

Example:
  python main.py --file path/to/matrix.txt --output path/to/output.txt

The program reads an adjacency matrix from the specified file, computes the MST using Prim's algorithm,
and optionally saves the MST to a specified output file. It can also print the MST to the console.
"""
    print(help_message)


if __name__ == '__main__':
    if '--help' in sys.argv or '-h' in sys.argv or len(sys.argv) == 1:
        print_help()
        sys.exit()

    file_path = None
    output_path = None

    try:
        file_index = sys.argv.index('--file') + 1
        file_path = sys.argv[file_index]
    except (ValueError, IndexError):
        print("Error: '--file' argument not provided correctly.")
        sys.exit(1)

    if '--output' in sys.argv:
        try:
            output_index = sys.argv.index('--output') + 1
            output_path = sys.argv[output_index]
        except (ValueError, IndexError):
            print("Warning: '--output' argument not provided correctly. Proceeding without output file.")

    try:
        prim_algo = PrimAlgorithm()
        prim_algo.init_matrix(file_path)
        mst = prim_algo.calc(to_file=output_path)

        print("Minimum Spanning Tree:")
        prim_algo.print_mst_matrix()

        if output_path:
            print(f"Output saved to {output_path}")
    except Exception as e:
        print(f"Error: {e}")
