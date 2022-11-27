import unittest

from circle import Circle


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


if __name__ == '__main__':
    unittest.main()
