import time

import pytest

from prim_algo import PrimAlgorithm


@pytest.fixture(autouse=True)
def prim_algorithm():
    return PrimAlgorithm()


def test_given_matrix_should_return_matrix(prim_algorithm):
    # given
    given = [
        [0, 9, 75, 0, 0],
        [9, 0, 95, 19, 42],
        [75, 95, 0, 51, 66],
        [0, 19, 51, 0, 31],
        [0, 42, 66, 31, 0]
    ]
    # when
    prim_algorithm.init_matrix(given)
    actual = prim_algorithm.calc()
    # then
    expected = [
        [0, 9, 0, 0, 0],
        [9, 0, 0, 19, 0],
        [0, 0, 0, 51, 0],
        [0, 19, 51, 0, 31],
        [0, 0, 0, 31, 0]]
    assert actual == expected


def test_given_matrix_from_file_should_return_matrix_and_safe_to_file(prim_algorithm):
    # given, when
    prim_algorithm.init_matrix('test_matrix_in.txt')
    actual = prim_algorithm.calc('test_matrix_out.txt')
    # then
    expected = [
        [0, 9, 0, 0, 0],
        [9, 0, 0, 19, 0],
        [0, 0, 0, 51, 0],
        [0, 19, 51, 0, 31],
        [0, 0, 0, 31, 0]]
    assert actual == expected
    time.sleep(3)  # wait for out file
    prim_algorithm.init_matrix('test_matrix_out.txt')
    actual = prim_algorithm.calc()
    # then
    assert actual == expected


def test_given_none_matrix_when_calc_should_throw(prim_algorithm):
    with pytest.raises(ValueError):
        prim_algorithm.calc()


if __name__ == "__main__":
    pytest.main()
