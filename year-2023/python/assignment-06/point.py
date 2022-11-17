class Point:

    def __init__(self, x, y):  # konstuktor
        self.x = x
        self.y = y

    def __str__(self) -> str:
        return "(" + str(self.x) + ", " + str(self.y) + ")"

    def __repr__(self) -> str:
        return "Point(" + str(self.x) + ", " + str(self.y) + ")"

    def __eq__(self, other) -> bool:
        return (self.x == other.x) and (self.y == other.y)

    def __ne__(self, other):  # obsługa point1 != point2
        return not self == other

    # Punkty jako wektory 2D.
    def __add__(self, other): pass  # v1 + v2

    def __sub__(self, other): pass  # v1 - v2

    def __mul__(self, other): pass  # v1 * v2, iloczyn skalarny, zwraca liczbę

    def cross(self, other):  # v1 x v2, iloczyn wektorowy 2D, zwraca liczbę
        return self.x * other.y - self.y * other.x

    def length(self): pass  # długość wektora

    def __hash__(self):
        return hash((self.x, self.y))  # bazujemy na tuple, immutable points
