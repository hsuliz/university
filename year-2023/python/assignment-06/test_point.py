import unittest

import point as p

eq_list = [
    ([5, 5], [5, 5], True),
    ([5, 5], [-5, 5], False),
    ([0, 0], [-0, -0], True),
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
            with self.subTest(p1=p1, p2=p2):
                self.assertEqual(
                    p.Point(p1[0], p1[1])
                    .__eq__(p.Point(p2[0], p2[1])),
                    expected
                )

    def test_ne(self):
        for p1, p2, expected in eq_list:
            with self.subTest(p1=p1, p2=p2):
                self.assertEqual(
                    p.Point(p1[0], p1[1])
                    .__ne__(p.Point(p2[0], p2[1])),
                    not expected
                )


if __name__ == '__main__':
    unittest.main()
