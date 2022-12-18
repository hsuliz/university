import random


class RandomQueue:

    def __init__(self, size=10):
        if size < 0:
            raise ValueError("Queue size can't be negative!!")
        self._data = []
        self._size = size

    def insert(self, item):
        if self.is_full():
            raise ValueError("Im full!!")
        self._data += [item]

    def remove(self):
        if self.is_empty():
            raise ValueError("Im empty!!")
        length = len(self._data) - 1
        rand_number = random.randint(0, length)
        self._swap(length, rand_number)
        popped = self._data[length]
        del self._data[length]
        return popped

    def _swap(self, length, rand_number):
        self._data[length], self._data[rand_number], = self._data[rand_number], self._data[length]

    def is_empty(self):
        return len(self._data) == 0

    def is_full(self):
        return len(self._data) == self._size

    def clear(self):
        self._data = []
