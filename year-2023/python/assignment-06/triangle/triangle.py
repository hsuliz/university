from points.point import Point


class Triangle:

    def __init__(self, x1, y1, x2, y2, x3, y3):
        self.pt1 = Point(x1, y1)
        self.pt2 = Point(x2, y2)
        self.pt3 = Point(x3, y3)

    def __str__(self):
        return "[" + str(self.pt1) + ", " + str(self.pt2) + ", " + str(self.pt3) + "]"

    def __repr__(self):
        return "Triangle(" \
               + str(self.pt1.x) + ", " + str(self.pt1.y) + ", " \
               + str(self.pt2.x) + ", " + str(self.pt2.y) + ", " \
               + str(self.pt3.x) + ", " + str(self.pt3.y) + ")"

    def __eq__(self, other):
        x = self.to_list()
        y = other.to_list()
        x.sort(), y.sort()
        return x == y

    def __ne__(self, other):  # obsługa tr1 != tr2
        return not self == other

    def center(self):
        x = (self.pt1.x + self.pt2.x + self.pt3.x) / 3
        y = (self.pt1.y + self.pt2.y + self.pt3.y) / 3
        return Point(x, y)

    def area(self): pass  # pole powierzchni

    def move(self, x, y): pass  # przesunięcie o (x, y)

    def to_list(self):
        return [
            (self.pt1.x, self.pt1.y),
            (self.pt2.x, self.pt2.y),
            (self.pt3.x, self.pt3.y),
        ]
