from sys import maxsize as INF_NUMBER

from parser import MatrixParser


class PrimAlgorithm:

    def __init__(self, matrix=None):
        self.out_matrix = None
        if matrix is None:
            matrix = []
        self._G = matrix
        self._V = len(matrix)

    def init_matrix(self, matrix):
        if isinstance(matrix, str):
            self.__init__(MatrixParser.scan(matrix))
        else:
            self.__init__(matrix)

    def calc(self, to_file=None):
        if len(self._G) is 0:
            raise ValueError("Matrix is empty!!")
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
        self.__print_as_matrix(self.out_matrix)

    def print_calc_matrix(self):
        self.__print_as_matrix(self._G)

    @staticmethod
    def __print_as_matrix(matrix):
        for line in matrix:
            for number in line:
                print(number, end='  ')
            print()
