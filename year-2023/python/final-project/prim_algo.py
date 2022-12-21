from sys import maxsize as INF_NUMBER


class PrimAlgo:

    def __init__(self, matrix=None):
        if matrix is None:
            return

        self._G = matrix
        self._V = len(matrix)

    def init_matrix(self, matrix):
        self.__init__(matrix)

    def calc(self):
        if self._G is None:
            raise ValueError("Matrix is empty!!")

        visited = [False] * len(self._G)
        visited[0] = True
        cost = edge_quantity = 0

        while edge_quantity < self._V - 1:
            minimum = INF_NUMBER
            v = 0
            w = 0
            for i in range(self._V):
                if visited[i]:
                    for j in range(self._V):
                        if (not visited[j]) and self._G[i][j]:
                            if minimum > self._G[i][j]:
                                minimum = self._G[i][j]
                                v = i
                                w = j
            cost += self._G[v][w]
            visited[w] = True
            edge_quantity += 1
        return cost
