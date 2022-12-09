from math import sqrt, cos, sin

from point import Point


class Circle:

    def __init__(self, x, y, radius):
        if radius < 0:
            raise ValueError("Radius is negative!!")
        self.pt = Point(x, y)
        self.radius = radius

    def __repr__(self):
        return "Circle(" + str(self.pt.x) + ", " + str(self.pt.y) + ", " + str(self.radius) + ")"

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

    # width and height in circle is the same,
    # so just using diameter
    @property
    def diameter(self):
        return self.radius * 2

    @property
    def top_left(self):
        return Point(
            round(self.pt.x + self.radius * cos(135), 3),
            round(self.pt.y + self.radius * sin(135), 3)
        )

    @property
    def bottom_left(self):
        return Point(
            round(self.pt.x + self.radius * cos(225), 3),
            round(self.pt.y + self.radius * sin(225), 3)
        )

    @property
    def top_right(self):
        return Point(
            round(self.pt.x + self.radius * cos(45), 3),
            round(self.pt.y + self.radius * sin(45), 3)
        )

    @property
    def bottom_right(self):
        return Point(
            round(self.pt.x + self.radius * cos(315), 3),
            round(self.pt.y + self.radius * sin(315), 3)
        )

    @staticmethod
    def from_points(point_list):
        x1 = point_list[0].x
        x2 = point_list[1].x
        x3 = point_list[2].x

        y1 = point_list[0].y
        y2 = point_list[1].y
        y3 = point_list[2].y

        x12 = x1 - x2
        x13 = x1 - x3
        y12 = y1 - y2
        y13 = y1 - y3
        y31 = y3 - y1
        y21 = y2 - y1
        x31 = x3 - x1
        x21 = x2 - x1

        sx13 = pow(x1, 2) - pow(x3, 2)
        sy13 = pow(y1, 2) - pow(y3, 2)
        sx21 = pow(x2, 2) - pow(x1, 2)
        sy21 = pow(y2, 2) - pow(y1, 2)

        f = ((sx13 * x12 + sy13 *
              x12 + sx21 * x13 +
              sy21 * x13) // (2 * (y31 * x12 - y21 * x13)))

        g = ((sx13 * y12 + sy13 * y12 +
              sx21 * y13 + sy21 * y13) //
             (2 * (x31 * y12 - x21 * y13)))

        c = (-pow(x1, 2) - pow(y1, 2) -
             2 * g * x1 - 2 * f * y1)

        h = -g
        k = -f
        sqr_of_r = h * h + k * k - c
        radius = sqrt(sqr_of_r)

        return Circle(h, k, radius)
