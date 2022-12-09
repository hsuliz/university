import pytest

from circle import Circle
from point import Point


@pytest.fixture
def given():
    return Circle(2, 3, 4)


def test_coordinates(given):
    assert given.top == 7
    assert given.left == -2
    assert given.bottom == -1
    assert given.right == 6


def test_diameter(given):
    assert given.diameter == given.radius * 2


def test_points(given):
    assert given.top_left == Point(-2, 3)
    assert given.bottom_left == Point(3, -1)
    assert given.top_right == Point(4, 6)
    assert given.bottom_right == Point(5, 6)


def test_from_points():
    points = (Point(3, 4), Point(8, 6), Point(7, 4))
    assert Circle.from_points(points).__eq__(Circle(5, 6, 3))


def test_from_points_should_throw():
    points = (Point(0, 0), Point(2, 2), Point(2, 2))
    with pytest.raises(Exception):
        Circle.from_points(points)
