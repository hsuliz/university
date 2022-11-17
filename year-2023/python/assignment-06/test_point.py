import unittest

import point as p

points_list = []


class TestPoint(unittest.TestCase):

    def test_str(self):
        # given
        x, y = 5, 5
        # when
        actual = p.Point(x, y).__str__()
        # then
        self.assertEqual("(5, 5)", actual)


if __name__ == '__main__':
    unittest.main()
