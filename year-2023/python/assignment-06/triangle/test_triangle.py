import unittest

import triangle as t


class MyTestCase(unittest.TestCase):

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


if __name__ == '__main__':
    unittest.main()
