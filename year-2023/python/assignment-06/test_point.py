import unittest

import point as p

eq_list = [
    ([5, 5], [5, 5], True),
    ([5, 5], [-5, 5], False),
    ([0, 0], [-0, -0], True),
]

add_list = [
    ([5, 5], [5, 5], p.Point(10, 10)),
    ([2, 3], [-2, 1], p.Point(0, 4)),
    ([0, 0], [2, 2], p.Point(2, 2)),
]

sub_list = [
    ([5, 5], [5, 5], p.Point(0, 0)),
    ([7, 5], [-2, 2], p.Point(9, 3)),
    ([-2, -2], [-2, 2], p.Point(0, -4)),
]


class TestPoint(unittest.TestCase):

    def test_str(self):
        # given
        x, y = 5, 5
        # when
        actual = p.Point(x, y).__str__()
        # then
        self.assertEqual("(5, 5)", actual)

    def test_repr(self):
        # given
        x, y = 5, 5
        # when
        actual = p.Point(x, y).__repr__()
        # then
        self.assertEqual("Point(5, 5)", actual)

    def test_eq(self):
        for p1, p2, expected in eq_list:
            with self.subTest(
                    msg="given points " + p1.__str__() + " " + p2.__str__() +
                        " should return " + expected.__str__()
            ):
                self.assertEqual(
                    p.Point(p1[0], p1[1])
                    .__eq__(p.Point(p2[0], p2[1])),
                    not expected
                )

    def test_ne(self):
        for p1, p2, expected in eq_list:
            with self.subTest(
                    msg="given points " + p1.__str__() + " " + p2.__str__() +
                        " should return " + expected.__str__()
            ):
                self.assertEqual(
                    p.Point(p1[0], p1[1])
                    .__ne__(p.Point(p2[0], p2[1])),
                    not expected
                )

    def test_add(self):
        for p1, p2, expected in add_list:
            with self.subTest(
                    msg="given points " + p1.__str__() + " " + p2.__str__() +
                        " should return " + expected.__str__()
            ):
                self.assertEqual(
                    p.Point(p1[0], p1[1])
                    .__add__(p.Point(p2[0], p2[1])),
                    expected
                )

    def test_sub(self):
        for p1, p2, expected in sub_list:
            with self.subTest(
                    msg="given points " + p1.__str__() + " " + p2.__str__() +
                        " should return " + expected.__str__()
            ):
                self.assertEqual(
                    p.Point(p1[0], p1[1])
                    .__sub__(p.Point(p2[0], p2[1])),
                    expected
                )


if __name__ == '__main__':
    unittest.main()
