from math import cos, sin, hypot

from point import Point


class Circle:

    def __init__(self, x, y, radius):
        if radius < 0:
            raise ValueError("Radius is negative!!")
        self.pt = Point(x, y)
        self.radius = radius

    def __eq__(self, other):
        return self.pt == other.pt and self.radius == other.radius

    @property
    def top(self):
        return self.pt.y + self.radius

    @property
    def left(self):
        return self.pt.x - self.radius

    @property
    def bottom(self):
        return self.pt.y - self.radius

    @property
    def right(self):
        return self.pt.x + self.radius

    # width and height in circle are the same,
    # so just using diameter
    @property
    def diameter(self):
        return self.radius * 2

    @property
    def top_left(self):
        return Point(
            round(self.pt.x + self.radius * cos(135)),
            round(self.pt.y + self.radius * sin(135))
        )

    @property
    def bottom_left(self):
        return Point(
            round(self.pt.x + self.radius * cos(225)),
            round(self.pt.y + self.radius * sin(225))
        )

    @property
    def top_right(self):
        return Point(
            round(self.pt.x + self.radius * cos(45)),
            round(self.pt.y + self.radius * sin(45))
        )

    @property
    def bottom_right(self):
        return Point(
            round(self.pt.x + self.radius * cos(315)),
            round(self.pt.y + self.radius * sin(315))
        )

    @staticmethod
    def from_points(points):
        x1, y1 = points[0].x, points[0].y
        x2, y2 = points[1].x, points[1].y
        x3, y3 = points[2].x, points[2].y

        a = x1 * (y2 - y3) - y1 * (x2 - x3) + x2 * y3 - x3 * y2
        b = (x1 * x1 + y1 * y1) * (y3 - y2) + (x2 * x2 + y2 * y2) * (y1 - y3) + (x3 * x3 + y3 * y3) * (y2 - y1)
        c = (x1 * x1 + y1 * y1) * (x2 - x3) + (x2 * x2 + y2 * y2) * (x3 - x1) + (x3 * x3 + y3 * y3) * (x1 - x2)

        try:
            x = round(-b / (2 * a))
            y = round(-c / (2 * a))
        except ZeroDivisionError:
            raise Exception("You gave me same points!!")

        r = round(hypot(x - x1, y - y1))

        return Circle(x, y, r)
