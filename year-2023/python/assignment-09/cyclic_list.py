class CyclicList:

    def __init__(self):
        self.head = None

    def is_empty(self):
        return self.head is None

    def insert_head(self, node):
        if self.is_empty():
            self.head = node.data
        else:
            self.head = self.head.next
            self.head = node.data

    def insert_tail(self, node): pass

    def search(self, data):
        pass  # zwraca node lub None

    def remove(self, node): pass

    def join(self, other): pass  # scalanie dwóch list cyklicznych w czasie O(1)

    def clear(self): pass  # czyszczenie listy
