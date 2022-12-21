from sys import maxsize as INF



def prim_algo():
    cost = 0

    G = [[INF, 2, INF, 6, INF],
         [2, INF, 3, 8, 5],
         [INF, 3, INF, INF, 7],
         [6, 8, INF, INF, 9],
         [INF, 5, 7, 9, INF]]

    V = len(G)

    visited = [False] * len(G)
    visited[0] = True

    no_edge = 0

    while no_edge < V - 1:
        minimum = INF
        x = 0
        y = 0
        for i in range(V):
            if visited[i]:
                for j in range(V):
                    if (not visited[j]) and G[i][j]:
                        if minimum > G[i][j]:
                            minimum = G[i][j]
                            x = i
                            y = j
        cost += G[x][y]
        visited[y] = True
        no_edge += 1
    return cost


if __name__ == '__main__':
    print(prim_algo())
