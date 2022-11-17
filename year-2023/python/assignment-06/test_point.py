import unittest

import point as p

eq_list = [
    (5, 5, True, "given equals numbers should ")
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
        # given
        x, y = 5, 5
        # when
        actual = p.Point(x, y).__eq__(p.Point(x, y))
        # then
        self.assertTrue(actual, msg="given same points should return true")

        # when
        actual = p.Point(x, y).__eq__(p.Point(-5, -5))
        # then
        self.assertFalse(actual, msg="given diff points should return false")



if __name__ == '__main__':
    unittest.main()
