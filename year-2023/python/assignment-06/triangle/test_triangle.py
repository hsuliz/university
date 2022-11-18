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

area_list = [
    ([2, 1, 5, 5, -4, 3], 15),
    ([5, 5, 0, 0, 4, -8], 30),
    ([-3, -1, -7, -3, -1, -9], 18),
    ([4, 0, -9, 2, 4, 5], 32.5),
]


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

    def test_area(self):
        for t1, expected in area_list:
            with self.subTest(
                    msg="given triangle " + t1.__str__() +
                        " should return " + expected.__str__()
            ):
                self.assertEqual(
                    expected,
                    self.list_constructor(t1)
                    .area()
                )

    @staticmethod
    def list_constructor(t1):
        return t.Triangle(t1[0], t1[1], t1[2], t1[3], t1[4], t1[5])


if __name__ == '__main__':
    unittest.main()
