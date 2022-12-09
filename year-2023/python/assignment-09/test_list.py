import pytest

from cyclic_list import CyclicList
from node import Node


@pytest.fixture
def cyc_list():
    return CyclicList()


def test_head(cyc_list):
    # given
    given = [Node(i) for i in range(5)]
    # when
    cyc_list.insert_head(given)


if __name__ == "__main__":
    pytest.main()
