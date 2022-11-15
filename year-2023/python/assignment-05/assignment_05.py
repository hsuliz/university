import unittest

import fracs

add_list = [
    ([2, 4], [1, 4], [3, 4], "given with same denominator should return correct frac"),
    ([3, 8], [4, 8], [7, 8], "given with same denominator should return correct frac"),
    ([1, 2], [1, 3], [5, 6], "given with different denominator should return correct frac"),
    ([1, 3], [1, 1], [4, 3], "given with different denominator should return correct frac"),
    ([0, 3], [1, 1], [3, 3], "given with strange numerator should return correct frac"),
    ([1, 3], [1, 0], "Error!!", "given with strange denominator should return error"),
]

sub_list = [
    ([2, 4], [1, 4], [1, 4], "given with same denominator should return correct frac"),
    ([1, 4], [2, 4], [-1, 4], "given with same denominator should return correct frac"),
    ([1, 3], [1, 2], [-1, 6], "given with different denominator should return correct frac"),
    ([1, 3], [1, 1], [-2, 3], "given with different denominator should return correct frac"),
    ([0, 3], [1, 1], [-3, 3], "given with strange numerator should return correct frac"),
    ([1, 3], [1, 0], "Error!!", "given with strange denominator should return error"),
]

mul_list = [
    ([1, 2], [2, 5], [2, 10], "given frac should return correct frac"),
    ([2, 5], [3, -5], [6, -25], "given frac should return correct frac"),
    ([4, -7], [2, -5], [8, 35], "given frac should return correct frac"),
    ([-4, 7], [2, 5], [-8, 35], "given frac should return correct frac"),
    ([-4, -7], [-2, -5], [8, 35], "given frac should return correct frac"),
    ([0, 2], [8, 3], [0, 6], "given frac with 0 should return correct frac"),
    ([1, 3], [1, 0], "Error!!", "given with strange denominator should return error"),
]

div_list = [
    ([1, 4], [5, 4], [4, 20], "given frac should return correct frac"),
    ([2, 5], [3, -5], [-10, 15], "given frac should return correct frac"),
    ([2, 5], [3, -5], [-10, 15], "given frac should return correct frac"),
    ([-4, -7], [-2, -5], [20, 14], "given frac should return correct frac"),
    ([1, 3], [1, 0], "Error!!", "given with strange denominator should return error"),
    ([0, 2], [8, 3], [0, 16], "given frac with 0 should return correct frac"),
]

pos_list = [
    ([1, 4], True, "given frac should return true"),
    ([-1, 4], False, "given frac should return false"),
    ([1, -4], False, "given frac should return false"),
    ([-1, -4], True, "given frac should return true"),
    ([0, -4], False, "given frac should return true"),
    ([2, 0], "Error!!", "given with strange denominator should return error"),
]

zero_list = [
    ([1, 4], False, "given frac should return false"),
    ([0, 1], True, "given frac should return true"),
    ([2, 0], "Error!!", "given with strange denominator should return error"),
]

cmp_list = [
    ([1, 4], [5, 4], -1, "given frac should return -1"),
    ([1, 4], [-5, 4], 1, "given frac should return 1"),
    ([1, 1], [2, 2], 0, "given frac should return 0"),
    ([1, 3], [1, 0], "Error!!", "given with strange denominator should return -1"),
]

float_list = [
    ([-1, 2], -0.5, "given frac should return correct float"),
    ([1, -2], -0.5, "given frac should return correct float"),
    ([3, 1], 3, "given frac should return correct float"),
    ([0, 3], 0, "given frac should return correct float"),
    ([6, 2], 3, "given frac should return correct float"),
    ([2, 0], "Error!!", "given with strange denominator should return error"),
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
        for p1, p2, expected, test_descr in mul_list:
            with self.subTest(msg=test_descr, p1=p1, p2=p2, expected=expected):
                self.assertEqual(fracs.mul_frac(p1, p2), expected)

    def test_div_frac(self):
        for p1, p2, expected, test_descr in div_list:
            with self.subTest(msg=test_descr, p1=p1, p2=p2, expected=expected):
                self.assertEqual(fracs.div_frac(p1, p2), expected)

    def test_is_positive(self):
        for p1, expected, test_descr in pos_list:
            with self.subTest(msg=test_descr, p1=p1, expected=expected):
                self.assertEqual(fracs.is_positive(p1), expected)

    def test_is_zero(self):
        for p1, expected, test_descr in zero_list:
            with self.subTest(msg=test_descr, p1=p1, expected=expected):
                self.assertEqual(fracs.is_zero(p1), expected)

    def test_cmp_frac(self):
        for p1, p2, expected, test_descr in cmp_list:
            with self.subTest(msg=test_descr, p1=p1, p2=p2, expected=expected):
                self.assertEqual(fracs.cmp_frac(p1, p2), expected)

    def test_frac2float(self):
        for p1, expected, test_descr in float_list:
            with self.subTest(msg=test_descr, p1=p1, expected=expected):
                self.assertEqual(fracs.frac2float(p1), expected)

    def tearDown(self):
        pass


if __name__ == '__main__':
    unittest.main()
