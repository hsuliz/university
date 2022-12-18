from unittest import mock

import pytest

from random_queue import RandomQueue


@pytest.fixture
def default_queue():
    return RandomQueue()


@pytest.fixture
def empty_queue():
    return RandomQueue(size=0)


def test_init_given_negative_value():
    with pytest.raises(ValueError):
        RandomQueue(-1)


# test for is_empty, insert and is_full
def test_insert_10_elements_should_be_full(default_queue):
    # when
    is_empty = default_queue.is_empty()
    for i in range(10):
        default_queue.insert(10)
    # then
    assert default_queue.is_full()
    assert is_empty


def test_remove_should_remove_element(default_queue):
    # given
    expected = 3
    for i in range(6):
        default_queue.insert(i)
    # when
    with mock.patch('random.randint', lambda x, y: expected):
        actual = default_queue.remove()
    # then
    assert actual is expected


def test_insert_and_remove_should_throw(empty_queue):
    with pytest.raises(ValueError):
        empty_queue.insert(2)
    with pytest.raises(ValueError):
        empty_queue.remove()


if __name__ == "__main__":
    pytest.main()
