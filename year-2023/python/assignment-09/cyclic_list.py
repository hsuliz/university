class CyclicList:

    def __init__(self):
        self.head = None  # łącze do dowolnego węzła listy
        # nie potrzeba mieć self.tail

    def is_empty(self):
        return self.head is None

    def insert_head(self, node): pass

    def insert_tail(self, node): pass

    def search(self, data):
        pass  # zwraca node lub None

    def remove(self, node): pass

    def join(self, other): pass  # scalanie dwóch list cyklicznych w czasie O(1)

    def clear(self): pass  # czyszczenie listy
