word = "abcdefg"
line = "roses are red violets are blue"


def ex_10(x):
    print("Exercise 10:")
    print(len(x.split(" ")))


def ex_11(x, y):
    print("Exercise 11:")
    print('_'.join(map(str, y)))
    print('_'.join(map(str, x)))


def ex_12(x):
    pass


if __name__ == '__main__':
    ex_10(line)
    ex_11(word, "a")
