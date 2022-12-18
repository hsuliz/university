from unittest import mock

import pytest

from random_queue import RandomQueue


@pytest.fixture
def given_queue():
    return RandomQueue()


@pytest.fixture
def given_empty_queue():
    return RandomQueue(size=0)


def test_init_given_negative_value():
    with pytest.raises(ValueError):
        RandomQueue(-1)


# test for is_empty, insert and is_full
def test_insert_10_elements_should_be_full(given_queue):
    # when
    is_empty = given_queue.is_empty()
    for i in range(10):
        given_queue.insert(10)
    # then
    assert given_queue.is_full()
    assert is_empty


def test_remove_should_remove_element(given_queue):
    # given
    expected = 3
    for i in range(6):
        given_queue.insert(i)
    # when
    with mock.patch('random.randint', lambda x, y: expected):
        actual = given_queue.remove()
    # then
    assert actual is expected


def test_insert_and_remove_should_throw(given_empty_queue):
    with pytest.raises(ValueError):
        given_empty_queue.insert(2)
    with pytest.raises(ValueError):
        given_empty_queue.remove()


if __name__ == "__main__":
    pytest.main()
