from sys import maxsize as INF_NUMBER

from parser import MatrixParser


class PrimAlgo:

    def __init__(self, matrix=None):
        if matrix is None:
            matrix = []
        self._G = matrix
        self._V = len(matrix)

    def init_matrix(self, path):
        if path is str:
            self.__init__(MatrixParser.scan(path))
            return
        self.__init__(path)

    def calc(self):
        if len(self._G) is 0:
            raise ValueError("Matrix is empty!!")
        out_matrix = []
        selected = [False] * len(self._G)
        selected[0] = True
        cost = edge_quantity = 0

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
            cost += self._G[v][w]
            print(v, w, self._G[v][w])
            selected[w] = True
            edge_quantity += 1
        return cost
