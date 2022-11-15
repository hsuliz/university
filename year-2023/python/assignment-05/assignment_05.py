import unittest

import fracs

add_list = [
    ([2, 4], [1, 4], [3, 4], "given with same denominator should return correct frac"),
    ([3, 8], [4, 8], [7, 8], "given with same denominator should return correct frac"),
    ([1, 2], [1, 3], [5, 6], "given with different denominator should return correct frac"),
    ([1, 3], [1, 1], [4, 3], "given with different denominator should return correct frac"),
    ([0, 3], [1, 1], [3, 3], "given with strange numerator should return correct frac"),
    ([1, 3], [1, 0], -1, "given with strange denominator should return -1"),
]

sub_list = [
    ([2, 4], [1, 4], [1, 4], "given with same denominator should return correct frac"),
    ([1, 4], [2, 4], [-1, 4], "given with same denominator should return correct frac"),
    ([1, 3], [1, 2], [-1, 6], "given with different denominator should return correct frac"),
    ([1, 3], [1, 1], [-2, 3], "given with different denominator should return correct frac"),
    ([0, 3], [1, 1], [-3, 3], "given with strange numerator should return correct frac"),
    ([1, 3], [1, 0], -1, "given with strange denominator should return -1"),
]


class TestFractions(unittest.TestCase):

    def setUp(self):
        self.zero = [0, 1]

    def test_add_frac(self):
        for p1, p2, expected, test_descr in add_list:
            with self.subTest(msg=test_descr, p1=p1, p2=p2, expected=expected):
                self.assertEqual(fracs.add_frac(p1, p2), expected)

    def test_sub_frac(self):
        for p1, p2, expected, test_descr in sub_list:
            with self.subTest(msg=test_descr, p1=p1, p2=p2, expected=expected):
                self.assertEqual(fracs.sub_frac(p1, p2), expected)

    def test_mul_frac(self):
        pass

    def test_div_frac(self):
        pass

    def test_is_positive(self):
        pass

    def test_is_zero(self):
        pass

    def test_cmp_frac(self):
        pass

    def test_frac2float(self):
        pass

    def tearDown(self):
        pass


if __name__ == '__main__':
    unittest.main()  # uruchamia wszystkie testy
