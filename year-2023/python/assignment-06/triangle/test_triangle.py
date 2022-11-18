import unittest

import points.point as p
import triangle as t

eq_list = [
    ([1, 1, 2, 2, 3, 3], [1, 1, 2, 2, 3, 3], True),
    ([1, 1, 9, 2, 3, 3], [1, 1, 2, 2, 3, 3], False),
    ([3, 1, 2, 2, 9, -3], [2, 2, 3, 1, 9, -3], True),
]

center_list = [
    ([1, 0, 4, 1, 3, 5], p.Point(8 / 3, 2)),
    ([1, 0, -4, 1, -3, 5], p.Point(-2, 2)),
    ([0, 5, 0, -5, 0, -9], p.Point(0, -3)),
    ([0, 0, 0, 0, 0, 0], p.Point(0, 0)),
]


def list_decode(x):
    return x[0], x[1], x[2], x[3], x[4], x[5]


class TestTriangle(unittest.TestCase):

    def test_str(self):
        # given
        x = t.Triangle(2, 2, 3, 3, 4, 4)
        # when
        actual = x.__str__()
        # then
        self.assertEqual(
            "[(2, 2), (3, 3), (4, 4)]",
            actual
        )

    def test_repr(self):
        # given
        x = t.Triangle(2, 2, 3, 3, 4, 4)
        # when
        actual = x.__repr__()
        # then
        self.assertEqual(
            "Triangle(2, 2, 3, 3, 4, 4)",
            actual
        )

    def test_eq(self):
        for t1, t2, expected in eq_list:
            with self.subTest(
                    msg="given triangles " + t1.__str__() + " " + t2.__str__() +
                        " should return " + expected.__str__()
            ):
                self.assertEqual(
                    expected,
                    self.list_constructor(t1)
                    .__eq__(self.list_constructor(t2))
                )

    def test_ne(self):
        for t1, t2, expected in eq_list:
            with self.subTest(
                    msg="given triangles " + t1.__str__() + " " + t2.__str__() +
                        " should return " + expected.__str__()
            ):
                self.assertEqual(
                    not expected,
                    self.list_constructor(t1)
                    .__ne__(self.list_constructor(t2))
                )

    def test_center(self):
        for t1, expected in center_list:
            with self.subTest(
                    msg="given triangle " + t1.__str__() +
                        " should return " + expected.__str__()
            ):
                self.assertEqual(
                    expected,
                    self.list_constructor(t1)
                    .center()
                )

    @staticmethod
    def list_constructor(t1):
        return t.Triangle(t1[0], t1[1], t1[2], t1[3], t1[4], t1[5])


if __name__ == '__main__':
    unittest.main()