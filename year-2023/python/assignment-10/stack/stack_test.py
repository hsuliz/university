import pytest

from stack import Stack


@pytest.fixture
def given_stack():
    return Stack(size=5)


@pytest.fixture
def given_full_stack():
    return Stack(size=0)


def test_push_should_push_element(given_stack):
    # given
    given = 2
    # when
    given_stack.push(given)
    # then
    assert given_stack.n is 1
    assert given_stack.items[0] is 2


def test_pop_should_pop_element(given_stack):
    # given
    expected = 5
    # when
    given_stack.push(expected)
    actual = given_stack.pop()
    # then
    assert actual is expected


def test_push_and_pop_should_throw(given_full_stack):
    with pytest.raises(ValueError):
        given_full_stack.push(2)
        given_full_stack.pop()


if __name__ == "__main__":
    pytest.main()
