from collections import defaultdict


class Graph:

    # 2 types of init, by hands, and by file
    def __init__(self, vertices):
        self.graph = defaultdict(list)  # dictionary containing adjacency List
        self.V = 100
        # init from file
        with open(vertices) as file_in:
            for i in file_in:
                n1, n2 = (int(j) for j in i.split())
                self.add_edge(n1, n2)

    # function to add an edge to graph

    def add_edge(self, u, v):
        self.graph[u].append(v)

    def topologicalSortUtil(self, v, visited, stack):
        visited[v] = True
        for i in self.graph[v]:
            if not visited[i]:
                self.topologicalSortUtil(i, visited, stack)
        stack.insert(0, v)

    def topologicalSort(self):
        visited = [False] * self.V
        stack = []
        for i in range(self.V):
            if not visited[i]:
                self.topologicalSortUtil(i, visited, stack)

        print(stack)


def main():
    graph = Graph('tests/Graf2.txt')
    graph.topologicalSort()


if __name__ == '__main__':
    main()
