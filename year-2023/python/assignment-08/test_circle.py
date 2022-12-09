import unittest

from circle import Circle
from point import Point


class TestFromPoints(unittest.TestCase):
    def test_if_init(self):
        c = Circle.from_points((
            Point(2, 3),
            Point(3, 5),
            Point(4, 5)
        ))
        print(c.__repr__())
        print(c.top_right)


if __name__ == '__main__':
    unittest.main()
