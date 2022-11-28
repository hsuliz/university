import math

from point import Point


class Circle:

    def __init__(self, x, y, radius):
        if radius < 0:
            raise ValueError("Radius is negative!!")
        self.pt = Point(x, y)
        self.radius = radius

    def __repr__(self):
        return "Circle(" + str(self.pt.x) + ", " + str(self.pt.y) + ", " + str(self.radius) + ")"

    def __eq__(self, other):
        return self.pt == other.pt and self.radius == other.radius

    def __ne__(self, other):
        return not self == other

    def area(self):
        return (math.pi * math.pow(self.radius, 2)).__round__(2)

    def move(self, x, y):
        self.pt.x += x
        self.pt.y += y

    def cover(self, other):
        angle = math.atan2(
            other.pt.y - self.pt.y,
            other.pt.x - self.pt.x
        )
        a = Point(
            other.pt.x + math.cos(angle) * other.radius,
            (other.pt.y + math.sin(angle) * other.radius)
        )
        angle += math.pi
        b = Point(
            self.pt.x + math.cos(angle) * self.radius,
            (self.pt.y + math.sin(angle) * self.radius)
        )
        rad = math.pow(a.x - b.x, 2) + math.pow(a.y - b.y, 2)
        rad = math.sqrt(rad) / 2
        if rad < self.radius:
            return self
        elif rad < other.radius:
            return other
        else:
            return Circle(
                ((a.x + b.x) / 2).__round__(2),
                ((a.y + b.y) / 2).__round__(2),
                rad.__round__(2)
            )
