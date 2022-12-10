import pytest

from single_list import SingleList, Node


@pytest.fixture
def cyc_list():
    return SingleList()


def test_head(cyc_list):
    # given
    given = [Node(data=i) for i in range(3)]
    # when
    for node in given:
        cyc_list.insert_head(node)
    # then
    assert cyc_list.is_empty() is False
    assert cyc_list.__len__() is 3


if __name__ == "__main__":
    pytest.main()
