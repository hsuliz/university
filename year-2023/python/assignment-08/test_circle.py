import unittest

from circle import Circle
from point import Point


class TestFromPoints(unittest.TestCase):
    def test_if_init(self):
        c = Circle.from_points((
            Point(1, 0),
            Point(-1, 0),
            Point(0, 1)
        ))
        print(c.__repr__())
        print(c.top)
        print(c.left)
        print(c.bottom)
        print(c.right())



if __name__ == '__main__':
    unittest.main()
