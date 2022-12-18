## ZADANIE 10.2 (STACK)

Poprawić implementację tablicową stosu tak, aby korzystała z wyjątków w przypadku pojawienia się błędu. Metoda pop() ma
zgłaszać błąd w przypadku pustego stosu. Metoda push() ma zgłaszać błąd w przypadku przepełnienia stosu. Napisać kod
testujący stos.

## ZADANIE 10.8 (RANDOMQUEUE)

Stworzyć ADT w postaci kolejki losowej, z której elementy będą pobierane w losowej kolejności. Zadbać o to, aby każda
operacja była wykonywana w stałym czasie, niezależnie od liczby elementów w kolejce.

class RandomQueue:

    def __init__(self): pass

    def insert(self, item): pass   # wstawia element w czasie O(1)

    def remove(self): pass   # zwraca losowy element w czasie O(1)

    def is_empty(self): pass

    def is_full(self): pass

    def clear(self): pass   # czyszczenie listy
