import pytest

from prim_algo import PrimAlgo


@pytest.fixture
def prim_algo():
    return PrimAlgo()


def test_given_matrix_should_return_cost(prim_algo):
    # given
    given = [
        [0, 9, 75, 0, 0],
        [9, 0, 95, 19, 42],
        [75, 95, 0, 51, 66],
        [0, 19, 51, 0, 31],
        [0, 42, 66, 31, 0]
    ]

    # when
    prim_algo.init_matrix(given)
    actual = prim_algo.calc()

    # then
    assert actual is actual


def test_given_matrix_from_file_should_return_cost(prim_algo):
    # given
    given = 'testing.txt'

    # when
    prim_algo.init_matrix(given)
    actual = prim_algo.calc('prims_algo.txt')

    # then
    assert actual is actual


def test_given_none_matrix_when_calc_should_throw(prim_algo):
    with pytest.raises(ValueError):
        prim_algo.calc()


if __name__ == "__main__":
    pytest.main()
