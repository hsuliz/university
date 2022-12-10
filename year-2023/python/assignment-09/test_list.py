import pytest

from single_list import SingleList, Node


@pytest.fixture
def single_list():
    return SingleList()


def test_remove_tail(single_list):
    with pytest.raises(ValueError):
        single_list.remove_tail()

    # given
    for i in range(3):
        single_list.insert_head(Node(i))
    single_list.insert_tail(Node(5))
    # when
    actual = single_list.remove_tail()
    # then
    assert actual.data is Node(5).data
    assert single_list.count() is 3
    assert single_list.tail is None


if __name__ == "__main__":
    pytest.main()
