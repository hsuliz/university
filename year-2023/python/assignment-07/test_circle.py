import unittest

from circle import Circle

eq_list = [
    (Circle(1, 1, 1), Circle(1, 1, 1), True),
    (Circle(1, 2, 1), Circle(2, 1, 1), False),
    (Circle(1, 1, 1), Circle(1, 1, 2), False),
]


class TestCircle(unittest.TestCase):

    def test_init_given_negative_radius(self):
        # given, when, then
        with self.assertRaises(ValueError):
            Circle(1, 1, -1)

    def test_init_given_positive_radius(self):
        # given, when, then
        try:
            Circle(1, 1, 1)
        except ValueError:
            self.fail()

    def test_repr(self):
        # given, when
        given = (Circle(1, 1, 1).__repr__())
        # then
        self.assertEqual('Circle(1, 1, 1)', given)

    def test_eq(self):
        for c1, c2, expected in eq_list:
            with self.subTest(
                    'Given ' + c1.__repr__() + ' ' + c2.__repr__() +
                    ' should return ' + expected.__repr__()
            ):
                self.assertEqual(
                    c1.__eq__(c2),
                    expected
                )

    def test_ne(self):
        for c1, c2, expected in eq_list:
            with self.subTest(
                    'Given ' + c1.__repr__() + ' ' + c2.__repr__() +
                    ' should return ' + expected.__repr__()
            ):
                self.assertEqual(
                    c1.__ne__(c2),
                    not expected
                )

if __name__ == '__main__':
    unittest.main()
