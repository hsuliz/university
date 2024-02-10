from sys import maxsize as INF_NUMBER

from parser import MatrixParser


class PrimAlgorithm:
    """Class for compute Prim's algorithm using adjacency matrix.

    This class can get input from file and write solution to another file.
    This class using MatrixParser for matrix serialization, which you can
    find in parser.py.

    If you want import matrix from file, it should look like this:
    0 1 2
    5 0 6
    9 1 0

    """

    def __init__(self, matrix=None):
        """Constructor

        Args:
            matrix (list, optional): Matrix should be NxN. Default to None.

        Returns:
            None

        """
        self.out_matrix = None
        if matrix is None:
            matrix = []
        self._G = matrix
        self._V = len(matrix)

    def init_matrix(self, matrix):
        """Matrix initialization
        Uses MatrixParses class for scan matrix from file

        Args:
            matrix(list || str): Matrix should be NxN. User can directly in provide matrix as list,
                or provide path to file with matrix.

        Returns:
            None

        """
        if isinstance(matrix, str):
            self.__init__(MatrixParser.scan(matrix))
        else:
            self.__init__(matrix)

    def calc(self, to_file=None):
        """Minimum spanning tree finder.
        Time complexity O(V^2)

        Args:
            to_file(str, optional): Name of output file.

        Returns:
            list: Minimum spanning tree as matrix NxN.
                If to_file not None create a file with output.

        """
        if len(self._G) == 0:
            raise ValueError("Matrix is empty!!")
        if not self.is_graph_connected(self._G):
            raise ValueError("Graph should be connected!")
        self.out_matrix = [[0 for _ in range(len(self._G))] for _ in range(len(self._G))]
        selected = [False] * len(self._G)
        selected[0] = True
        edge_quantity = 0

        while edge_quantity < self._V - 1:
            minimum = INF_NUMBER
            v = 0
            w = 0
            for i in range(self._V):
                if selected[i]:
                    for j in range(self._V):
                        if (not selected[j]) and self._G[i][j]:
                            if minimum > self._G[i][j]:
                                minimum = self._G[i][j]
                                v = i
                                w = j
            self.out_matrix[v][w] = self._G[v][w]
            self.out_matrix[w][v] = self._G[v][w]
            selected[w] = True
            edge_quantity += 1
        if to_file is not None:
            MatrixParser.write_to_file(self.out_matrix, to_file)
        return self.out_matrix

    def print_mst_matrix(self):
        """Prints Minimum spanning tree as matrix"""
        self.__print_as_matrix(self.out_matrix)

    def print_calc_matrix(self):
        """Prints input matrix"""
        self.__print_as_matrix(self._G)

    @staticmethod
    def __print_as_matrix(matrix):
        for line in matrix:
            for number in line:
                print(number, end='  ')
            print()

    @staticmethod
    def is_graph_connected(matrix):
        n = len(matrix)
        visited = [False] * n

        def dfs(v):
            visited[v] = True
            for i, edge in enumerate(matrix[v]):
                if edge > 0 and not visited[i]:
                    dfs(i)

        dfs(0)
        return all(visited)
