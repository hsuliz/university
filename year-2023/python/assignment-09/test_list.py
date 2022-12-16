import pytest

from single_list import SingleList, Node


@pytest.fixture
def single_list():
    return SingleList()


@pytest.fixture
def single_list_2():
    return SingleList()


def test_remove_tail(single_list):
    with pytest.raises(ValueError):
        single_list.remove_tail()

    # given
    for i in range(1, 4):
        single_list.insert_head(Node(i))
    single_list.insert_tail(Node(5))
    # when
    single_list.remove_tail()
    # then
    assert single_list.count() is 3
    assert single_list.tail.data == 1


def test_join(single_list, single_list_2):
    # given
    for i in range(1, 5):
        single_list.insert_tail(Node(i))
    single_list.insert_tail(Node(5))

    for i in range(6, 10):
        single_list_2.insert_tail(Node(i))
    single_list_2.insert_tail(Node(10))
    # when
    single_list.join(single_list_2)
    # then
    assert single_list.count() is 10
    assert single_list_2.is_empty()


def test_join_non_empty_to_empty_list(single_list, single_list_2):
    # given
    single_list.insert_tail(Node(1))
    single_list.insert_tail(Node(2))
    assert single_list_2.is_empty() is True
    # when
    single_list_2.join(single_list)
    # then
    assert single_list_2.is_empty() is False
    assert single_list_2.length is 2


def test_join_empty_to_non_empty_list(single_list, single_list_2):
    # given
    single_list.insert_tail(Node(1))
    single_list.insert_tail(Node(2))
    assert single_list_2.is_empty()
    # when
    single_list.join(single_list_2)
    # then
    assert single_list.length is 2


def test_clean(single_list):
    # given
    for i in range(1, 5):
        single_list.insert_tail(Node(i))
    single_list.insert_tail(Node(5))
    # when
    single_list.clear()
    # then
    assert single_list.is_empty()
    assert single_list.length is 0
    assert single_list.head is None
    assert single_list.tail is None


if __name__ == "__main__":
    pytest.main()
